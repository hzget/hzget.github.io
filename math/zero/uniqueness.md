<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Uniqueness

Uniqueness is always verified with 0.

## linear combination and linear independent

Suppose $$v_1,\cdots,v_m \in V$$ and $$v \in span(v_1,\cdots,v_m)$$.
By the definition of span, there exists $$a_1,\cdots,a_m \in F$$ such that

$$v = a_1v_1 + \cdots + a_mv_m$$

Consider the question of whether the choice of a's
in the equation above is unique.

Suppose $$\hat{a}_1,\cdots,\hat{a}_m$$ is another
set of scalars such that

$$v = \hat{a}_1v_1 + \cdots + \hat{a}_mv_m$$

Substract two equations, we have

$$0 = (a_1-\hat{a}_1)v_1 + \cdots + (a_m-\hat{a}_m)v_m$$

Thus we have written 0 as a linear combination
of $$v_1,\cdots,v_m$$.

***If the only way to do this is*** the abvious way (using
0 for all scalars), ***then*** each $$a_j-\hat{a}_j$$ is 0,
which means $$a_j=\hat{a}_j$$ (and thus the choice
of a's is unique).

(The uniqueness leads to an important concept:
A list $$v_1,\cdots,v_m \in V$$ is called
***linear independent*** if the only choice
of $$a_1,\cdots,a_m \in F$$ that makes $$a_1v_1+\cdots+a_mv_m$$
equal 0 is $$a_1=\cdots=a_m=0$$.)

Each time we need to check uniqueness, just
only need to check linear independence which is
defined with 0.  

## injective

A linear map $$T: V \rightarrow W$$ is called
***injective*** if whenever $$u, v \in V$$
and $$T(u)=T(v)$$, we have $$u=v$$.

How to make it possible?

From the statement we have

$$0=Tu-Tv=T(u-v)$$

Just consider the case of null T = {0}. It makes
u - v = 0. Thus we can check whether T is injective
via checking whether null T = {0}.

## linear functional

Suppose $$\varphi$$ is a linear functional on V.
Then there is a ***unique*** vector $$v \in V$$
such that

$$\varphi(u)=\langle u, v\rangle$$

for every $$u \in V$$.

We will not prove the existance of v but focus
on the uniqueness of v.

Suppose $$v_1,v_2 \in V$$ are such that

$$\varphi(u)=\langle u, v_1\rangle=\langle u, v_2\rangle$$

for every $$u \in V$$. Then

$$0=\langle u, v_1\rangle - \langle u, v_2\rangle
=\langle u, v_1 - v_2\rangle$$

Taking $$u=v_1 - v_2$$ show that $$v_1 - v_2=0$$
which means $$v_1 = v_2$$. In other words,
the desired vector v is unique.

This example shows how we verify the uniqueness
with 0.

## an application of uniqueness

Suppose $$P=\mathcal{L}(V)$$ is such that $$P^2=P$$.
Prove that P is orthogonal projection if and only if
P is self-adjoint.

Note: we only focus on one direction: if P is orthogonal
projection then P is self-adjoint. The other directon is omitted.

***Hint:*** P is self-adjoint, we have $$P=P^\ast$$.

From $$P^2=P$$, we have $$V=range\,P \oplus null\,P$$
and that any vector v from V has a unique
decompositon: $$v=u+w$$ where $$u \in range\, P$$
and $$w \in null\, P$$. We also have $$ Pu=u,\,Pw=0$$.
In a word, P is a projection of V onto range P.

If P is orthogonal, we have $$\langle u, w\rangle = 0$$.
Thus we have

$$\langle v, {\color{red}{Pv'}}\rangle
= \langle u, u'\rangle
= \langle Pv, v'\rangle
= \langle v, {\color{red}{P^\ast v'}}\rangle$$

Consider the definition of adjoint,

> Let $$T \in \mathcal{L}(V, W)$$, fix w from W,
> The adjoint of T is a function $$T^\ast : W \rightarrow V$$
> such that
> $$\langle Tv , w \rangle = \langle v , T^{\ast}w \rangle $$.

From the uniqueness property of linear functional,
we have that $$T^\ast w$$ is unique.
we have $$Pv'=P^\ast v'$$ for any $$v' \in V$$.
It means that $$P^\ast = P$$.

Note: There's another way to prove the claim in the [equation](./equation.md) page.
