# Split data set

The following will be discussed:

* overfitting & underfitting
* cross-validation
* data set split --- training set, validation set, test set
* sampling bias

Suppose we have trained a model and it performs well
on the training data. If we deploy it to the production
system, we usually find that it performs badly on the
production system.

It is called ***overfitting -- overfit the training data***.

To resolve the issue, we need to generalize the model to
a test data set. If it performs badly on it, we need
to go back to the training process and fine-tune the model.

After the modified model performs well on test data set,
we may believe that the overfitting issue is resolved and
then deploy the model to the production system again. We may still
find that it performs badly on the production system.

What happened?
***The model overfits both the training data set and the test data set!***

To resolve the issue, we can split the training data into two
parts: one part is used to train the model wheares
the other part is used to "validate" the performance.
The process is called ***cross-validation*** and
the second part is called validation data set. We can try different
training/validation sets, train different models and different hyperparameters
and finally select the best model. (refer to
[cross validatioon][cross validation page] and
[fine-tune the mode][fine-tune the mode page] pages).

If the selected model performs well on both training data set
and validation data set, we can believe that the overfitting
issue does not exist now. Otherwise, we shall find a way to
fix the issue during cross-validation until we get an accepted result.
Then generalize the model to the test set.

In summary,

* training data: train the model
* validation data is used for cross-validation:
  * find the best model with fine-tuned hyperparameter(s)
  * check overfitting and underfitting issue
* test data set: test the performance

## split data set to training data set and test data set

Note that we use the stratified sampling to avoid
the sampling bias. The sampling bias will make a
nonpresentative training data set.

```python
import numpy as np

housing["income_cat"] = pd.cut(housing["median_income"],
                               bins=[0., 1.5, 3.0, 4.5, 6., np.inf],
                               labels=[1, 2, 3, 4, 5])

from sklearn.model_selection import StratifiedShuffleSplit

split = StratifiedShuffleSplit(n_splits=1, test_size=0.2, random_state=42)
for train_index, test_index in split.split(housing, housing["income_cat"]):
    strat_train_set = housing.loc[train_index]
    strat_test_set = housing.loc[test_index]

for set_ in (strat_train_set, strat_test_set):
    set_.drop("income_cat", axis=1, inplace=True)
```

[cross validation page]: ./cross_validation.md
[fine-tune the mode page]: ./fine_tune_the_model.md
