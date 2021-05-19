<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Linear model

## What is Linear model?

A linear model make a prediction by simply computing
a weighted sum of the input features, plus a constant
called the bias term (also called the intercept term).

$$ \hat y = \theta_0 + \theta_1 x_1 + \cdots + \theta_n x_n$$

## Dataset

```python
# generate linear-looking data plus some noise:
import numpy as np
X = 2 * np.random.rand(100,1)
y = 4 + 3 * X + np.random.randn(100,1)
```

Plot the dataset in the following picture.

![linear dataset](../pic/linear_dataset.png)

## LinearRegression class

Perform Linear Regression using scikit-learn's
[LinearRegression][LinearRegression] class.

```python
from sklearn.linear_model import LinearRegression

lin_reg = LinearRegression()
lin_reg.fit(X, y)
lin_reg.intercept_, lin_reg.coef_
Out[3]: (array([4.32075143]), array([[2.80811042]]))

# the test set
X_new = np.array([[0],[2]])
y_lin_predict = lin_reg.predict(X_new)
y_lin_predict
Out[4]:
array([[4.32075143],
       [9.93697226]])
```

## SGDRegressor class

Perform Linear Regression using scikit-learn's
[SGDRegressor][SGDRegressor] class.

```python
from sklearn.linear_model import SGDRegressor

sgd_reg = SGDRegressor(max_iter=1000, tol=1e-3, penalty=None, eta0=0.1, random_state=42)
sgd_reg.fit(X, y.ravel())
Out[9]: SGDRegressor(eta0=0.1, penalty=None, random_state=42)

sgd_reg.intercept_, sgd_reg.coef_
Out[14]: (array([4.3270307]), array([2.87206748]))

y_sgd_predict = sgd_reg.predict(X_new)
y_sgd_predict
Out[16]: array([ 4.3270307 , 10.07116566])
```

## Plot the predictions from different algorithms

```python
import matplotlib.pyplot as plt

# plot data set
plt.plot(X, y, "b.", label="data set")
plt.xlabel("$x_1$", fontsize=18)
plt.ylabel("$y$", rotation=0, fontsize=18)
plt.axis([0, 2, 0, 15]) 

X_test = np.array([[0.01], [0.5], [1], [1.5], [1.99]])
y_lin_predict = lin_reg.predict(X_test)
plt.plot(X_test, y_lin_predict, 'or-', lw=0.8, alpha=0.7, label='LinearRegression')

y_sgd_predict = sgd_reg.predict(X_test)
plt.plot(X_test, y_sgd_predict, "+g-", lw=0.8, alpha=0.7, label="SGDRegressor")
plt.legend()
```

Here is the plotting image:

![linear regression](../pic/linear_regression.png)

## Learning curves

```python
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split

def plot_learning_curves(model, X, y):
    X_train, X_val, y_train, y_val = train_test_split(X, y, test_size=0.2, random_state=10)
    train_errors, val_errors = [], []
    for m in range(1, len(X_train)):
        model.fit(X_train[:m], y_train[:m])
        y_train_predict = model.predict(X_train[:m])
        y_val_predict = model.predict(X_val)
        train_errors.append(mean_squared_error(y_train[:m], y_train_predict))
        val_errors.append(mean_squared_error(y_val, y_val_predict))

    plt.plot(np.sqrt(train_errors), "+r-", linewidth=1, label="train")
    plt.plot(np.sqrt(val_errors), ".b-", linewidth=1, label="val")
    plt.legend(loc="upper right", fontsize=14)   # not shown in the book
    plt.xlabel("Training set size", fontsize=14) # not shown
    plt.ylabel("RMSE", fontsize=14)              # not shown

plt.figure(figsize=(10, 5))

plt.subplot(121)
plot_learning_curves(lin_reg, X, y)
plt.title("LinearRegression class")

plt.subplot(122)
plot_learning_curves(sgd_reg, X, y.ravel())
plt.title("SGDRegressor class")

```

[LinearRegression]: https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LinearRegression.html
[SGDRegressor]: https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.SGDRegressor.html