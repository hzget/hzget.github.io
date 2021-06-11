<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Ridge Regression

[Ridge regression][Ridge Regression] is a method of
estimating the coefficients of multiple-regression
models in scenarios where independent variables
are highly correlated.

It has the following effects:

* regulation of the model
* resolve issues when data matrix is ill-conditioned

[scikit-learn ridge guide][scikit-learn ridge] gives
some discussion of the ridge regression.

Ridge regression addresses some of the problems
of Ordinary Least Squares by imposing a penalty
on the size of the coefficients. The ridge coefficients
minimize a penalized residual sum of squares:

$$ \min_{\theta} \{\| X \theta - y\|_2^2 + \alpha \|\theta\|_2^2\} $$

with $$\alpha$$ be a nonnegative real value.

Take the partial derivatives of the cost function
and make them equal 0, we get the solution:

$$\hat \theta = (X^TX + \alpha I)^{-1} X^T y$$

If we decompose X with SVD decompostion $$X=U\Sigma V^T$$, we have
$$X^TX + \alpha I = V ({\color{read}{\Sigma^2 + \alpha I}}) V^T$$
which is invertible.

Then the above equation will be:

$$\hat \theta = V (\Sigma^2 + \alpha I)^{-1} \Sigma U^T y$$

We can write it in another form:

$$\hat \theta
= \sum_{i=1}^n \frac{\sigma_i}{\sigma_i^2 + \alpha} u_i^Tyv_i
= \sum_{i=1}^n {\color{red} {\frac{\sigma_i^2}{\sigma_i^2 + \alpha}}} \frac{1}{\sigma_i}u_i^Tyv_i
$$

As we can see, the complexity parameter $$\alpha \geq 0$$
controls the amount of shrinkage: the larger the value of
$$\alpha$$, the greater the amount of shrinkage and thus
the coefficients become more robust to collinearity.
With this shrinkage, ridge regression reduces
variance of the model params. To summarize:

* Small $\alpha$: the solution is more accurate
  but also more prone to noise and therefore less stable,
  i.e., large variance error but small bias error,
  or overfitting.
* Large $\alpha$: the solution is more stable as
  it is less affacted by noise, but it may be less
  accurate, i.e., small variance error but large
  bias error, or underfitting.

[Ridge Regression]: https://en.wikipedia.org/wiki/Ridge_regression
[scikit-learn ridge]: https://scikit-learn.org/stable/modules/linear_model.html#ridge-regression-and-classification
