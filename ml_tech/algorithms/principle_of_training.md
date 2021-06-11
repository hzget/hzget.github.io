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

$$\mbox{MSE}(X, h_\theta) = \frac{1}{m}\sum_{i=1}^m(h_{\theta}(x^{(i)})-y^{(i)})^2$$

In this equation:

$$X$$: a matrix containing all the feature values
of all instances in the dataset. There's one row per
instance and one column per feature.  
$$m$$: number of instances  
$$x^{(i)}$$: the ith instance  
$$y^{(i)}$$: the desired output value of the ith instance  
$$h_{\theta}(x^{(i)})$$: a hypothesis -- the system'prediction of the ith instance  

If it is a linear regression model,
$$h_{\theta}(X) = X\theta$$, MSE will be

$$\mbox{MSE}(X, h_\theta) = \frac{1}{m}\sum_{i=1}^m({\theta}^Tx^{(i)}-y^{(i)})^2$$

The matrix form is $$\mbox{MSE}(X, h_\theta) = \frac{1}{m}\|X{\theta}-y\|^2$$.

To train a Linear Regression model, we need to
find the value of $$\theta$$ that minimizes the MSE.

There're two different ways to train it:

1. Using a direct "close-form" equation that directly
   computes the required params.
2. Using an iterative optimazation approach called
   Gradient Descent (GD) that gradually tweaks the model params
   to minimize the cost function, eventually converging
   to the same set of params as the first method.
   There're a few variants of Gradient Descent:
   Batch GD,Mini-batch GD and Stochastic GD (SGD).

We'll take the Linear Regression model as an example
of how to train the model via these two method.

## Close-Form Solution

If it is a Linear Regression model, we can get params
via the following method.

$$min\|X{\theta}-y\|^2$$

It's a [minimization problem](../../math/minimization.md)
and we can get the params:

$$\theta = \sum_{i=1}^r \frac{1}{\sigma_i}u_i^Tyv_i$$

With a matrix form: $$\theta = X^{+}y = V{\Sigma}^{+} U^Ty$$

The bias is $$min\|X{\theta}-y\|^2 = \sum_{i=r+1}^m(u_i^Ty)^2$$.
If the bias is accepted, linear model is an appropriate model.

## Gradient Descent Solution

Gradient Descent (GD) gradually tweaks the
model params to minimize the cost function.
It reduces the cost function step by step, and
eventually approaches close to the global minimum.
[Neural Networks tutorial][Neural Networks tutorial]
gives a detail description of how GD works in ***Neural Networks***.

For each step,

$$\Delta \mbox{MSE}(\theta) = \langle \Delta \theta \; , {\nabla}_{\theta} \mbox{MSE}(\theta) \rangle$$

From [Cauchy–Schwarz inequality][Cauchy–Schwarz inequality],
we can get maximum absolute value of $$\Delta \mbox{MSE}(\theta)$$ if
$$\Delta \theta$$ and $${\nabla}_{\theta} \mbox{MSE}(\theta)$$ are linear
dependent. And if they're of opposite direction, the delta will be
negative --- in other words, the cost function decreases.
Thus we have the Gradient Descent step:

$$\theta^{\small\mbox{(next step)}} = \theta - \eta {\nabla}_{\theta} \mbox{MSE}(\theta)$$

where $$\eta$$ is the learning rate.

***Partial derivatives of the cost function***

$$\frac{\partial}{\partial \theta_j}\mbox{MSE}(\theta)
= \frac{2}{m}\sum_{i=1}^m(\theta^T x^{(i)}-y^{(i)})x_j^{(i)}$$

***Gradient vector of the cost function***

$${\nabla}_{\theta} \mbox{MSE}(\theta) =
\begin{bmatrix}
\frac{\partial}{\partial \theta_0}\mbox{MSE}(\theta) \\
\frac{\partial}{\partial \theta_1}\mbox{MSE}(\theta) \\
\vdots \\
\frac{\partial}{\partial \theta_n}\mbox{MSE}(\theta)
\end{bmatrix}
= \frac{2}{m}X^T(X\theta - y)
$$

[Neural Networks tutorial]: ../../neural_networks/neural_networks.md
[Cauchy–Schwarz inequality]: https://en.wikipedia.org/wiki/Cauchy%E2%80%93Schwarz_inequality