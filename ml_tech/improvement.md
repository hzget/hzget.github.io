# Improvement

After we have found a promising model, we
need to find ways to improve its performance
as best as we can. For example,

* data: optimize the data-preparation steps
* algorithm: improve the underlying algorithms
* output: analyze errors
* performance measures: analyze metrics
* introduce more techniques

## Data Preparation Steps

We can go back to the data preparation stage and optimize
some steps.

From the [Fine-tune the model](./fine_tune_the_model.md) page,
we have introduced a method to re-preprocess the data --
sort the feature according to its importance, take
the feature number as a hyperparameter, and then fine-tune
this hyperparameter with cross-validation.

After the repreparation, retrain the model with the optimized features.

## Error Analysis

Analyzing the output errors may give some ideas to
improve the performance.

Suppose we explore the confusion matrix of the sgd model.
(introduced in [performance measures](./performance_measures.md) page).
Each row represents an actual class and each column represents
a predicted class.

```python
y_train_pred = cross_val_predict(sgd_clf, X_train, y_train, cv=3)
conf_mx = confusion_matrix(y_train, y_train_pred)
```

Plot the confusion matrix:

![confusion matrix](./pic/confusion_matrix.png)

Focus on the right picture. We can clearly see the kinds
of errors the classifier makes. As we can see, many images
are misclassified as 8s, while the actual 8s in general
get properly classified as 8s. There're other errors.
For example, 3s and 5s often get confused with each other.

Our goal is to find ways to reduce these errors.
Suppose we want to reduce the false 8s. We can check
the following solutions:

* gether more training data that looks like 8s (but are not)
  so that the classifier can learn to distinguish them
  from real 8s.
* engineer new features to help the classifier -- for example,
  writing an algorithm to count the number of closed loops
* preprocess the images to make some patterns, such as closed
  loops, stand out more.
