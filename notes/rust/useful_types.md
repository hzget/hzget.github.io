Useful types
===

* [`Box<T>`][Box] - A pointer type that uniquely owns a heap allocation of type T.

Box&lt;T&gt;
---

Rust provides a construct called [`Box<T>`][Box] for putting data on the heap.
For example, we can wrap the million-element array in Box::new like this:

```rust
fn main() {
    let a = Box::new([0; 1_000_000]);
    let b = a;
}
```

Boxes provide ownership for this allocation, and drop their contents
when they go out of scope. Boxes also ensure that they never allocate
more than isize::MAX bytes.

Related tops:

* raw pointers: `Box::<T>::from_raw` and `Box::<T>::into_raw`
* `T: Sized` is crucial for ABI-compatible with C pointers
* smart pointers
* memory layout

Examples that using raw pointers:  

1. enqueue() and dequeue() methods of [Queue][Queue]

[Box]: https://doc.rust-lang.org/std/boxed/index.html
[Queue]: https://github.com/hzget/rust-apps/blob/main/list/queue.md
