Reading notes
=============

[Operating System](./os/README.md)
----------------

Rust
---

|topics|articles|
|------|--------|
|concepts|[safety][rust safety], [lifetimes][lifetime], |
|commonly used| [enum][useful enum]s, [type][useful types]s, [syntax sugar][sugar]s, [trait][trait]s |
|usages| [trait bound][trait bound]s, |
|others| [confusion][confusion]s, |

Golang
------

|topics|articles|
|------|--------|
|diagnostics|[profiling](./golang/diagnostics/profile/profile.md)|
|pitfalls|[pitfalls](./golang/pitfalls/pitfall.md), [slice](./golang/pitfalls/slice.md)|
|tech|[embedding](./golang/tech/embedding.md)|
|go pkgs|[flag][flag], [log][log], [slog][slog], [http][http]|
|performance|[escape analysis](./golang/performance/escape.md), [atomic operation][Atomic]|
|others|[database](./golang/database.md), [context](./golang/context.md), [useful interface](./golang/useful_interface.md)|

Container
---------

[concept](./container/concept.md),

Introduction to probability
---------------------------

[random variable](./probability/random_variable.md),
[conditional probability](./probability/conditional_probability.md),

The Practice of Programming
---------------------------

[style](./practice/style.md),
[data structures and algorithms](./practice/algorithm.md),

English Learning
----------------

[abstract](./english/abstract.md),


[Atomic]: https://github.com/hzget/go-investigation/tree/main/performance/atomic

[flag]: ./golang/pkg/flag.md
[log]: ./golang/pkg/log.md
[slog]: ./golang/pkg/slog.md
[http]: ./golang/pkg/http.md
[lifetime]: ./rust/concepts/lifetime.md
[rust safety]: ./rust/concepts/safety.md
[useful enum]: ./rust/useful_enum.md
[useful types]: ./rust/types/useful_types.md
[confusion]: ./rust/confusion/confusion.md
[sugar]: ./rust/sugars/sugars.md
[trait]: ./rust/traits/trait.md
[trait bound]: ./rust/usages/trait_bound.md
