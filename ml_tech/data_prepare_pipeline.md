# Data Prepare Pipeline

The previous chapter talks about how to prepare data
for training the model. Now we're going to make the
whole process in one pipeline.

As stated in scikit-learn website, [pipeline][pipeline page]
can sequentially apply a list of transforms and a final estimator.
Intermediate steps of the pipeline must be ‘transforms’,
that is, they must implement fit and transform methods.
The final estimator only needs to implement fit.

```python
class sklearn.pipeline.Pipeline(steps, *, memory=None, verbose=False)
```

The "steps" is a list of (name, transform)
tuples (implementing fit/transform) that are chained,
in the order in which they are chained,
with the last object an estimator.

In a word, we can implement all steps as a transformer/estimator
and pack them in a pipeline. Then apply the method of pipeline
that will apply methods of a list of transforms and a final estimator.

In our example, the "attribute combination" step can be
implemented by ourselves and other steps can make use of
standard class from sklearn library.

Note: there're some steps not included in the pipeline:

* load data
* split data set
* construct the column of housing_num

```python
from sklearn.base import BaseEstimator, TransformerMixin

# column index
col_names = "total_rooms", "total_bedrooms", "population", "households"
rooms_ix, bedrooms_ix, population_ix, households_ix = [
    housing.columns.get_loc(c) for c in col_names] # get the column indices

class CombinedAttributesAdder(BaseEstimator, TransformerMixin):
    def __init__(self, add_bedrooms_per_room=True): # no *args or **kargs
        self.add_bedrooms_per_room = add_bedrooms_per_room
    def fit(self, X, y=None):
        return self  # nothing else to do
    def transform(self, X):
        rooms_per_household = X[:, rooms_ix] / X[:, households_ix]
        population_per_household = X[:, population_ix] / X[:, households_ix]
        if self.add_bedrooms_per_room:
            bedrooms_per_room = X[:, bedrooms_ix] / X[:, rooms_ix]
            return np.c_[X, rooms_per_household, population_per_household,
                         bedrooms_per_room]
        else:
            return np.c_[X, rooms_per_household, population_per_household]

# how to use it
# attr_adder = CombinedAttributesAdder(add_bedrooms_per_room=False)
# housing_extra_attribs = attr_adder.transform(housing.values)

from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.impute import SimpleImputer

num_pipeline = Pipeline([
        ('imputer', SimpleImputer(strategy="median")),
        ('attribs_adder', CombinedAttributesAdder()),
        ('std_scaler', StandardScaler()),
    ])

# housing_num_tr = num_pipeline.fit_transform(housing_num)
# num_pipeline.fit() will call the following in order: 
#   imputer.fit_transform(), attribs_adder.fit_transform(), stad_scaler.fit()
# num_pipeline.fit_transform() will call the following in order: 
#   imputer.fit_transform(), attribs_adder.fit_transform(), stad_scaler.fit_transform()
# num_pipeline.transform() will call the following in order: 
#   imputer.transform(), attribs_adder.transform(), stad_scaler.transform()

from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder

num_attribs = list(housing_num)
cat_attribs = ["ocean_proximity"]

full_pipeline = ColumnTransformer([
        ("num", num_pipeline, num_attribs),
        ("cat", OneHotEncoder(), cat_attribs),
    ])

# look, we only use one line of code to prepare the data
housing_prepared = full_pipeline.fit_transform(housing)

type(housing_prepared), housing_prepared.shape
Out[13]: (numpy.ndarray, (16512, 16))
```

Let's have a quick overview of how to train models by this data.
Suppose we train a linear model to fit the prepared training data.

```python
from sklearn.linear_model import LinearRegression

lin_reg = LinearRegression()
lin_reg.fit(housing_prepared, housing_labels)

# let's try the full preprocessing pipeline on a few training instances
# we'll see how easy to use it
some_data = housing.iloc[:5]
some_labels = housing_labels.iloc[:5]
# only need to call the transform() method
some_data_prepared = full_pipeline.transform(some_data)

print("Predictions:", lin_reg.predict(some_data_prepared))
Predictions: [210644.60459286 317768.80697211 210956.43331178  59218.98886849
 189747.55849879]

print("Labels:", list(some_labels))
Labels: [286600.0, 340600.0, 196900.0, 46300.0, 254500.0]
```

[pipeline page]: https://scikit-learn.org/stable/modules/generated/sklearn.pipeline.Pipeline.html#sklearn.pipeline.Pipeline
