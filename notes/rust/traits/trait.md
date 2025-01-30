Useful Traits
===

* [From][From] - Used to do value-to-value conversions
* [Deref][Deref] - Used for immutable dereferencing operations, like `*v`

[Deref][Deref]
---

Implementing the [Deref][Deref] trait allows you to
***Treating Smart Pointers Like Regular References*** .
In other words, you can write code that operates on references
and use that code with smart pointers too.

It has the concept of [deref coercion][deref coercion].
Deref coercion is a convenience Rust performs on
arguments to functions and methods, and works only on
types that implement the Deref trait.

It happens ***automatically*** when we pass a reference
to a particular type's value as an argument to a function or method
that doesn't match the parameter type in the function or method definition.
A sequence of calls to the deref method converts the type
we provided into the type the parameter needs. For example,

```rust
use std::ops::Deref;

impl<T> Deref for MyBox<T> {
    type Target = T;

    fn deref(&self) -> &T {
        &self.0
    }
}

struct MyBox<T>(T);

impl<T> MyBox<T> {
    fn new(x: T) -> MyBox<T> {
        MyBox(x)
    }
}

fn hello(name: &str) {
    println!("Hello, {name}!");
}

fn main() {
    let m = MyBox::new(String::from("Rust"));
    hello(&m); // --> deref coercion
    println!("{}", *m); // --> take `m` as regular reference
}
```

For `hello(&me)`, Rust **compiler** does two steps:

1. turn `&MyBox<String>` into `&String` by calling deref
2. calls deref again to turn the `&String` into `&str`

[From]: https://doc.rust-lang.org/std/convert/trait.From.html
[Deref]: https://doc.rust-lang.org/std/ops/trait.Deref.html
[deref coercion]: https://doc.rust-lang.org/std/ops/trait.Deref.html#deref-coercion
