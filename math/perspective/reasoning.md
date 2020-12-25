<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Reasoning

We can prove some "guess" directly without any counterintuitive method.
We shall begin with ***what we know***,
transform the problem to an easy form or "usual form".

## Example root of minimal polynomial

***Theorem:*** Let $$T\in\mathcal{L}(V)$$. Then
the roots of the minimal polynomial of T are
precisely the eigenvalues of T.

hint:  
minimal polynomial is the monic polynomial $$p\in\mathcal{P}(F)$$
of smallest degree such that $$p(T)=0$$:

$$p(z)=a_0+a_1z+a_2z^2+\cdots+a_{m-1}z^{m-1}+z^m$$

A root $$\lambda$$ of the minimal polynomial means two different forms:

[1] $$p(z)=(z-\lambda)q(z)$$  
[2] $$p(\lambda)=0$$

PROOF: Let's first proof one direction:
The eigenvalues of T are the roots of the
minimal polynomial of T.

Suppose $$\lambda\in F$$ is an eigenvalue
of T. To prove that $$\lambda$$
is a root of the minimal polynomial, we can
proof that $$p(\lambda)=0$$. The following
is a way to make it:

$$p(\lambda)=0 \Leftarrow p(\lambda)u=0$$

for some nonzero vector $$u\in V$$.
We are talking about eigenvalues, so we can
take its nonzero eigenvector v into consideration.

$$\begin{align*} p(\lambda)v
& = (a_0+a_1\lambda+a_2\lambda^2+\cdots+a_{m-1}\lambda^{m-1}+\lambda^m)v \\
& = a_0v+a_1\lambda v+a_2\lambda^2v+\cdots+a_{m-1}\lambda^{m-1}v+\lambda^mv \\
& = a_0Iv+a_1Tv+a_2T^2v+\cdots+a_{m-1}T^{m-1}v+T^mv \\
& = (a_0I+a_1T+a_2T^2+\cdots+a_{m-1}T^{m-1}+T^m)v \\
& = p(T)v=0 \\
v \neq 0 & \Rightarrow p(\lambda)=0
\end{align*}$$

The equation means that eigenvalues of T
are roots of the minimal polynomial of T.
