<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Equations and Zero

Zero is a special object and it helps a lot
when we exploit properties of many concepts.

Suppose a = b, we have a - b = 0. To prove something
with the equation, we can start from `0 = a - b`.

## Example 1

Suppose $$P=\mathcal{L}(V)$$ is such that $$P^2=P$$.
Prove that P is orthogonal projection if and only if
P is self-adjoint.

Note: we only focus on one direction: if P is orthogonal
projection then P is self-adjoint. The other directon is omitted.

***Hint:*** P is self-adjoint, we have $$P=P^\ast$$.

***PROOF:*** We have the following equivalent:

$$\begin{align*} P = P^\ast
& \Leftrightarrow \color{red}{P - P^\ast = 0} \\
& \Leftrightarrow (P - P^\ast)v = 0, \mbox{ for any }v \in V \\
& \Leftrightarrow \langle(P - P^\ast)v, v'\rangle = 0, \mbox{ for any }v, v' \in V
\end{align*}$$

To prove P is self-adjoint, is to prove
that $$\langle(P - P^\ast)v, v'\rangle = 0$$
for any $$v, v' \in V$$.

From $$P^2=P$$, we have $$V=range\,P \oplus null\,P$$
and that any vector v from V has a unique
decompositon: $$v=u+w \mbox{ with } Pu=u,\,Pw=0$$.
In a word, P is a projection of V onto range P.

If P is orthogonal, we have $$\langle u,v \rangle = 0$$.
Thus we have

$$\begin{align*}
\langle(P - P^\ast)v, v'\rangle
& = \langle Pv, v'\rangle - \langle P^\ast v, v'\rangle \\
& = \langle Pv, v'\rangle - \langle v, Pv'\rangle \\
& = \langle u, u'+w'\rangle - \langle u+w, u'\rangle \\
& = \langle u, u'\rangle - \langle u, u'\rangle \\
& = 0
\end{align*}$$

Hence P is self-adjoint.

## Example 2

Suppose V is a complex inner product space
and $$T \in \mathcal{L}(V)$$. Then T is
self-adjoint if and only if $$\langle Tv , v \rangle \in R$$
for every v from V.

PROOF:

From the property of R, we have
$$\langle Tv , v \rangle = \overline{\langle Tv , v \rangle}$$.
Therefore, we can start the proof from
$$0=\langle Tv , v \rangle - \overline{\langle Tv , v \rangle}$$:

$$\begin{align*}
\color{red}{0 = \langle Tv , v \rangle - \overline{\langle Tv , v \rangle}}
& = \langle Tv , v \rangle - \langle v , Tv \rangle \\
& = \langle Tv , v \rangle - \langle T^\ast v , v \rangle \\
& = \langle (T - T^\ast) v , v \rangle
\end{align*}$$

Because V is a complex inner-product vector space,
we have:

$$\langle Tv , v \rangle \in R
\Leftrightarrow {\color{red}{0 = \langle Tv , v \rangle - \overline{\langle Tv , v \rangle}}}
\Leftrightarrow T - T^\ast = 0$$

## Inequation

Suppose $$T \in \mathcal{L}(V)$$ is normal.
Then eigenvectors of T corresponding to
distinct eigenvalues are orthogonal.

PROOF:

Given the requirement:
$$ Tu = \alpha u, \, Tv = \beta v, \, \alpha \neq \beta $$,
we need to prove that $$\langle u , v \rangle = 0$$.
we can make use of the "not equal" relation:

$$\alpha \neq \beta \Rightarrow \alpha - \beta \neq 0$$

Thus we can begin with it for the proof:

$$\begin{align*}
{\color{red}{(\alpha - \beta)}}\langle u , v \rangle
& = \langle \alpha u , v \rangle - \langle u , \overline{\beta}v \rangle \\
& = \langle Tu , v \rangle - \langle u , T^\ast v \rangle \\
& = 0 \\
\alpha \neq \beta & \Rightarrow \langle u , v \rangle = 0
\end{align*}$$
