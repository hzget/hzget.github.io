<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Reasoning

To prove some "guess", we're in the process of
logical thinking - reasoning.

1. transform it into the "usually used form" or "easy form"
2. find a connection between the new form and the "guess"
3. apply the "to-prove-A-is-to-prove-B" method in the process

## Example - root of minimal polynomial

***Theorem:*** Let $$T\in\mathcal{L}(V)$$. Then
the roots of the minimal polynomial of T are
precisely the eigenvalues of T.

**hint:**
The polynomial

$$p(z)=a_0+a_1z+a_2z^2+\cdots+a_{m-1}z^{m-1}+z^m$$

is called the ***minimal polynomial*** of T.
It is the monic polynomial $$p\in\mathcal{P}(F)$$
of smallest degree such that $$p(T)=0$$.

A root $$\lambda$$ of the minimal polynomial means two different forms:

[1] $$p(z)=(z-\lambda)q(z)$$  
[2] $$p(\lambda)=0$$

A scalar $$\lambda\in F$$ is called ***eigenvalue***
of $$T\in\mathcal{L}(V)$$ if there exists a nonzero
vector $$u\in V$$ such that $$Tu=\lambda u$$.

We have two forms to express it:

[1]$$Tu=\lambda u$$  
[2]$$(T-\lambda I)u=0$$

***PROOF:*** Let

$$p(z)=a_0+a_1z+a_2z^2+\cdots+a_{m-1}z^{m-1}+z^m$$

be the minimal polynomial of T.

Suppose $$\lambda\in F$$ is a root of p.
To prove that $$\lambda$$ is an eigenvalue of T,
we need to find a nonzero vecotr $$u\in V$$ such
that $$(T-\lambda I)u=0$$.

The polynomial can be written in the form

$$p(z)=(z-\lambda)q(z)$$

Apply it to the operator, we have

$$0=p(T)=(T-\lambda I)q(T)$$

We are talking about operators, so we shall
take vectors into consideration:

$$0=p(T)v=(T-\lambda I)q(T)v$$

for all $$v\in V$$. Because the degree of q
is less than that of the minimal polynomial p, there
must exist at least one $$v\in V$$ such
that $$q(T)v \neq 0$$. The equation above
thus implies that $$\lambda$$ is an eigenvalue
of T, as disired.

Now prove the other direction.
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
