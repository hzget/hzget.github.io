Trait Bound
===

***keywords : trait bounds, generic types, blanket implementations***

***Trait bounds*** are usually used to give a **Constraint**
to something.

Using Trait Bounds to Constrain Generic types
---

You can combine traits with generic types to **Constrain**
a generic type to accept only those types that have
a particular behavior, as opposed to just any type.

The function `nitify` can only accept generic types
that implement trait `Summary` and `Display`.

```rust
pub fn notify<T: Summary + Display>(item: &T) {
```

Using Trait Bounds to Conditionally Implement Methods
---

`Pair<T>` only implements the `cmp_display` method if
its inner type T implements the `PartialOrd` and `Display`.

```rust
use std::fmt::Display;

struct Pair<T> {
    x: T,
    y: T,
}

impl<T> Pair<T> {
    fn new(x: T, y: T) -> Self {
        Self { x, y }
    }
}

impl<T: Display + PartialOrd> Pair<T> {
    fn cmp_display(&self) {
        if self.x >= self.y {
            println!("The largest member is x = {}", self.x);
        } else {
            println!("The largest member is y = {}", self.y);
        }
    }
}
```

Using Trait Bounds to Conditionally Implement A Trait
---

Implementations of a trait on ***any type*** that satisfies
the ***trait bounds*** are called ***blanket implementations*** .
They are used extensively in the Rust standard library.

For example, because of the following implementation,
[ToString][ToString] trait is automatically implemented
for any type which implements the `Display` trait. 

```rust
impl<T: Display> ToString for T {
    // --snip--
}
```

[ToString]: https://doc.rust-lang.org/std/string/trait.ToString.html
