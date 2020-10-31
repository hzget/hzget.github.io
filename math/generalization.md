<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Generalization

A [generalization][wiki generalization] is a form of abstraction whereby common properties
of specific instances are formulated as general concepts or claims.

From the book "linear algebra done right", I found the following generalization:

## Examples

### vector space

generalize the linear structure (addition and scalar multiplication)
of $$R^2 \; and \; R^3$$ to the concept of vector space ***V*** over ***F***

### inner product

with vectors from $$R^n$$, generalize length and dot product to
the concept of norm $$\| \; \|$$ and inner product $$\langle \; , \rangle$$

## Advantages

With generalization, we can investigate common issues and
give a universal solution. As an illustration
of this pros, consider the Cauchy-Scharz Inequality in the form
of inner product:

$$|\langle u , v \rangle| \leq \|u\| \|v\| \;\;\; \mbox{for} \; u, v \in V$$

It resolves all cases that conform to properties of inner product. Example:

* Cauchy:

$$\left|x_1 y_1 + \cdots + x_n y_n\right|^2 \leq
(x_1^2 + \cdots + x_n^2)(y_1^2 + \cdots + y_n^2)$$

* Scharz:

$$\left|\int_{-1}^1 \!f(x)g(x) \, \mathrm{d}x\right|^2 \leq
\left(\int_{-1}^1 \!\left(f(x)\right)^2 \, \mathrm{d}x\right)
\left(\int_{-1}^1 \!\left(g(x)\right)^2 \, \mathrm{d}x\right)$$

[wiki generalization]: https://en.wikipedia.org/wiki/Generalization
