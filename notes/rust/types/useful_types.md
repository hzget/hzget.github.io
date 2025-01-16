Useful types
===

* [Box&lt;T&gt;][Box] - A pointer type that uniquely owns a heap allocation of type T.
* [Vec&lt;T&gt;][Vec] - A contiguous growable array type with heap-allocated contents.
* [slice][slices] - A reference to a sub-range of a sequence, like a string or a vector.
* [String][String] and [str][str]

Box&lt;T&gt;
---

Rust provides a construct called [Box&lt;T&gt;][Box] for putting data on the heap.
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

Slices
---

Slices are a special kind of reference that refer to
sub-ranges of a sequence, like a string or a vector.
At runtime, a slice is represented as a "fat pointe"
which contains a pointer to the beginning of the range
and a length of the range.

Here is what a string slice looks like: [string slice][string slice structure].

Examples:

```rust
fn main() {
    // slice of a string - string slice
    let s = String::from("hello world");
    let slice: &str = &s[0..5];

    assert_eq!(slice, "hello");

    // slice of an array
    let mut a = [1, 2, 3, 4, 5];
    let slice = &mut a[1..3];

    slice[0] = 9;
    assert_eq!(slice, &[9, 3]);
}
```

String and str
---

(For the memory layout, please refer to [string slice][string slice structure]).

The [String][String] type is a growable, mutable, owned, UTF-8 encoded
string type. It is provided by Rust's standard library rather tha
coded into the core language.

The ***string slice*** [str][str], usually seen in its borrowed form &str,
is a reference to some UTF-8 encoded string data stored elsewhere.
It's the only one string type in the core language.

* Both String and string slices are [UTF-8 encoded][Unicode]
* String type does not support [direct indexing][string no indexing]
* String type does support [iterating through][string iterating through]

[Box]: https://doc.rust-lang.org/std/boxed/index.html
[Queue]: https://github.com/hzget/rust-apps/blob/main/list/queue.md
[Vec]: https://doc.rust-lang.org/std/vec/index.html
[string slice structure]: https://rust-book.cs.brown.edu/ch04-04-slices.html#string-slices
[slices]: https://rust-book.cs.brown.edu/ch04-04-slices.html
[String]: https://doc.rust-lang.org/std/string/struct.String.html
[str]: https://doc.rust-lang.org/std/primitive.str.html
[Unicode]: https://hzget.github.io/programming/basic/unicode.html
[string no indexing]: ./string_no_indexing.md
[string iterating through]: ./string_iterating_through.md
