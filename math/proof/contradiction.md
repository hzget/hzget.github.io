<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Proof by Contradiction

A ***proof by contradiction*** is an ***indirect proof***.
Sppose a proposition is false, and then deduce
a logical contradiction. We can conclude that
the propositon is true.

It helps a lot when the direct proof is impossible
or the direct proof spends lots of time.

***Method:*** In order to prove a proposition P by contradiction:

1. Write, "We use proof by contradiction."
2. Write, "Suppose P is false."
3. Deduce something known to be false (a logical contradiction).
4. Write, "This is a contradiction. Therefore, P must be true."

## An Example: direct proof is difficult

***Theorem*** $$\sqrt{2}$$ is irrational.

***Hint:*** Remember that a number
is rational if it is equal to a ratio of integers,
for example, 3.5 = 7/2.

***PROOF:*** We use proof by contradiction.
Suppose the claim is false, and $$\sqrt{2}$$ is rational.
Then we can write $$\sqrt{2}$$ as a fraction n/d in lowest terms.

Squaring both sides gives $$2=n^2/d^2$$ and so $$2d^2=n^2$$.
This implies that n is even.
Therefore $$n^2$$ must be a multiple of 4.
But since $$2d^2=n^2$$, we know $$2d^2$$ is a multiple of 4
and so $$d^2$$ is even. This implies that d is even.

So, the assumption that ***$$\sqrt{2}$$ is rational*** leads
to the conclusion that both n and d are even for $$\sqrt{2}=n/d$$,
contrary to the fact that n/d is in lowest terms.
Thus, $$\sqrt{2}$$ must be irrational.

## An Example: direct proof is a waste of time

Make $$\mathcal{P}_2(R)$$ into an inner-product space
by defining

$$\langle p, q \rangle = \int_0^1 \!p(x)q(x)\, \mathrm{d}x$$.

Define $$T \in \mathcal{L}(\mathcal{P}_2(R))$$
by $$T(a_0 + a_1x + a_2x^2) = a_1x$$.  
***Question*** Show that T is not self-adjoint.

***Some Thought:***
The direct way is to calculate the adjoint of T
and then show that they do not equal with each other.
However, it needs a great effort to get the adjoint of T.
It's a waste of time.
We can consider the indirect method.

***PROOF:***

Sppose T is self-adjoint, by the definition of self-adjoint,
we have

$$\begin{eqnarray}
\langle Tv, v \rangle = \langle v, Tv \rangle
\mbox{ for any } v \in V
\tag{1}\label{eq:not-self-adjoint}\end{eqnarray}$$

We can find a contradiction with a conterexample:

$$\begin{align*} \langle T1, x \rangle
& = \langle 0, x \rangle = 0 \\
\langle 1, Tx \rangle
& = \langle 1, 1 \rangle = 1
\end{align*}$$

We have $$\langle T1, x \rangle \neq \langle 1, Tx \rangle$$,
contrary to the conclusion $$\eqref{eq:not-self-adjoint}$$ of the assumption.
Hence T is not self-adjoint.
