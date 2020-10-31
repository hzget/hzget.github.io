<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Function

A [function][wiki function] is a binary relation between two sets
that associates every element of the first set to exactly one element of the second set.

## linear

### linear map

A linear map from V to W is a function $$T: V \rightarrow W$$ with the following
properties:

additivity:

$$T(u + v) = Tu + Tv \; \mbox{for all} \; u, v \in V$$

homogeneity:
$$T(\lambda v) = \lambda \, Tv \; \mbox{for all} \; \lambda \in F \; \mbox{and all} \; v \in V$$

### linear functional

A linear functional on V is a linear map from V to the
***scalars*** F: $$\varphi: V \rightarrow F$$. Example:

* $$\varphi: F^3 \rightarrow F: \varphi(z_1, z_2, z_3) = 2z_1 - 5z_2 + z_3$$

* $$\varphi: P_6(R) \rightarrow R: \varphi(p) = \int_0^1 \! p(x)(cos(x)) \; \mathrm{d}x$$

## non linear

### norm

A norm on a vector space U is a function $$\| \; \|: U \rightarrow [0, \infty]$$
such that:

[1] $$\| u \| = 0 \; \mbox{if and only if} \; u = 0, \\$$
[2] $$\| \alpha u \| = |\alpha|\|u\| \; \mbox{for all} \; \alpha \in F, u \in U, \\$$
[3] $$\| u + v \| \leq \|u\| + \|v\| \; \mbox{for all} \; u, v \in V$$

### inner product

An inner product on V is a function that takes
each ordered pair (u, v) of elements of V to a number
from F: $$\langle , \rangle : (u, v) \rightarrow a \in F$$
and has the following properties:

1. $$\langle v , v \rangle \geq 0 , v \in V$$
2. $$\langle v , v \rangle = 0 \Leftrightarrow v = 0$$
3. $$\langle u + v , w \rangle = \langle u , w \rangle + \langle v , w \rangle, u, v, w \in V$$
4. $$\langle cv , w \rangle = c\langle v , w \rangle, c \in F, v, w \in V$$
5. $$\langle v, w \rangle = {\overline {\langle w, v \rangle}}$$

[wiki function]: https://en.wikipedia.org/wiki/Function_(mathematics)
