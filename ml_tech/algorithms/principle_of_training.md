<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Principle of Training a model

Traing a model means setting its parameters
so that the model best fits the training data.
For this purpose, we need to find a performance
measure of how well (or poorly) the model fits
the training data.

A common method is to create a cost function
that measures how poorly the model is. And the
goal is to find params of the model that minimize
the value of the cost function over the training data.

The most common cost function of a regression
model is the Root Mean Square Error (RMSE). And
in practice, we usually use the Mean Square Error (MSE)
instead:

$$\mbox{MSE}(X, h_\theta) = \frac{1}{m}\sum_{i=1}^m(h_{\theta}(x^{(i)})-y^{(i)})$$

If it is a linear regression model,
$$h_{\theta}(X) = X\theta$$, thus the MSE is

$$\mbox{MSE}(X, h_\theta) = \frac{1}{m}\sum_{i=1}^m({\theta}^Tx^{(i)}-y^{(i)})$$

To train a Linear Regression model, we need to
find the value of $$\theta$$ that minimizes the MSE.

There're two different ways to train it:

* Using a direct "close-form" equation that directly
  computes the required params.
* Using an iterative optimazation approach called
  Gradient Descent (GD) that gradually tweaks the model params
  to minimize the cost function, eventually converging
  to the same set of params as the first method.
  There're a few variants of Gradient Descent: Batch GD,
  Mini-batch GD and Stochastic GD (SGD).
