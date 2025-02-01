syntax sugar
===

* ***for-loop*** syntax - is actually syntax sugar for [iterators][iterators]
* ***impl Trait*** syntax - is actually syntax sugar for a [trait bound][trait bound]

***impl Trait*** syntax
---

The ***impl Trait*** syntax works for straightforward cases
but is actually syntax sugar for a longer form known as a [trait bound][trait bound].

```rust
// the following are the same

// case 1: syntax sugar
pub fn notify(item: &impl Summary) {
    println!("Breaking news! {}", item.summarize());
}

// case 2: trait bound
pub fn notify<T: Summary>(item: &T) {
    println!("Breaking news! {}", item.summarize());
}
```

[iterators]: https://doc.rust-lang.org/std/iter/index.html#for-loops-and-intoiterator
[trait bound]: https://rust-book.cs.brown.edu/ch10-02-traits.html#trait-bound-syntax
