<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

# Decomposition

Decomposition is a way of investigating properties of an object.
We can look deeply into the key point.

## linear combination

A vector can be taken as a linear combination of a basis of
its vector space. Thus we can make use of theorem on a basis.
We can get the value of a linear map on this vector:

$$ v = a_1 v_1 + \cdots + a_n v_n \rightarrow T(v) = a_1 T(v_1) + \cdots + a_n T(v_n)$$

## direct sum and orthogonal complement

A vector space can have a direct decompositon: $$V = U \oplus U^{\bot}$$,
all vectors in U are orthogonal to every vector in $$U^{\bot}$$.
And a vector v from the vector sapce V can have a orthogonal decomposition:

$$ v = P_{U}(v) + (v - P_{U}(v))$$

(The operator $$P_{U}$$ is the orthogonal projection of V onto U.)

The mininization problem often arises: given a subspace U of V
and a point v from V , find a point u from U such that
$$\|v - u\|$$ is as small as possible. We can solve this by
an orthogonal projection(from $$\|v - P_{U}(v)\| \leq \|v - u\|$$):

$$ u = P_{U}v = \langle v , e_1 \rangle e_1 + \cdots +
                \langle v , e_m \rangle e_m $$

As we can see, the decompositon help a lot for our problem.
