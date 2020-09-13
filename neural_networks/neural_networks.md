<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
# Neural Networks and Deep Learning

I start the study of deep learning from a blog
[Neural Networks and Deep Learning](http://neuralnetworksanddeeplearning.com/index.html)

I just record what I get & think during the progress.

This is a tutorial about deep learning. It just resolve one thing:
recognize the handwritten digits.

Lession 1: introduce the neural nets

## 01 introduce the neural nets

[Deep learning](https://en.wikipedia.org/wiki/Deep_learning)
(also known as deep structured learning) is part of a broader family of
machine learning methods based on **artificial neural networks**
with representation learning.

Thus we will begin from the concept of neuron.

### how neuron works

A neuron or nerve cell is an electrically excitable cell
that receives signals and make some response.

![Neuron](https://upload.wikimedia.org/wikipedia/commons/4/44/Neuron3.png)

Deep learning make use of that structure to make some prediction.

### perceptron

A [perceptron](https://en.wikipedia.org/wiki/Perceptron)
takes several binary inputs and produces a single binary output.

![perceptron image](http://neuralnetworksanddeeplearning.com/images/tikz0.png)

We can give its math description:

$$\begin{equation*}
  \mbox{output} =
    \begin{cases}
      1 & \text{if } w\cdot x + b > 0 \\
      0 & \mbox{otherwise}
    \end{cases}
\tag{1-1}\end{equation*}$$

The model tells how each input affects the output.
***The params `w` and `b` are what to "learn" from examples.***
With that, the model can predict new input.
Do you know how to "learn" from the training data?

We can make a small change of `w` and `b` to make the
output `y` approaches the desired output value `d` from examples.
We can repeat it until the distance between `y` and `d` is enough small.

However, this isn't what happens when our network contains perceptrons.
perceptron is a "step function". Its output is a binary value,
a small change in `w` or `b` may cause `y` change from 0 to 1 or 1 to 0.
The "small change" is not possible for the output. It is not expected.

### Sigmoid neurons

Sigmoid neurons is the solution for that.

\begin{eqnarray}
  \sigma(z) = \frac{1}{1+e^{-z}} \;\; and \;\; z = w \cdot x+b
\tag{1-2}\end{eqnarray}

Its shape is a smoothed out version of a step function. And it makes the "small change" possible.

![the sigmoid function](https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Logistic-curve.svg/480px-Logistic-curve.svg.png)
