<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Begin with what we know

Sometimes it is not easy to solve the required problem,
we can turn to find another problem that already has a solution.

To address the problem A, we're in the pipeline of
"find and apply".

1. find another problem B with a known solution
2. find a connection between A and B
3. apply the "to-solve-A-is-to-solve-B" method in the process

## Example - Random walk

***Example 3.7.2*** (Random walk). A particle moves n steps on a number line. The
particle starts at 0, and at each step it moves 1 unit to the right or to the left,
with equal probabilities. Assume all steps are independent. Let Y be the particle’s
position after n steps. Find the PMF of Y .

***Solution:***

The only movement at each step is to move right or to move left.
We're tempted to consider the number of right steps
and left steps after all movement. And then we get the position
by adding up these steps:

* if the number of right steps is $$x$$
* then the number of left steps is $$n-x$$
* and the position is $$x-(n-x)=2x-n$$

Let X be the number of right steps after n steps.
Its distribution and PMF are known:

$$X\sim Bin(n,1/2)$$

(Consider each step to be a Bernoulli trial,
where right is considered a success.
Then X has the Binomial distribution
with parameters n and 1/2.)

There's a connection between Y and X:

$$Y=2X-n$$

The PMF of Y can then be found from the PMF of X:

$$p(Y=k)=p(2X-n=k)=p(X=(n+k)/2)=\binom{n}{\frac{n+k}{2}}\left(\frac{1}{2}\right)^n$$

where k is an integer between −n and n (inclusive) such that n+k is an even number.

The example illustrates a strategy for
finding the PMF of an r.v. with an unfamiliar distribution:
try to express the r.v. as a function of an r.v. with a known
distribution.
