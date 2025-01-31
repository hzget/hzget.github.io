Safety Guarantees
===

**A foundational goal of Rust is to ensure that your programs
never have [undefined behavior][undefined behavior].**
That is the meaning of "safety":
***Safety is the Absence of Undefined Behavior.***
Examples:

1. to access invalid memory (e.g., when it's been deallocated)
2. to deallocate a memory that already has been "freed"

For such "safety", Rust comes with the following concepts:

* Ownership, Boxes, and Move
* Reference and Borrowing
* Permissions (R, W, O and F), and Lifetimes
* borrow checker

Cases of Compiling Errors
---

Learning how to fix an ownership error is a core Rust skill.
When the borrow checker rejects your code, how should you respond?

click -&gt; [Cases for fixing these errors][ownership errors]

Ownership
---

**Ownership** enables Rust to make memory safety guarantees without
needing a garbage collector.

```rust
let a = Box::new([0; 1_000_000]);
let b = a;
```

When a is bound to `Box::new([0; 1_000_000])`, we say that a ***owns*** the box.
The statement `let b = a` ***moves*** ownership of the box from a to b.
Given these concepts, Rust's policy for freeing boxes is more accurately described as:

> ***Box deallocation principle*** :
> If a variable owns a box, when Rust deallocates the variable's frame
> then Rust deallocates the box's heap memory.

> ***Moved heap data principle*** : if a variable x moves ownership of
> heap data to another variable y, then x cannot be used after the move.

Reference and Borrowing
---

**[References][Reference and Borrowing]** provide the ability to read and write data without
consuming ownership of it. References are created with borrows (& and &mut)
and used with dereferences (\*), often implicitly.
To avoid undefined behavior, Rust's policy for pointers:

> ***Pointer Safety Principle*** : data should never be aliased and mutated at the same time.

References can be easily misused. Rust's [borrow checker][borrow checker]
enforces a system of ***Permissions*** that ensures references are used safely:

* All variables can read, own, and (optionally) write their data.
* Creating a reference will transfer permissions from the borrowed place to the reference.
* Permissions are returned once the reference's lifetime has ended.
* Data must outlive all references that point to it.

As a part of the ***Pointer Safety Principle***, the borrow checker enforces that
**data must outlive any references to it**. Rust enforces this property in two ways.

***case 1*** : Rust knows how long a reference lives - references within a function body

```rust
fn main() {
    let s = String::from("Hello world");
    let s_ref = &s;
    drop(s);
    println!("{}", s_ref);
}
```

Rust knows how long `s_ref` lives.
The Borrow Checker Finds Permission Violations

***case 2*** : Rust doesn't know how long a reference lives - input/output references

Rust provides a mechanism called [lifetime](./lifetime.md) parameters
for such case.

In fact, ***case 1*** also has lifetimes which are **inferred** by Rust compiler.
And in ***case 2***, we need to annotate lifetimes manually to help with
the compiler.

[undefined behavior]: https://doc.rust-lang.org/reference/behavior-considered-undefined.html
[Reference and Borrowing]: https://rust-book.cs.brown.edu/ch04-02-references-and-borrowing.html
[borrow checker]: https://rust-book.cs.brown.edu/ch04-02-references-and-borrowing.html#the-borrow-checker-finds-permission-violations
[ownership errors]: https://rust-book.cs.brown.edu/ch04-03-fixing-ownership-errors.html
