# Fine-Tune the model

Since we have a shortlist of promising models, it's
time to fine-tune the model. GridSearchCV can help us
for this task. We just need to give it a list of
hyperparameters to experiment, it will evaluate
all combinations of these hyperparameter values during
cross-validation.

## Fine-Tune the model with GridSearchCV

```python
from sklearn.model_selection import GridSearchCV

param_grid = [
    # try 12 (3×4) combinations of hyperparameters
    {'n_estimators': [3, 10, 30], 'max_features': [2, 4, 6, 8]},
    # then try 6 (2×3) combinations with bootstrap set as False
    {'bootstrap': [False], 'n_estimators': [3, 10], 'max_features': [2, 3, 4]},
  ]

forest_reg = RandomForestRegressor(random_state=42)
# train across 5 folds, that's a total of (12+6)*5=90 rounds of training 
grid_search = GridSearchCV(forest_reg, param_grid, cv=5,
                           scoring='neg_mean_squared_error',
                           return_train_score=True)
grid_search.fit(housing_prepared, housing_labels)

grid_search.best_estimator_
Out[125]: RandomForestRegressor(max_features=8, n_estimators=30, random_state=42)

cvres = grid_search.cv_results_
for mean_score, params in zip(cvres["mean_test_score"], cvres["params"]):
    print(np.sqrt(-mean_score), params)

63669.11631261028 {'max_features': 2, 'n_estimators': 3}
55627.099719926795 {'max_features': 2, 'n_estimators': 10}
53384.57275149205 {'max_features': 2, 'n_estimators': 30}
60965.950449450494 {'max_features': 4, 'n_estimators': 3}
52741.04704299915 {'max_features': 4, 'n_estimators': 10}
50377.40461678399 {'max_features': 4, 'n_estimators': 30}
58663.93866579625 {'max_features': 6, 'n_estimators': 3}
52006.19873526564 {'max_features': 6, 'n_estimators': 10}
50146.51167415009 {'max_features': 6, 'n_estimators': 30}
57869.25276169646 {'max_features': 8, 'n_estimators': 3}
51711.127883959234 {'max_features': 8, 'n_estimators': 10}
49682.273345071546 {'max_features': 8, 'n_estimators': 30} ------ the best parameters
62895.06951262424 {'bootstrap': False, 'max_features': 2, 'n_estimators': 3}
54658.176157539405 {'bootstrap': False, 'max_features': 2, 'n_estimators': 10}
59470.40652318466 {'bootstrap': False, 'max_features': 3, 'n_estimators': 3}
52724.9822587892 {'bootstrap': False, 'max_features': 3, 'n_estimators': 10}
57490.5691951261 {'bootstrap': False, 'max_features': 4, 'n_estimators': 3}
51009.495668875716 {'bootstrap': False, 'max_features': 4, 'n_estimators': 10}
```

## Evaluate the System on the Test Set

After treaking the models for a while, we eventually
have a system that performs sufficiently well. Now
is the time to evaluate the final model on the test set.

```python
final_model = grid_search.best_estimator_

X_test = strat_test_set.drop("median_house_value", axis=1)
y_test = strat_test_set["median_house_value"].copy()

X_test_prepared = full_pipeline.transform(X_test)
final_predictions = final_model.predict(X_test_prepared)

final_mse = mean_squared_error(y_test, final_predictions)
final_rmse = np.sqrt(final_mse)

In [134]: final_rmse
Out[134]: 47730.22690385927
```

## Fine-Tune data preparation "hyperparameters"

There're a lot more to improve the model after the "first round" fine-tuning.
We can gain good insights on the problem by inspecting
the best estimator. For example, the RandomForestRegressor
can indicate the relative importance of eahc attribute
for making accurate predictions:

```python
feature_importances = grid_search.best_estimator_.feature_importances_
feature_importances
Out[135]:
array([7.33442355e-02, 6.29090705e-02, 4.11437985e-02, 1.46726854e-02,
       1.41064835e-02, 1.48742809e-02, 1.42575993e-02, 3.66158981e-01,
       5.64191792e-02, 1.08792957e-01, 5.33510773e-02, 1.03114883e-02,
       1.64780994e-01, 6.02803867e-05, 1.96041560e-03, 2.85647464e-03])

extra_attribs = ["rooms_per_hhold", "pop_per_hhold", "bedrooms_per_room"]
#cat_encoder = cat_pipeline.named_steps["cat_encoder"] # old solution
cat_encoder = full_pipeline.named_transformers_["cat"]
cat_one_hot_attribs = list(cat_encoder.categories_[0])
attributes = num_attribs + extra_attribs + cat_one_hot_attribs
sorted(zip(feature_importances, attributes), reverse=True)
Out[136]:
[(0.36615898061813423, 'median_income'),
 (0.16478099356159054, 'INLAND'),
 (0.10879295677551575, 'pop_per_hhold'),
 (0.07334423551601243, 'longitude'),
 (0.06290907048262032, 'latitude'),
 (0.056419179181954014, 'rooms_per_hhold'),
 (0.053351077347675815, 'bedrooms_per_room'),
 (0.04114379847872964, 'housing_median_age'),
 (0.014874280890402769, 'population'),
 (0.014672685420543239, 'total_rooms'),
 (0.014257599323407808, 'households'),
 (0.014106483453584104, 'total_bedrooms'),
 (0.010311488326303788, '<1H OCEAN'),
 (0.0028564746373201584, 'NEAR OCEAN'),
 (0.0019604155994780706, 'NEAR BAY'),
 (6.0280386727366e-05, 'ISLAND')]
```

With this information, we can drop less useful information
in the prepared training data and retrain the model.

We can treat some of the data preparation steps as hyperparameter.
And fine-tune these hyperparameters automatically with
GridSearchCV or RandomizedSearchCV.

First, construct a pipeline containing
the data preparation and final prediction. Then wrap
the hyperparamters to the "para_grid" list.

```python
# add a transformer in the preparation pipeline to select only the most important attributes.
from sklearn.base import BaseEstimator, TransformerMixin

def indices_of_top_k(arr, k):
    return np.sort(np.argpartition(np.array(arr), -k)[-k:])

class TopFeatureSelector(BaseEstimator, TransformerMixin):
    def __init__(self, feature_importances, k):
        self.feature_importances = feature_importances
        self.k = k
    def fit(self, X, y=None):
        self.feature_indices_ = indices_of_top_k(self.feature_importances, self.k)
        return self
    def transform(self, X):
        return X[:, self.feature_indices_]

k = 5
preparation_and_feature_selection_pipeline = Pipeline([
    ('preparation', full_pipeline),
    ('feature_selection', TopFeatureSelector(feature_importances, k))
])

# create a single pipeline that does the full data preparation plus the final prediction
# we use the svm model
prepare_select_and_predict_pipeline = Pipeline([
    ('preparation', full_pipeline),
    ('feature_selection', TopFeatureSelector(feature_importances, k)),
    ('svm_reg', SVR(C=157055.10989448498, gamma=0.26497040005002437, kernel='rbf'))
])

# add hyperparameters of the data preparation to the grid para list
# the double underscores, __, is to guide the transformer chains
param_grid = [{
#    'preparation__num__attribus__adder': [False, True], # 
#    'preparation__num__imputer__strategy': ['mean', 'median', 'most_frequent'],
#    'feature_selection__k': list(range(1, len(feature_importances) + 1))
    'preparation__num__imputer__strategy': ['median', 'most_frequent'],
    'feature_selection__k': list(range(8, len(feature_importances) + 1))
}]

grid_search_prep = GridSearchCV(prepare_select_and_predict_pipeline, param_grid, cv=3,
                                scoring='neg_mean_squared_error', verbose=2)
grid_search_prep.fit(housing, housing_labels)

Fitting 3 folds for each of 18 candidates, totalling 54 fits
[CV] END feature_selection__k=8, preparation__num__imputer__strategy=median; total time=  15.1s
[CV] END feature_selection__k=8, preparation__num__imputer__strategy=median; total time=  15.6s
[CV] END feature_selection__k=8, preparation__num__imputer__strategy=median; total time=  14.7s
[CV] END feature_selection__k=8, preparation__num__imputer__strategy=most_frequent; total time=  15.5s
[CV] END feature_selection__k=8, preparation__num__imputer__strategy=most_frequent; total time=  16.1s
[CV] END feature_selection__k=8, preparation__num__imputer__strategy=most_frequent; total time=  15.8s
[CV] END feature_selection__k=9, preparation__num__imputer__strategy=median; total time=  19.8s
[CV] END feature_selection__k=9, preparation__num__imputer__strategy=median; total time=  17.6s
...
[CV] END feature_selection__k=15, preparation__num__imputer__strategy=most_frequent; total time=  25.4s
[CV] END feature_selection__k=16, preparation__num__imputer__strategy=median; total time=  25.7s
[CV] END feature_selection__k=16, preparation__num__imputer__strategy=median; total time=  28.1s
[CV] END feature_selection__k=16, preparation__num__imputer__strategy=median; total time=  28.9s
[CV] END feature_selection__k=16, preparation__num__imputer__strategy=most_frequent; total time=  27.1s
[CV] END feature_selection__k=16, preparation__num__imputer__strategy=most_frequent; total time=  26.7s
[CV] END feature_selection__k=16, preparation__num__imputer__strategy=most_frequent; total time=  25.3s
Out[157]:
GridSearchCV(cv=3,
             estimator=Pipeline(steps=[('preparation',
                                        ColumnTransformer(transformers=[('num',
                                                                         Pipeline(steps=[('imputer',
                                                                                          SimpleImputer(strategy='median')),
                                                                                         ('attribs_adder',
                                                                                          CombinedAttributesAdder()),
                                                                                         ('std_scaler',
                                                                                          StandardScaler())]),
                                                                         ['longitude',
                                                                          'latitude',
                                                                          'housing_median_age',
                                                                          'total_rooms',
                                                                          'total_bedrooms',
                                                                          'population',
                                                                          'households',
                                                                          'median_inc...
       5.64191792e-02, 1.08792957e-01, 5.33510773e-02, 1.03114883e-02,
       1.64780994e-01, 6.02803867e-05, 1.96041560e-03, 2.85647464e-03]),
                                                           k=5)),
                                       ('svm_reg',
                                        SVR(C=157055.10989448498,
                                            gamma=0.26497040005002437))]),
             param_grid=[{'feature_selection__k': [8, 9, 10, 11, 12, 13, 14, 15,
                                                   16],
                          'preparation__num__imputer__strategy': ['median',
                                                                  'most_frequent']}],
             scoring='neg_mean_squared_error', verbose=2)

In [158]: grid_search_prep.best_params_
Out[158]: {'feature_selection__k': 15, 'preparation__num__imputer__strategy': 'median'}

In [159]: grid_search_prep.best_estimator_
Out[159]:
Pipeline(steps=[('preparation',
                 ColumnTransformer(transformers=[('num',
                                                  Pipeline(steps=[('imputer',
                                                                   SimpleImputer(strategy='median')),
                                                                  ('attribs_adder',
                                                                   CombinedAttributesAdder()),
                                                                  ('std_scaler',
                                                                   StandardScaler())]),
                                                  ['longitude', 'latitude',
                                                   'housing_median_age',
                                                   'total_rooms',
                                                   'total_bedrooms',
                                                   'population', 'households',
                                                   'median_income']),
                                                 ('cat', OneHotEncoder(...
                 TopFeatureSelector(feature_importances=array([7.33442355e-02, 6.29090705e-02, 4.11437985e-02, 1.46726854e-02,
       1.41064835e-02, 1.48742809e-02, 1.42575993e-02, 3.66158981e-01,
       5.64191792e-02, 1.08792957e-01, 5.33510773e-02, 1.03114883e-02,
       1.64780994e-01, 6.02803867e-05, 1.96041560e-03, 2.85647464e-03]),
                                    k=15)),
                ('svm_reg',
                 SVR(C=157055.10989448498, gamma=0.26497040005002437))])

In [160]: cvres = grid_search_prep.cv_results_
     ...: for mean_score, params in zip(cvres["mean_test_score"], cvres["params"]):
     ...:     print(np.sqrt(-mean_score), params)
     ...:
57465.653423326 {'feature_selection__k': 8, 'preparation__num__imputer__strategy': 'median'}
57465.203916645514 {'feature_selection__k': 8, 'preparation__num__imputer__strategy': 'most_frequent'}
57623.503458780164 {'feature_selection__k': 9, 'preparation__num__imputer__strategy': 'median'}
57598.2348069413 {'feature_selection__k': 9, 'preparation__num__imputer__strategy': 'most_frequent'}
55490.89750961185 {'feature_selection__k': 10, 'preparation__num__imputer__strategy': 'median'}
55507.80324683013 {'feature_selection__k': 10, 'preparation__num__imputer__strategy': 'most_frequent'}
55556.93497686591 {'feature_selection__k': 11, 'preparation__num__imputer__strategy': 'median'}
55603.0587066939 {'feature_selection__k': 11, 'preparation__num__imputer__strategy': 'most_frequent'}
55726.15535710725 {'feature_selection__k': 12, 'preparation__num__imputer__strategy': 'median'}
55766.000224108844 {'feature_selection__k': 12, 'preparation__num__imputer__strategy': 'most_frequent'}
55325.452631024105 {'feature_selection__k': 13, 'preparation__num__imputer__strategy': 'median'}
55363.00430301058 {'feature_selection__k': 13, 'preparation__num__imputer__strategy': 'most_frequent'}
55373.604265619084 {'feature_selection__k': 14, 'preparation__num__imputer__strategy': 'median'}
55419.50579651758 {'feature_selection__k': 14, 'preparation__num__imputer__strategy': 'most_frequent'}
55297.12593596921 {'feature_selection__k': 15, 'preparation__num__imputer__strategy': 'median'} -- best
55314.76961714532 {'feature_selection__k': 15, 'preparation__num__imputer__strategy': 'most_frequent'}
55297.42444014004 {'feature_selection__k': 16, 'preparation__num__imputer__strategy': 'median'}
55316.67663234411 {'feature_selection__k': 16, 'preparation__num__imputer__strategy': 'most_frequent'}

In [161]:
```
