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
decompositon: $$v=u+w$$ where $$u \in range\, P$$
and $$w \in null\, P$$. We also have $$ Pu=u,\,Pw=0$$.
In a word, P is a projection of V onto range P.

If P is orthogonal, we have $$\langle u, w\rangle = 0$$.
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

Note: There's another way to prove it in the [uniqueness](./uniqueness.md) page.

## Example 2

An operator $$T \in \mathcal{L}(V)$$ is normal
if and only if $$\|Tv\|=\|T^\ast v\|$$.

***PROOF:*** T is normal means that $$TT^\ast=T^\ast T$$.
We have the following equivalent:

$$\begin{align*} TT^\ast=T^\ast T
& \Leftrightarrow \color{red}{TT^\ast \! - T^\ast T = 0} \\
& \Leftrightarrow \langle (TT^\ast-T^\ast T)v, v\rangle=0 \;\; \forall v \in V \;
(\mbox{Note: } TT^\ast \! - \! T^\ast T \mbox{ is self-adjoint})\\
& \Leftrightarrow \langle TT^\ast v, v\rangle - \langle T^\ast Tv, v\rangle=0 \;\; \forall v \in V \\
& \Leftrightarrow {\color{red}{\|T^\ast v\|^2 - \|Tv\|^2 =0}} \;\; \forall v \in V \\
& \Leftrightarrow \|T^\ast v\| = \|Tv\| \;\; \forall v \in V
\end{align*}$$

Note: We can look backward of the reasoning.

## Example 3

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

## Example 4

Propositon: Every eigenvalue of a self-adjoint
operator is real.

***PROOF:*** Suppose T is a self-adjoint operator
on V. Let $$\lambda$$ be an eigenvalue of T,
and let v be a nonzero vecotor such that $$Tv=\lambda v$$.

We want to prove that $$\lambda$$ is real,
which means that $$\lambda = \overline{\lambda}$$.
Consider the following:

$$\begin{align*}
{\color{red}{(\lambda - \overline{\lambda})}} \langle v, v\rangle
& = \langle \lambda v, v\rangle - \langle v, \lambda v\rangle \\
& = \langle Tv, v\rangle - \langle v, Tv\rangle \\
& = 0
\end{align*}$$

Since v is nonzero vector, we have that $$\langle v, v\rangle$$
is not zero. Thus we have $$\lambda - \overline{\lambda} =0$$,
which means that the eigenvalue is real.

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

## Example 6

Suppose T is a positive operator on V, then
all eigenvalues of T are nonnegative.

***PROOF:***
Let $$\lambda$$ be an eigenvalue of T,
and let v be a nonzero vecotor such that $$Tv=\lambda v$$.
To prove that $$\lambda \geq 0$$, we can consider
the expression of $$\lambda \langle v,v\rangle$$:

$$\begin{align*}
{\color{red}{\lambda}} \langle v, v\rangle
& = \langle \lambda v, v\rangle \\
& = \langle Tv, v\rangle \geq 0 \\
\langle v, v\rangle > 0
& \Rightarrow \lambda \geq 0
\end{align*}$$

## Example 7

Suppose $$T \in \mathcal{L}(V)$$, $$S \in \mathcal{L}(V)$$
is an isometry, and $$R \in \mathcal{L}(V)$$ is a
positive operator such that $$T=SR$$. Prove
that $$R=\sqrt{T^\ast T}$$.

***PROOF:*** From the condition, we have the following:

$$\begin{align*} T=SR
& \Rightarrow T-SR=0 \\
& \Rightarrow (T-SR)v=0 \mbox{ for any }v \in V \\
& \Rightarrow \langle (T-SR)v,SRv\rangle = 0 \mbox{ for any }v \in V \\
\end{align*}$$

Thus we have

$$\begin{align*} 0
& = \langle (T-SR)v,SRv\rangle \\
& = \langle Tv,SRv\rangle - \langle SRv,SRv\rangle \\
& = \langle Tv,Tv\rangle  - \langle Rv,Rv\rangle \\
& = \langle T^\ast Tv,v\rangle + \langle R^\ast Rv,v\rangle \\
& = \langle (T^\ast T-R^2)v,v\rangle
\end{align*}$$

for any $$v \in V$$. Because $$T^\ast T-R^2$$ is self-adjoint,
we have $$T^\ast T-R^2=0$$ which implies $$T^\ast T=R^2$$.
R is positive, we have $$R=\sqrt{T^\ast T}$$.

There's another way to prove it in [nature](../proof/nature.md) page.
