<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# induction

Mathematical [induction][induction wiki] is a mathematical proof technique.
It is essentially used to prove that a statement P(n) holds for
every natural number n = 0, 1, 2, 3, . . .

Informal metaphors help to explain this technique,
such as falling dominoes or climbing a ladder:

> Mathematical induction proves that we can climb
> as high as we like on a ladder, by proving that
> we can climb onto the bottom rung (the basis) and
> that from each rung we can climb up to the next one (the step).
>
> -- Concrete Mathematics, page 3 margins.

## The example of Real Spectral Theorem

***Real Spectral Theorem*** : Suppose that V is
a real inner-product space and $$T \in \mathcal{L}(V)$$.
Then the following are equivalent:  
(a) T is self-adjoint.  
(b) V has an orthonormal basis consisting of eigenvectors of T.

PROOF:

(b) to (a) is simple, we will ignore it in this example.
We will focus on (a) to (b).

We will prove that (a) implies (b) by induction on dim V.  
***base case*** :
To get started, note that if dim V = 1 , then (a) implies (b).  

***induction step*** :
Now assume that dim V > 1 and that (a) implies (b)
for all real inner product spaces of smaller dimension.

The idea of the proof is to take any eigenvector u of T
with norm 1, then adjoint it to an orthonormal basis
of $$U^\bot$$ (U=span(u)) consisting of eigenvectors
of $$T|_{U^\bot}$$.

Now for the details, the most important of which is
verifying that $$T|_{U^\bot}$$ is self-adjoint.
In other words, we need to find
***a connection between the self-adjoint operator S on $$U^\bot$$ and T***
(this allows us to apply the induction hypothesis).

* $$U^\bot$$ is invariant under T

Suppose $$v \in U^\bot$$, we have:

$$\langle u, Tv \rangle = \langle Tu, v \rangle
                        = \langle \lambda u, v \rangle
                        = \lambda \langle u, v \rangle = 0 $$

Thus $$Tv \in U^\bot$$. In other words, $$U^\bot$$ is
invariant under T.

* find an operator that is self-adjoint on $$U^\bot$$

Thus we can define an operator
$$S \in \mathcal{L}(U^\bot) \mbox{ by } S=T|_{U^\bot}$$.
If $$u, v \in U^\bot$$, then

$$\langle Sv, w \rangle = \langle Tv, w \rangle
                        = \langle v, Tw \rangle
                        = \langle v, Sw \rangle$$,

which shows that S is self-adjoint.

Thus, by our induction hypothesis, there is an
orthonormal basis of $$U^\bot$$ consisting of
eigenvectors of S. ***Clearly every eigenvector of S
is an eigenvector of T*** (because Sv = Tv for every
$$v \in U^\bot$$).

Thus adjoining u to orthonormal basis of $$U^\bot$$
consisting of eigenvectors of S gives an orthonormal
basis of V consisting of eigenvectors of T, as desired.

## Example of operators that have an upper-triangular matrix

***Theorem***: Suppose V is a complex vector space
and $$T \in \mathcal{L}(V)$$. Then T has an
upper-triangular matrix with respect to some basis of V.

PROOF:

We will use induction on the dimension of V.

***base case*** : Clearly the desired result holds if dim V = 1.

***induction step*** : Suppose now that dim V > 1 and
the desired result holds for all complex vector spaces
of smaller dimension:

1. U is a complex vector space and dim U < dim V

2. Any operator $$S \in \mathcal{L}(U)$$ has an
upper-triangular matrix with respect to some
basis of U: $$(u_1, \cdots, u_m)$$. In other words,
for each j we have,

$$Su_j \in span(u_1, \cdots, u_m)$$

To complete the induction, there're two issues to resolve:

1. some connection between S and T: Su = Tu

2. extend basis of U to basis of V: $$(u_1, \cdots, u_m,
v_1, \cdots, v_n)$$, for each k, the following shall be true:

$$Tv_k \in span(u_1, \cdots, u_m, v_1, \cdots, v_n)$$

Let's consider the following:

$$Tv_k = (T - \lambda I)v_k + \lambda v_k$$

We can define a vector space of $$U = range(T - \lambda I)$$.
The defination shows that $$(T - \lambda I)v_k \in U$$. Thus
the above equation holds.

Now consider the first issue. U is invariant under T because that:

$$ Tu = (T - \lambda I)u + \lambda u \in U$$

We can define S by $$S = T|_U$$, in other words, S is
just T restricted to U. We have

$$Su_j = T|_U u_j \in span(u_1, \cdots, u_m)$$

From the above, we conclude that T has an upper-triangular matrix
with respect to the basis $$(u_1, \cdots, u_m, v_1, \cdots, v_n)$$.

[induction wiki]: https://en.wikipedia.org/wiki/Mathematical_induction
