# Improvement

After we have found a promising model, we
need to find ways to improve its performance.

We can optimize the data-preparation steps, analyze errors,
introduce more techniques, improve the underlying algorithms,
and so on.

## Data Preparation Steps

We can go back to the data preparation stage and optimize
some steps.

From the [Fine-tune the model](./fine_tune_the_model.md) page,
we have introduced a method to re-preprocess the data --
sort the feature according to its importance, take
the feature number as a hyperparameter, and then fine-tune
this hyperparameter with cross-validation.

After that, retrain the model with the optimized features.

## Error Analysis

Analyzing the output errors may give some ideas to
improve the performance.

Suppose we explore the confusion matrix of the sgd model.
(introduced in [performance measures](./performance_measures.md) page).

```python
y_train_pred = cross_val_predict(sgd_clf, X_train, y_train, cv=3)
conf_mx = confusion_matrix(y_train, y_train_pred)
```
