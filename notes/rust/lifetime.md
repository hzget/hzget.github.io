Lifetimes
===

The concept of ***lifetimes*** is central to Rust's
ownership and borrowing system, which ensures memory safety
without the need for a garbage collector.

Every reference in Rust has a ***lifetime***, which is the
***scope*** for which that reference is valid.
The Rust compiler's borrow checker will compare scopes to determine
whether all borrows are valid.

Key Concepts of Lifetimes
---

* References and Borrowing:

    * A reference in Rust is a way of borrowing data, allowing you to
    refer to a value without taking ownership of it. References are denoted
    by `&T` (immutable reference) or `&mut T` (mutable reference).
    * Since Rust guarantees memory safety, it needs to ensure that references
    never outlive the data they point to. Lifetimes help enforce this rule.

* Lifetime Annotations:

    * Lifetime annotations are a way to explicitly specify how long
    references are valid in your code. They appear in the form of
    `&'a T` where `'a` is the lifetime.
    * Lifetime annotations do not change the lifetime of references;
    they simply describe the relationships between lifetimes.

* Ownership and Lifetimes:

    * When a reference is created, Rust must ensure that the data
    it points to lives long enough to be valid for the entire duration
    of the reference's use.
    * Lifetimes are particularly important when dealing with functions,
    structs, and any situation where references are passed around and returned.

* Lifetime Inference:

    * Most of the time, lifetimes are implicit and inferred.
    Rust's lifetime elision rules cover the most common cases.
    * They don’t provide full inference.
    If Rust deterministically applies the rules but there is still
    ambiguity as to what lifetimes the references have,
    the compiler will give you an error that you can resolve by
    adding the lifetime annotations.

* Safety

    * Every reference will have a lifetime (scope) implicitly added by
    the compiler or explicitly added by the user.
    * The Rust compiler's borrow checker will compare scopes to
    determine whether all borrows are valid.

Example: Scopes
---

```rust
// case 1
fn main() {
    let r;                // ---------+-- 'a
                          //          |
    {                     //          |
        let x = 5;        // -+-- 'b  |
        r = &x;           //  |       |
    }                     // -+       |
                          //          |
    println!("r: {}", r); //          |
}                         // ---------+

// case 2
fn main() {
    let x = 5;            // ----------+-- 'b
                          //           |
    let r = &x;           // --+-- 'a  |
                          //   |       |
    println!("r: {}", r); //   |       |
                          // --+       |
}                         // ----------+
```

Example: Lifetime Errors
---

Rust's compiler enforces lifetime rules to prevent errors such as dangling references. If a reference outlives the data it points to, Rust will produce a compile-time error, avoiding issues that could lead to undefined behavior.

```rust
fn dangling_reference() -> &String {
    let s = String::from("hello");
    &s  // Error: `s` does not live long enough
}
```

Example: How borrower checker works with lifetime
---

Consider a function that returns a reference to the larger
of two integer slices:

```rust
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```

* `'a`: This is a lifetime parameter. It indicates that the references
x, y, and the returned reference all have the same lifetime `'a`.
* ***Purpose***: This means that the returned reference will be valid for
as long as both x and y are valid. If either of the input references
goes out of scope before the returned reference,
Rust will produce a compile-time error.
* ***concrete reference***: When we pass concrete references to
longest, the concrete lifetime that is substituted for `'a` is
the part of the scope of x that overlaps with the scope of y.
the returned reference will also be valid for the length of the
smaller of the lifetimes of x and y.
The compiler borrow checker will check if it is valid.

The following examples show distinct scenario. One will pass
the check and the other will not pass it.
It shows that lifetimes help to prevent dangling references.
With lifetimes, the borrow checker ensures data outlives its references.

```rust
// Example: pass the valid check
fn main() {
    let string1 = String::from("long string is long");

    {
        let string2 = String::from("xyz");
        let result = longest(string1.as_str(), string2.as_str());
        println!("The longest string is {}", result);
    }
}

// Example: fail
fn main() {
    let string1 = String::from("long string is long");
    let result;
    {
        let string2 = String::from("xyz");
        result = longest(string1.as_str(), string2.as_str()); // <-- voilate lifetime contract
    } // <--- if it does not fail, here will introduce dangling references
    println!("The longest string is {}", result);
}
// result:
$ cargo run
   Compiling chapter10 v0.1.0 (file:///projects/chapter10)
error[E0597]: `string2` does not live long enough
 --> src/main.rs:6:44
  |
6 |         result = longest(string1.as_str(), string2.as_str());
  |                                            ^^^^^^^^^^^^^^^^ borrowed value does not live long enough
7 |     }
  |     - `string2` dropped here while still borrowed
8 |     println!("The longest string is {}", result);
  |                                          ------ borrow later used here

For more information about this error, try `rustc --explain E0597`.
error: could not compile `chapter10` due to previous error

```

Summary
---

Lifetimes are a way of telling the Rust compiler how long references should be valid.
Annotations: While Rust can often infer lifetimes, sometimes you need to annotate them explicitly, particularly in more complex scenarios.
Enforcement: Lifetimes are enforced at compile time to ensure that references do not outlive the data they refer to, preventing dangling references and ensuring memory safety.
'static Lifetime: A special lifetime indicating that the reference is valid for the entire duration of the program.

