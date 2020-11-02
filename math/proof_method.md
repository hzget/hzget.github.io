<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Proofs

## if and only if -- iif

A <---> B is equivalent with not A <---> not B

It comes from that:

* A ---> B is equivalent with not A <--- not B
* A <--- B is equivalent with not A ---> not B

Sometimes it is easy to prove the negative statement,
so we can prove the negative equilavence instead.

### Example

Suppose $$T \in \mathcal{L}(V) \, \mbox{and} \, \lambda \in F$$.
Prove that $$\lambda$$ is an eigenvalue of T if and only if
$$\overline{\lambda}$$ is an eigenvalue of $$T^\ast$$.

PROOF:

The equivalence is the following:
$$\lambda$$ is not an eigenvalue of T if and only if
$$\overline{\lambda}$$ is not an eigenvalue of $$T^\ast$$

Thus we have:

$$\begin{align*}
\lambda \mbox{ is not an eigenvalue of } T
& \Leftrightarrow T - \lambda I \mbox{ is invertable} \\
& \Leftrightarrow S(T - \lambda I) = (T - \lambda I)S = I \mbox{ for some } S \in \mathcal{L}(V) \\
& \Leftrightarrow (T - \lambda I)^\ast S^\ast = S^\ast (T - \lambda I)^\ast = I
\mbox{ for some } S^\ast \in \mathcal{L}(V) \\
& \Leftrightarrow (T - \lambda I)^\ast \mbox{ is invertable} \\
& \Leftrightarrow T^\ast - \overline{\lambda} I \mbox{ is invertable} \\
& \Leftrightarrow \overline{\lambda} \mbox{ is not an eigenvalue of } T^\ast
\end{align*}$$

## proofs related to equation and inequation

Suppose A = B, we have A - B = 0. To prove something
with the equation, we can start from `A - B`.
It works in the same way for the case of inequation.

### Examples of Equation

Suppose V is a complex inner product space
and $$T \in \mathcal{L}(V)$$. Then T is
self-adjoint if and only if $$\langle Tv , v \rangle \in R$$
for every v 2 V.

PROOF:

From the property of R, we have
$$\langle Tv , v \rangle = \overline{\langle Tv , v \rangle}$$.
Thus we can start the proof from
$$\langle Tv , v \rangle - \overline{\langle Tv , v \rangle}$$.

the proof:
$$\begin{align*}
\langle Tv , v \rangle - \overline{\langle Tv , v \rangle}
& = \langle Tv , v \rangle - \langle v , Tv \rangle \\
& = \langle Tv , v \rangle - \langle T^\ast v , v \rangle \\
& = \langle (T - T^\ast) v , v \rangle \\
\mbox{Thus} \; \langle Tv , v \rangle \in R & \Leftrightarrow T - T^\ast = 0
\end{align*}$$

### Examples of Inequation

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
(\alpha - \beta)\langle u , v \rangle
& = \langle \alpha u , v \rangle - \langle u , \overline{\beta}v \rangle \\
& = \langle Tu , v \rangle - \langle u , T^\ast v \rangle \\
& = 0 \\
\alpha \neq \beta & \Rightarrow \langle u , v \rangle = 0
\end{align*}$$
