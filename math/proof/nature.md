<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# nature

When we're investigating something, we shall
keep in mind it's basic quality or characters of that object.

## linear map or operator

A linear map or an operator is defined with
the vectors and vector space(s).
When we're talking about the operator, we shall
write down the vector form T(v) and then exploit it
via properties of the operator.

### polar decomposition

***Polar Decomposition:*** If $$T \in \mathcal{L}(V)$$,
then there exists an isometry $$S \in \mathcal{L}(V)$$
such that $$T = S \sqrt{T^\ast T}$$

Question: Prove that T is invertible if and only if
such S is unique.

***Some Thought:***
Let's consider one direction: if T is invertible,
S is unique. The uniqueness means that for any two
isometries S and S' that satisfy the polar decomposition,
we have S = S'.

How to make that possible? Let's write down
the vector form

$$Sv = S'v$$

If it is true for any $$v \in V$$. Then it imples S = S'.
From the polar decomposition, we have

$$S \sqrt{T^\ast T} v = Tv = S' \sqrt{T^\ast T}v$$

for any $$v \in V$$. It seems we're done.
However it is not the case.
The vector $$\sqrt{T^\ast T} v$$ does
***not represent (explictly) all*** vectors in the vector space V.
We shall prove the exact form:

$$Sv=S'v \mbox{ for any } v \in V$$

We can decompse the vector v to a basis of V,
and then check how the operator S works on the basis.

Now turn to the condition: T is invertible. It
implies $$\sqrt{T^\ast T}$$ is invertible(The proof is omitted).

Suppose $$e_1,\cdots,e_n$$ is a basis of V,
we have that $$\sqrt{T^\ast T}e_1,\cdots,\sqrt{T^\ast T}e_n$$
is a basis of V.
Take any $$v \in V$$ as a linear combination of that basis

$$v=a_1\sqrt{T^\ast T}e_1 + \cdots + a_ne\sqrt{T^\ast T}_n$$

we have

$$\begin{align*} Sv
& = a_1S\sqrt{T^\ast T}e_1 + \cdots + a_nS\sqrt{T^\ast T}e_n \\
& = a_1Te_1 + \cdots + a_nTe_n \\
& = a_1S'\sqrt{T^\ast T}e_1 + \cdots + a_nS'\sqrt{T^\ast T}e_n \\
& = S'v
\end{align*}$$

for any $$v \in V$$. Thus we have S=S'. Hence the desired
isometry is unique.

### Example 2

Suppose $$T \in \mathcal{L}(V)$$, $$S \in \mathcal{L}(V)$$
is an isometry, and $$R \in \mathcal{L}(V)$$ is a
positive operator such that $$T=SR$$. Prove
that $$R=\sqrt{T^\ast T}$$

***Some Thought:*** From $$T=SR$$, let's write the vector form:

$$Tv=SRv$$

And then exploit the expression and make use of properties of
the operator. S is an isometry, we have $$\|SRv\|=\|Rv\|$$.
Thus we have

$$\|Tv\|=\|SRv\|=\|Rv\|$$

***PROOF:*** From $$T=SR$$, we have $$\|Tv\|=\|SRv\|=\|Rv\|$$
for any $$v \in V$$. Thus we have the following equivalence:

$$\begin{align*} 0
& = \|Tv\|^2 - \|Rv\|^2 \\
& = \langle Tv,Tv\rangle - \langle Rv,Rv\rangle \\
& = \langle (T^\ast T-R^\ast R)v,v\rangle
\end{align*}$$

Since $$T^\ast T-R^\ast R$$ is self-adjoint, we
have $$T^\ast T-R^\ast R=0$$, which means $$T^\ast T=R^\ast R=R^2$$.
The positive operator has a unique square root, we
get $$R=\sqrt{T^\ast T}$$.

There's another way to prove it in [equation](../zero/equation.md) page.
