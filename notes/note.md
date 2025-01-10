Reading notes
=============

[Operating System](./os/README.md)
----------------

Rust
---

|topics|articles|
|------|--------|
|concept|[lifetimes][lifetime], [trait object vs trait bound][trait], [trait object][trait_object], [function pointer vs closure][closure]|
|commonly used| [enum][useful enum]s, |

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
[lifetime]: ./rust/lifetime.md
[trait]: ./rust/trait.md
[trait_object]: ./rust/trait_object.md
[closure]: ./rust/closure.md
[useful enum]: ./rust/useful_enum.md
