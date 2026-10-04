
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Chapter 2 Finite-Dimensional Vector Spaces

## Exercises 2A

**1** Find a list of four distinct vectors in $$\mathbf{F}^3$$
whose span equals $$V$$:

$$ \{(x, y, z) \in \mathbf{F}^3 : x + y + z = 0\}. $$

***Answer*** :
$$ v_1=(1, -1, 0), v_2=(1, 0, -1), v_3=(2, -1, -1), v_4=(0, 1, -1)  $$

***Proof*** :

Apparently, all these four vectors obeys the rule $$x+y+z=0$$,
thus we have $$span(v_1,v_2,v_3,v_4) \subseteq V$$.

Suppose $$v \in V$$, we have

$$
\begin{aligned}
v &= (x, y, z) \\
  &= (x, y, -x-y) \\
  &= x(1, 0, -1) + y (0, 1, -1) \in span(v_1, v_2, v_3, v_4)
\end{aligned}
$$

Thus we have $$V \subseteq span(v_1,v_2,v_3,v_4)$$.

Take them together, we have $$span(v_1,v_2,v_3,v_4) = V$$.


**2** Prove or give a counterexample: If $$v_1,v_2,v_3,v_4$$ spans $$V$$ ,then the list

$$v_1 - v_2, v_2 - v_3, v_3 - v_4, v_4$$

also spans $$V$$.

***Answer*** :

Since $$v_1,v_2,v_3,v_4$$ spans $$V$$, 
thus the vectors $$v_1 - v_2, v_2 - v_3, v_3 - v_4, v_4$$ are included in $$V$$.

For any $$ v \in V $$, there exists
$$a_1, a_2, a_3, a_4 \in \mathbf{F}$$ such that
$$v = a_1v_1 + a_2v_2 + a_3v_3 + a_4v_4$$

Take some operations, we have:

$$
\begin{aligned}
v &= a_1v_1 + a_2v_2 + a_3v_3 + a_4v_4 \\
  &= a_1v_1 - a_1v_2 + a_1v_2+ a_2v_2 + a_3v_3 + a_4v_4 \\
  &= a_1(v_1 - v_2) + (a_1 + a_2)v_2 + a_3v_3 + a_4v_4 \\
  &= a_1(v_1 - v_2) + (a_1 + a_2)v_2 -(a_1 + a_2)v_3 +(a_1 + a_2)v_3 + a_3v_3 + a_4v_4 \\
  &= a_1(v_1 - v_2) + (a_1 + a_2)(v_2 -v_3) +(a_1 + a_2 + a_3)v_3 + a_4v_4 \\
  &= a_1(v_1-v_2) + (a_1+a_2)(v_2-v_3) +(a_1+a_2+a_3)v_3 - (a_1+a_2+a_3)v_4 + (a_1+a_2+a_3)v_4 + a_4v_4 \\
  &= a_1(v_1-v_2) + (a_1+a_2)(v_2-v_3) +(a_1+a_2+a_3)(v_3-v_4) + (a_1+a_2+a_3+a_4)v_4
\end{aligned}
$$

Thus $$v_1 - v_2, v_2 - v_3, v_3 - v_4, v_4$$ spans $$V$$.

**3** Suppose $$v_1, \ldots, v_m$$ is a list of vectors in $$V$$.
For $$ k \in \{1, \ldots, m\}$$, let

$$w_k = v_1 + \cdots + v_k$$

show that $$span(v_1, \ldots, v_m)=span(w_1, \ldots, w_m)$$ .

***Proof*** :

Since $$w_k = v_1 + \cdots + v_k$$ , we get $$v_k = w_k - w_{k-1}$$.

Any $$v \in span(v_1, \ldots, v_m) $$ is a linear combination of 
$$v_1, \ldots, v_m$$ . Replace each $$v_k$$ by $$w's$$, we have that $$v$$
is a linear combination of $$w_1, \ldots, w_m$$ . 
In other words, $$span(v_1, \ldots, v_m) \subseteq span(w_1, \ldots, w_m)$$ .

Interchange the role of $$v's$$ and $$w's$$, we get
$$span(v_1, \ldots, v_m) \supseteq span(w_1, \ldots, w_m)$$ .

Thus we have $$span(v_1, \ldots, v_m)=span(w_1, \ldots, w_m)$$ .

**4** 
- (a) Show that a list of length one in a vector space is linearly independent
if and only if the vector in the list is not 0.  
- (b) Show that a list of length two in a vector space is linearly independent
if and only if neither of the two vectors in the list is a scalar multiple of
the other.
