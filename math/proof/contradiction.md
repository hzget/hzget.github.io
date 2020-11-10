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

## when direct proof is difficult

***Theorem:*** There is no rational p such that $$p^2=2$$.

***Hint:*** rational numbers: the numbers of the form m/n,
where m and n are integers and n is not 0.

***PROOF:*** We use proof by contradiction.
Suppose the claim is false, and there were
such a rational p that $$p^2=2$$. We can write $$p=m/n$$
where m and n are integers that are not
both even. Lets assume this is done.

Then $$p^2=2$$ implies that $$m^2=2n^2$$. This
shows that $$m^2$$ is even. Hence m is even,
and so $$m^2$$ is divisible by 4. It follows
that the right side is devisible by 4, so
that $$n^2$$ is even, which implies that n is even.

The assumption that "such a rational p exists
for $$p^2=2$$" leads to the conclusion that
both m and n are even, contrary to our choice
of m and n. Hence, $$p^2=2$$ is not possible for
rational p.

## when direct proof needs a great effort

Make $$\mathcal{P}_2(R)$$ into an inner-product space
by defining

$$\langle p, q \rangle = \int_0^1 \!p(x)q(x)\, \mathrm{d}x$$

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

We use proof by contradiction. Suppose the claim is false,
and T is self-adjoint. Then, by the definition of adjoint,
for any $$v, w \in \mathcal{P}_2(R)$$, we
have $$\langle Tv, w \rangle = \langle v, Tw \rangle$$.

Turn to the vectors $$1\, , \, x \in \mathcal{P}_2(R)$$.
We have $$\langle T1, x \rangle = \langle 0, x \rangle = 0$$  
and $$ \langle 1, Tx \rangle = \langle 1, 1 \rangle = 1$$.

The assumption (that "T is self-adjoint") leads to
the conclusion $$\langle Tv, w \rangle = \langle v, Tw \rangle$$,
contrary to the fact that $$\langle T1, x \rangle \neq \langle 1, Tx \rangle$$.
Hence T is not self-adjoint.
