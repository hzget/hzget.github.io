<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# design

Design is to construct an object that obeys some rules,
and with it, we can resolve some problems or deal with complicated situations.

## Examples

### Design an invertible linear map

***Theorem*** : Two finite-dimensional vector spaces over F
are isomorphic if and only if they have the same dimension.

PROOF:

We'll focus on one direction of the proof:
Suppose dim V = dim W, we'll prove that they are isomorphic.

Let $$(v_1, \cdots, v_m)$$ be a basis of V
and $$(w_1, \cdots, w_m)$$ be a basis of W. Let T be
a linear map from V to W ***defined by***

$$T(a_1 v_1 + \cdots + a_m v_m) = a_1 w_1 + \cdots + a_m w_m$$

Then T is surjective and injective, so it is invertible.
Hence V and W are isomorphic, as desired.

Surjective: any w from W, we have
$$w = a_1 w_1 + \cdots + a_m w_m = T(a_1 v_1 + \cdots + a_m v_m) \in range\, T$$

Let's examine this linear map closely. It shows that
the matrix of T with respect to these two basis equals I.

### Design a positive square root

***Theorem*** : Let $$T \in \mathcal{L}(V)$$.
The the following are equivalent:  
(a) T is positive  
(b) T is self-adjoint and all eigenvalues of T are nonnegative;  
(c) T has a positive square root  
(d) T has a self-adjoint square root  
(e) there exists an operator $$S \in \mathcal{L}(V)$$ such that $$T = S^\ast S$$

PROOF: We'll focus on (b) to (c).

Suppose (b) holds. By the spectral theorem, there is
an orthonormal basis ($$e_1, \cdots, e_n$$) of V
consisting of eigenvectors of T.
Let $$\lambda_1, \cdots, \lambda_n$$ be the eigenvalues
of T corresponding to $$e_1, \cdots, e_n$$.
***Define*** $$S \in \mathcal{L}(V)$$ by

$$Se_j = \sqrt{\lambda_j} e_j$$

Then S is positive (proof is omitted here).
Further more, $$S^2 e_j = \lambda_j e_j = T e_j$$ for each j,
which implies that $$S^2 = T$$. Thus S is a positive
square root of T.

### Design an isometry for Polar Decompositon

***Polar Decomposition:*** If $$T \in \mathcal{L}(V)$$,
then there exists an isometry $$S \in \mathcal{L}(V)$$
such that $$T = S \sqrt{T^\ast T}$$.

**Some Thought:**

We shall notice that the square symbol means
that $$\sqrt{T^\ast T}$$ is ***positive square root***
of the positive operator $$T^\ast T$$.

We shall find or design the desired S.
From the requirement, for any v from V, we shall have

$$Tv = S \sqrt{T^\ast T} v = S(\sqrt{T^\ast T}v)$$

Then we're tempted to define(design) S by:

$$S(\sqrt{T^\ast T}v) = Tv$$

It seems the remaining is to proves that S is an isometry.
However, it is not the truth. In fact this definition is
a linear map $$range\, \sqrt{T^\ast T} \rightarrow range\, T$$.
In other words, S is not defined on the whole vector space V,
but on $$range\, \sqrt{T^\ast T} \subset V$$.

We shall also define S on its
orthogonal complement$$(range\, \sqrt{T^\ast T})^\bot$$
And then conbine the two parts we get the operator S
on whole vector space V.
After that, we shall prove if S is an isometry.

In other words, we shall define an operator
on the ***whole*** vector space.
The exact form: Sv for ***any*** $$v \in V$$.

**PROOF:**

Define a linear map $$S_1: range\, \sqrt{T^\ast T}
\rightarrow range\, T$$ by

$$S_1(\sqrt{T^\ast T}v) = Tv$$

Because that

$$\begin{align*} \|Tv\|^2
& = \langle Tv, Tv \rangle \\
& = \langle T^\ast T v, v \rangle \\
& = \langle \sqrt{T^\ast T}\sqrt{T^\ast T}v, v \rangle \\
& = \langle \sqrt{T^\ast T}v, \sqrt{T^\ast T}v \rangle \\
& = \| \sqrt{T^\ast T}v \|^2
\end{align*}$$,

We have $$\|S_1 u\| = \|u\| \mbox{ for all }
u \in range\, \sqrt{T^\ast T}$$. This operator is
injective. It shows that
$$dim\, range\, \sqrt{T^\ast T} = dim\, range\, T$$,
so we have $$dim\, (range\, \sqrt{T^\ast T})^\bot
= dim\, (range\, T)^\bot$$.

The orthonormal bases $$e_1, \cdots, e_m$$
of $$(range\, \sqrt{T^\ast T})^\bot$$ and
the orthonormal basis $$f_1, \cdots, f_m$$
of $$(range\, T)^\bot$$ can be chosen.
The key point is that they have the same dimension.

Now we can define a linear map $$S_2: (range\, \sqrt{T^\ast T})^\bot
\rightarrow (range\, T)^\bot$$ by

$$S_2(a_1e_1 + \cdots + a_me_m) = c_1f_1 + \cdots + c_mf_m$$

where $$|a_k|=|c_k|$$.
Thus we have $$\|S_2 u\| = \|u\| \mbox{ for all }
u \in (range\, \sqrt{T^\ast T})^\bot$$.

Conbine the two part, we have defined the operator S on V
with the following:

[1] $$S = S_1 \,\;\, \mbox{ on } range\, \sqrt{T^\ast T}$$

[2] $$S = S_2 \,\;\, \mbox{ on } (range\, \sqrt{T^\ast T})^\bot$$

Suppose $$v = u + w \mbox{ for } v \in V,
u \in range\, \sqrt{T^\ast T},
w \in (range\, \sqrt{T^\ast T})^\bot$$, we have

$$Sv = S_1u + S_2w$$

and that

$$S(\sqrt{T^\ast T}v) = S_1(\sqrt{T^\ast T}v) = Tv \mbox{ for any } v \in V$$

Thus $$T = S \sqrt{T^\ast T}$$.
The last step is to prove that S is an isometry.

$$\begin{align*} \|Sv\|^2
& = \|S_1u + S_2w\|^2 \\
& = \|S_1u\|^2 + \|S_2w\|^2 \\
& = \|u\|^2 + \|w\|^2 \\
& = \|v\|^2
\end{align*}$$

Thus S is an isometry, as desired.
