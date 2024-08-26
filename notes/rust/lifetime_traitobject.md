Lifetime for Trait Object
===

> If your trait objects ***DO NOT contain references***,
you generally don't need to worry about specifying lifetimes explicitly.

> If your trait objects ***DO contain references***, you'll need to
ensure that the lifetimes are correctly specified, using the appropriate
lifetime annotations in the function signature.

***Lifetime elision rules*** in Rust are designed to handle simple cases
where lifetimes can be ***unambiguously*** inferred.
However, returning a `Box<dyn Trait>` is a more complex scenario that
involves dynamic dispatch and potentially multiple lifetimes.

In such cases, the elision rules don't apply because the compiler
needs explicit information to ensure memory safety and lifetime correctness.
This is why you need to explicitly specify lifetimes
when dealing with trait objects in function returns.

1. Trait Object Lifetimes Are ***Ambiguous***

    * Trait objects (dyn Trait) involve dynamic dispatch, which adds complexity in terms of lifetimes. The compiler cannot always infer which lifetime to apply, especially when multiple lifetimes might be involved in the references contained within the type implementing the trait.
    * The relationship between the input lifetimes and the trait object's lifetime may not be straightforward or may depend on how the trait is implemented.

2. Boxed Trait Objects Need an Explicit Lifetime:

    * Unlike a reference, a Box<dyn Trait> is an owned value that can encapsulate a type with references that have their own lifetimes. When converting a concrete type to a trait object, the compiler must know how long the trait object (and any references inside it) should live.
    * Because of this, when returning a Box<dyn Trait>, the function must specify a lifetime explicitly. The compiler needs to understand how long the trait object needs to be valid in relation to the input lifetimes, and this often cannot be determined from the context alone.

Examples
---

```rust
trait Trait {}
impl Trait for &str {}

fn echo<T>(v: T) -> T {
    v
}

fn echo_box<T>(v: T) -> Box<T> {
    Box::new(v)
}

// trait object needs an explicit lifetime bound
fn echo_traitobject<'a, T>(v: T) -> Box<dyn Trait + 'a>
where
    T: Trait + 'a,
{
    Box::new(v)
}

// An explicit `'_` lifetime bound
// declares that the trait object captures data from argument `v`
//
// This "anonymous" lifetime reduces the need to
// clutter the code with explicit lifetime annotations
fn echo_traitobject_strinput(v: &str) -> Box<dyn Trait + '_> {
    Box::new(v)
}
```

Anonymous Lifetime
---

The `'_` lifetime in Rust is a special, shorthand lifetime notation
known as an "***anonymous lifetime***". It's used in situations where
the Rust compiler **CAN** automatically infer the appropriate lifetime,
making the code more concise.

The `'_` lifetime can be used in function signatures to **specify** that
a reference's lifetime **SHOULD BE** inferred by the compiler without
explicitly naming it.
This is particularly useful in simple cases where the lifetime can be
easily inferred, reducing the need to clutter the code with explicit
lifetime annotations.

