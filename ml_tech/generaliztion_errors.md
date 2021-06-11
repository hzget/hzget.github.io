<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Generalization Errors

The end goal of ML is to make the trained model
perform well on new cases (in production).
Thus we need to find ways to reduce the generalization
error: ***Bias, Variance and Irreducible*** error.

## Types of the Errors

(For the detail, please refer to
[Bias-Variance Tradeoff and Ridge Regression][Bias-Variance Tradeoff])

In a generic regression problem, the goal is to
model the unknown relationship $$y=f({\bf x})$$
between the dependent variable $$y$$ and the $$d$$
independent variables $${\bf x}=[x_1,\cdots,x_d]^T$$,
by a regression function $$\hat{f}({\bf x})$$,
based on a set of given training data $${\cal D}=\{({\bf x}_n,\,y_n)\;n=1,\cdots,N\}$$
containing a set of observed data samples inevitably
contaminated by some random noise $$e$$.
Now corresponding to a noisy $${\bf x}$$, the observed value
$$y=f({\bf x})+e$$ is also random and so is the
regresson model $$\hat{f}({\bf x})$$.
We assume the random noise $e$ has zero mean
and is independent of $\hat{f}$.

Measure how well the model $$\hat{f}({\bf x})$$ fits
the noisy data $$y=f({\bf x})+e$$ by the mean squared error (MSE):

$$\begin{align*} E [ (y-\hat{f})^2 ]
& = E[(f+e-\hat{f})^2 ] \\
& = \cdots \\
& = E[(f-E\hat{f})^2]+E[(E\hat{f}-\hat{f})^2]+E[e^2]
\end{align*}$$

The three terms represent three different types of error:

* ***Irreducible Error*** $$E[e^2]=\sigma^2$$, due to
  the inevitable observation error.
* ***Bias Error***: $$E[(f-E\hat{f})^2]=(f-E\hat{f})^2$$,
  the expected squared bias, the difference between
  the estimated function and the true function, measuring
  how well the estimated function $$\hat{f}$$ models
  the true function $$f$$
* ***Variance Error***: $$E[\hat{f}-E\hat{f}]^2=Var[\hat{f}]$$,
  the variance of the estimated function $$\hat{f}$$,
  measuring the variation of the model
  due to the noise in the training data.

## Irreducible Error

Irreducible error is due to the noisiness of
the data itself. The only way to reduce this
type of error is to clean up the data (e.g.,
fix the data source, such as broken sensors,
or detect and remove outliers).

## Bias

The bias may because the model does not
detect enough underlying patterns in the
data set or because that the
data set is not representative.

The former case happens when there's
an underlying issue.

## Variance

Ihis part is due to the model's excessive
sensitivity to small variantions in the
training data. It happens when there's
an overfitting issue.

[Bias-Variance Tradeoff]: http://fourier.eng.hmc.edu/e176/lectures/ch7/node11.html
