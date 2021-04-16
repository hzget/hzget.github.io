# Performance Measures

We evaluate the regressor with RMSE (Root Mean Square Error)
introduced in the [Cross Validation](./cross_validation.md) page.
But it is a different story to evaluate a classifier.

Suppose we have the MNIST dataset that contains images
representing 0~9 digits. And we create a binary classifier
that can tell whether or not an image is the digit 5. And then
check the performance of the classifier.

We will introduce 3 different performance measures for
this classifier:

* accuracy
* Confusion Matrix
  * precison and recall
  * receiver operating characteristic -- ROC

## Prepare data and the binary classifier

```python
# load dataset and split it
import numpy as np
from sklearn.datasets import fetch_openml
mnist = fetch_openml('mnist_784', version=1, as_frame=False)

X, y = mnist["data"], mnist["target"]
y = y.astype(np.uint8)
X_train, X_test, y_train, y_test = X[:60000], X[60000:], y[:60000], y[60000:]

# it's a binary classifier, thus label shall be binary
y_train_5 = (y_train == 5)
y_test_5 = (y_test == 5)

from sklearn.linear_model import SGDClassifier

sgd_clf = SGDClassifier(max_iter=1000, tol=1e-3, random_state=42)
# sgd_clf.fit(X_train, y_train_5)
```

## Measuring Accuracy Using Cross-Validation

We may spontaneously check the accuracy of a classifier for
the performance measure.
Let's evaluate the SGDClassifier model with cross_val_score function.

```python
from sklearn.model_selection import cross_val_score
cross_val_score(sgd_clf, X_train, y_train_5, cv=3, scoring="accuracy")

Out[181]: array([0.95035, 0.96035, 0.9604 ])
```

Above 93% accuracy on all 3 cross-validation folds!
It seems that the performance is very good!
However, we'll be amazed by the accuracy of the following "not-5" class:

```python
from sklearn.base import BaseEstimator
class Never5Classifier(BaseEstimator):
    def fit(self, X, y=None):
        pass
    def predict(self, X):
        return np.zeros((len(X), 1), dtype=bool)

never_5_clf = Never5Classifier()
cross_val_score(never_5_clf, X_train, y_train_5, cv=3, scoring="accuracy")

Out[184]: array([0.91125, 0.90855, 0.90915])
```

Never5Calssifier just predicts all images to be not 5.
It has over 90% accuracy! Almost the same performance
with that of the SGDClassifier model! What happened?

It is simply because only about 10% of the images are 5s!

It demonstrates that accuracy is generally not
a preferred performance mearsure, especially when
we're dealing with skewed dataset. (i.e., when some
classes are much more frequent than others).
