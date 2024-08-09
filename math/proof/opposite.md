<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# proof by the opposite

The opposite may give useful information.

## Examples

### 1.1

***Theorem:*** Suppose S is an ordered set with
the least-upper-bound property, prove that S has
the great-lower-bound property. In other words,
Suppose $$B \subset S$$, B is not empty and B is bounded below,
prove that inf B exists in S.

***hint:*** An ordered set S is said to have
the least-upper-bound property if the following
is true:

If $$E \subset S$$ is not empty and E is bounded above,
then sup E exists in S.

We cannot prove the theorem directly but can
exploit its opposite and find something.

***PROOF:*** Let L be the set of all lower bounds
of B. We'll prove that $$\alpha = \mbox{ sup }L$$
exists in S and $$\alpha = \mbox{ inf }B$$.

Since B is bounded below, L is not empty. Since L
consists of exactly those $$y \in S$$ which satisfy
the inequality $$y \leq x$$ for every $$x \in B$$,
we see that every $$x \in B$$ is an upper bound of L.
Thus L is bounded above. Our hypothesis about S
implies therefore that L has a supermum in S; call
it $$\alpha$$.

* If $$\gamma < \alpha$$ then $$\gamma$$ is not an
upper bound of L, hence $$\gamma \notin B$$. It
follows that $$\alpha \leq x$$ for every $$x \in B$$.
Thus $$\alpha \in L$$.
* If $$\alpha < \beta$$ then $$\beta \notin L$$,
since $$\alpha$$ is an upper bound of L.

We have show that $$\alpha \in L$$ but $$\beta \notin L$$
if $$\beta > \alpha$$. In other words, $$\alpha$$ is
a lower bound of B but $$\beta$$ is not if $$\beta > \alpha$$.
This means that $$\alpha = \mbox{ inf }B$$.
