<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Back to Abstraction

> one of the most important skills to develop
> when studying probability and statistics
> is the ability to ***go back and forth***
> between ***abstract ideas and concrete examples***.
> Relatedly, it is important to work on
> recognizing the essential pattern or structure
> of a problem and how it connects to problems
> you have studied previously.  
> ---- "introduction to probability"

## Example of counting

### Example of Club officers

***Example 1.4.17*** (Club officers) In a club with n people, there are n(n−1)(n−2)
ways to choose a president, vice president, and treasurer, and there are

$$\binom{n}{3} = \frac{n(n−1)(n−2)}{3!}$$

ways to choose 3 officers without predetermined titles.

***Hint:***

***Theorem 1.4.1*** (Multiplication rule). Consider a compound experiment consisting
of two sub-experiments, Experiment A and Experiment B. Suppose that Experiment
A has a possible outcomes, and for each of those outcomes Experiment B has b
possible outcomes. Then the compound experiment has ab possible outcomes.

***Definition 1.4.14*** (Binomial coefficient).
For any nonnegative integers k and n, the binomial coefficient

$$\binom{n}{k}$$

read as “n choose k”, is the number of subsets of size
k for a set of size n.

***Theorem 1.4.15*** (Binomial coefficient formula). For k ≤ n, we have

$$\binom{n}{k} = \frac{n(n-1)\cdots (n-k+1)}{k!} = \frac{n!}{k!(n-k)!}$$

***Analysis***

Firstly, we need to ***label object*** for counting.
Every people id corresponds to a ball No.

Then we need to find whether it is a problem of ***Multiplication rule***
or a problem of ***Binomial coeffient***. The former means there
are 3 sub-experiments and each corresponds to one title, whereas
the latter means "n choose k" without difference between them (there are no orders/titles in a subset).

### Example of Permutations of a word

***Example 1.4.18*** (Permutations of a word). How many ways are there to permute
the letters in the word LALALAAA? To determine a permutation, we just need to
choose where the 5 A’s go (or, equivalently, just decide where the 3 L’s go).
So there are

$$\binom{8}{5} = \binom{8}{3} = \frac{8*7*6}{3!} = 56$$

permutations.

***hint:*** Firstly, we need to ***label object*** for
counting -- seat No's correspond to ball No's. And that we
can find it's a problem of "n choose k" (All A's are the same and All L's are the same).

How many ways are there to permute the letters in the word STATISTICS?
We could choose where to put the S’s, then where to put the
T’s (from the remaining positions), then where to put the I’s, then where to put
the A (and then the C is determined). It gives

$$\binom{10}{3} \binom{7}{3} \binom{4}{2} \binom{2}{1} = 50400$$

possibilities.

***hints:*** Firstly, it is a problem of ***Multiplication rule***.
Each of the sub-experiment is a problem of ***n choose k***.
