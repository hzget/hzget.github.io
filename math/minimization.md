<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Minimization

Suppose $$A \in \mathcal{L}(\mathcal{R}^n, \mathcal{R}^m)$$.
Since $$\left(A^TA\right)^T = A^TA$$, $$A^TA$$ is self-adjoint.
Thus $$\mathcal{R}^n$$ has an orthonormal basis
consisting of eigenvectors of $$A^TA$$:

$$A^TA(v_1,\cdots,v_r,v_{r+1},\cdots,v_n)
= (\lambda_1 v_1,\cdots,\lambda_r v_r,0v_{r+1},\cdots,0v_n)$$

And each eigenvalue is no less than 0: $$\lambda_i \geq 0$$.

Now explore the vector $$Av_i$$.

$$(Av_i)^T(Av_j)=v^T_i A^T A v_j = \lambda_j v^T_i v_j$$

If k > r, $$\|Av_k\|^2 = 0 \rightarrow Av_k=0$$
If i <= r, suppose
$$u_i = \frac{Av_i}{\|Av_i\|}=\frac{Av_i}{\sqrt{\lambda_i}}=\frac{Av_i}{\sigma_i}$$.

We get an orthonormal list $$(u_1, \cdots, u_r)$$.
It is an orthonormal basis of rangeA:

$$\begin{align*}
v   & = a_1 v_1 + \cdots + a_r v_r + a_{r+1} v_{r+1} + \cdots + a_n v_n \\
Av  & = a_1Av_1 + \cdots + a_rAv_r + 0 + \cdots + 0 \\
    & = a_1 \sigma_1 u_1 + \cdots + a_r \sigma_r u_r
\end{align*}$$

We also get an orthonormal basis of nullA: $$(v_{r+1},\cdots, v_n)$$.

And because $$null A^\ast = (range A)^\bot$$ and
$$null A = (range A^\ast)^\bot$$, we have that:

![T and adjoint T](./pic/T_adjoint_T.png)

From $$Ax = \begin{bmatrix} C_1 & C_2 & \cdots & C_n \end{bmatrix} x$$
thus column space of M(A) is rangeA.
From $$Ax = \begin{bmatrix} A_1 \\ A_2 \\ \vdots \\ A_m \end{bmatrix} x$$
thus row space of M(A) is nullA.

Explore the relationship of eigenvectors of $$A^TA$$
and eigenvectors of $$AA^T$$. For i = 1,2,..., r:

$$\begin{align*} A^TAv_i=\lambda_iv_i
& \Rightarrow AA^TAv_i=\lambda_iAv_i \\
& \Rightarrow AA^T\sigma_iu_i=\lambda_i\sigma_iu_i \\
& \Rightarrow AA^Tu_i=\lambda_iu_i \\
\end{align*}$$

Thus $$(u_1,\cdots,u_r)$$ is orthogonal eigenvectors
of $$AA^T$$. Extend it to orthonormal basis of $$\mathcal{R}^m$$:
$$(u_1,\cdots,u_r,u_{r+1},\cdots,u_m)$$ which are orthonormal eigenvectors
of $$AA^T$$.

## Minimization Problem

How to get min of $$\|b - A_{mn}x\|$$?

![minimization](./pic/projection_minimization.png)

If $$Ax=P_Ub \,(U = \mbox{range} A)$$, we get the min:

$$min\|b-Ax\|=\|P_{U^\bot}b\|$$.

Suppose $$(v_1,\cdots,v_n)$$ is orthonormal basis of $$A^TA$$,
and $$x=a_1v_1 + \cdots + a_rv_r + a_{r+1}v_{r+1} + \cdots + a_nv_n$$,
we have

$$\begin{align*} Ax
& = a_1Av_1 + \cdots + a_rAv_r \\
& = a_1\sigma_1u_1 + \cdots + a_r\sigma_ru_r \\
P_Ub & = \langle b, u_1 \rangle u_1 + \cdots +\langle b, u_r \rangle u_r
\end{align*}$$

Thus,

$$\begin{align*} Ax = P_Ub
& \Rightarrow a_i\sigma_i = u_i^T \\
& \Rightarrow a_i = \frac{u_i^Tb}{\sigma_i}
\end{align*}$$

Thus we have

$$\begin{align*}
x & = \sum_{i=1}^r \frac{u_i^Tb}{\sigma_i}v_i  \\
min\|b-Ax\| &= \|P_{U^\bot} b\|^2 = \sum_{i=r+1}^m(u_i^Tb)^2
\end{align*}$$
