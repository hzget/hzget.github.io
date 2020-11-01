<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Function

A [function][wiki function] is a binary relation between two sets
that associates every element of the first set to exactly one element of the second set.

## linear map

A linear map from V to W is a function $$T: V \rightarrow W$$ with the following
properties:

additivity:
$$T(u + v) = Tu + Tv \; \mbox{for all} \; u, v \in V$$

homogeneity:
$$T(\lambda v) = \lambda \, Tv \; \mbox{for all} \; \lambda \in F \; , \; v \in V$$

## linear map of linear map

Suppose that
$$\mathcal{L}(V, W)$$ is the vector space of
linear maps from V to W; and that
Mat(m, n, F) is the vector space of
m-by-n matrices with entries in F.

Fix the basis of V and W, we get an invertible linear map:

$$\mathcal{M}: \mathcal{L}(V, W) \rightarrow Mat(m, n, F)$$

It explains the concept:
A matrix records a linear map T from a basis of V to a basis of W.
It is called matrix of T with respect to "some" basis.

## linear functional

A linear functional on V is a linear map from V to the
***scalars F*** , donated $$\varphi: V \rightarrow F$$. Example:

$$\begin{align*}
\varphi: F^3 \rightarrow F:    \;\;\; & \varphi(z_1, z_2, z_3) = 2z_1 - 5z_2 + z_3 \\
\varphi: P_6(R) \rightarrow R: \;\;\; & \varphi(p) = \int_0^1 \! p(x)(cos(x)) \; \mathrm{d}x
\end{align*}$$

## polynomials applied to operators

Suppose that $$ T \in \mathcal{L}(V), \; p \in \mathcal{P}(F):
p(z) = a_0 + a_1 z + a_2 z^2 + \cdots + a_m z^m$$, we define
a function from $$ \mathcal{P}(F) \; \mbox{to} \; \mathcal{L}(V)$$
given by $$ p \rightarrow p(T)$$:

$$p(T) = a_0 + a_1 T + a_2 T^2 + \cdots + a_m T^m$$

Obviously, the function is linear and it has the following property:

[1] $$(pq)(z) = p(z)q(z) \Rightarrow (pq)(T) = p(T)q(T)$$

[2] $$p(T)q(T) = q(T)p(T)$$

## norm

A norm on a vector space U is a function $$\| \; \|: U \rightarrow [0, \infty)$$
such that:

[1] $$\| u \| = 0 \; \mbox{if and only if} \; u = 0$$
[2] $$\| \alpha u \| = |\alpha|\|u\| \; \mbox{for all} \; \alpha \in F, u \in U$$
[3] $$\| u + v \| \leq \|u\| + \|v\| \; \mbox{for all} \; u, v \in V$$

## inner product

An inner product on V is a function that takes
each ordered pair (u, v) of elements of V to a number
from F: $$\langle , \rangle : (u, v) \rightarrow a \in F$$
and has the following properties:

1. $$\langle v , v \rangle \geq 0 , v \in V$$

2. $$\langle v , v \rangle = 0 \Leftrightarrow v = 0$$

3. $$\langle u + v , w \rangle = \langle u , w \rangle + \langle v , w \rangle, u, v, w \in V$$

4. $$\langle cv , w \rangle = c\langle v , w \rangle, c \in F, v, w \in V$$

5. $$\langle v, w \rangle = {\overline {\langle w, v \rangle}}$$

For each ***fixed*** $$w \in V$$, the
function $$v \rightarrow \langle v , w \rangle$$ is a linear map from V to F.

## adjoint

Let $$T \in \mathcal{L}(V, W)$$, fix w from W,
consider the linear functional $$ \varphi : v \rightarrow \langle Tv , w \rangle$$.

The adjoint of T is a function $$T^\ast : W \rightarrow V$$.
It is defined as follows:
$$T^\ast w$$ is the unique vector in V such that
$$\langle Tv , w \rangle = \langle v , T^{\ast}w \rangle $$.

The function $$\ast : T \rightarrow T^{\ast}$$ has the following properties:

$$
(S + T)^\ast = S^\ast + T^\ast,
(aT)^\ast = {\overline a} \, T^\ast,
(T^\ast)^\ast = T,
I^\ast = I,
(ST)^\ast = T^\ast S^\ast
$$

[wiki function]: https://en.wikipedia.org/wiki/Function_(mathematics)
