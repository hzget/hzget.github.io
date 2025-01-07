Function Pointers VS Closures
===

In Rust, both function pointers and closures can be used to
represent callable entities, but they differ in their
behavior, usage, and how they capture their environment.

Function Pointers
---

A function pointer is a pointer to a regular function (a fn item).
Function pointers do not capture any environment; they are simply
references to functions that are defined elsewhere.

Key Characteristics of Function Pointers:

* No Environment Capture: Function pointers cannot capture or reference
any variables from the scope where they are created.
* Fixed Signature: A function pointer has a fixed signature defined
at compile time. For example, `fn(i32) -> i32` is a function pointer type
that refers to functions taking an i32 and returning an i32.
* Simple Usage: Function pointers are typically used when you need a
simple callable that doesn't depend on any external state.

Example:

```rust
fn add_one(x: i32) -> i32 {
    x + 1
}

fn main() {
    let f: fn(i32) -> i32 = add_one; // Function pointer
    println!("{}", f(5)); // Output: 6
}
```

Closures
---

A closure is a callable entity that can capture variables from
its surrounding environment. Closures are more flexible than
function pointers because they can access and manipulate
variables outside their own scope.

Key Characteristics of Closures:

* Environment Capture: Closures can capture variables from the
surrounding environment, either by borrowing, mutating, or
taking ownership of them.
* Flexible Signature: Closures can infer their types based on usage,
and they don't need an explicit type annotation.
* Three Traits: Closures can implement one or more of the Fn, FnMut,
and FnOnce traits, depending on how they capture the environment:
    * FnOnce: Takes ownership of captured variables.
    * FnMut: Borrows captured variables mutably.
    * Fn: Borrows captured variables immutably.

Example:

```rust
fn main() {
    let x = 10;
    let add_x = |y: i32| x + y; // Closure that captures `x`
    println!("{}", add_x(5)); // Output: 15
}
```

Differences Between Function Pointers and Closures
---

Environment Capture:

* Function Pointers: Do not capture any environment.
* Closures: Can capture the environment, allowing them to access variables from their scope.

Flexibility:

* Function Pointers: Have a fixed signature and cannot adjust to different contexts or environments.
* Closures: Are more flexible, can infer types, and adapt based on what they capture and how they're used.

Usage Context:

* Function Pointers: Suitable for simple, stateless function calls, like passing around predefined functions.
* Closures: Ideal for scenarios where you need to perform operations that depend on external state.

Performance:

* Function Pointers: Generally more efficient when there's no need to capture environment variables, as they involve direct function calls.
* Closures: May involve additional overhead due to capturing and managing environment variables, but they provide greater flexibility.

Practical Example:

```rust

fn main() {
    println!("{}", closure_to_fn()());
    println!("{}", fn_to_closure()());
    println!("{}", fn_to_closure_in_box()());
    println!("{}", closure_to_closure()());
    println!("{}", closure_in_box_to_closure_in_box()());
}

fn closure_to_fn() -> fn() -> i32 {
    || 1
}

fn foo() -> i32 {
    2
}

fn fn_to_closure() -> impl Fn() -> i32 {
    foo
}

fn fn_to_closure_in_box() -> Box<dyn Fn() -> i32> {
    Box::new(foo)
}

fn closure_to_closure() -> impl Fn() -> i32 {
    let a = 2;
    move || a
}

fn closure_in_box_to_closure_in_box() -> Box<dyn Fn() -> i32> {
    let a = 2;
    Box::new(move || a)
}

//
// the following will get compiling error
//
//  = note: expected fn pointer `fn() -> i32`
//                found closure `{closure@src/main.rs:43:5: 43:7}`
//    note: closures can only be coerced to `fn` types if they do not capture any variables
fn closure_to_fn_fail() -> fn() -> i32 {
    let a = 1;
    || a
}

// error[E0746]: return type cannot have an unboxed trait object
//               doesn't have a size known at compile-time
fn closure_to_closure_in_dyn() -> dyn Fn() -> i32 {
    let a = 2;
    move || a
}

// error[E0746]: return type cannot have an unboxed trait object
//               doesn't have a size known at compile-time
fn fn_to_closure_in_dyn_fail() -> dyn Fn() -> i32 {
    foo
}

// compiling errors
/*
D:\proj\example.com\rust\hello>cargo build
   Compiling hello v0.1.0 (D:\proj\example.com\rust\hello)
error[E0308]: mismatched types
  --> src/main.rs:43:5
   |
41 | fn closure_to_fn_fail() -> fn() -> i32 {
   |                            ----------- expected `fn() -> i32` because of return type
42 |     let a = 1;
43 |     || a
   |     ^^^^ expected fn pointer, found closure
   |
   = note: expected fn pointer `fn() -> i32`
                 found closure `{closure@src/main.rs:43:5: 43:7}`
note: closures can only be coerced to `fn` types if they do not capture any variables
  --> src/main.rs:43:8
   |
43 |     || a
   |        ^ `a` captured here

error[E0746]: return type cannot have an unboxed trait object
  --> src/main.rs:48:35
   |
48 | fn closure_to_closure_in_dyn() -> dyn Fn() -> i32 {
   |                                   ^^^^^^^^^^^^^^^ doesn't have a size known at compile-time
   |
help: return an `impl Trait` instead of a `dyn Trait`, if all returned values are the same type
   |
48 | fn closure_to_closure_in_dyn() -> impl Fn() -> i32 {
   |                                   ~~~~
help: box the return type, and wrap all of the returned values in `Box::new`
   |
48 ~ fn closure_to_closure_in_dyn() -> Box<dyn Fn() -> i32> {
49 |     let a = 2;
50 ~     Box::new(move || a)
   |

error[E0746]: return type cannot have an unboxed trait object
  --> src/main.rs:55:35
   |
55 | fn fn_to_closure_in_dyn_fail() -> dyn Fn() -> i32 {
   |                                   ^^^^^^^^^^^^^^^ doesn't have a size known at compile-time
   |
help: return an `impl Trait` instead of a `dyn Trait`, if all returned values are the same type
   |
55 | fn fn_to_closure_in_dyn_fail() -> impl Fn() -> i32 {
   |                                   ~~~~
help: box the return type, and wrap all of the returned values in `Box::new`
   |
55 ~ fn fn_to_closure_in_dyn_fail() -> Box<dyn Fn() -> i32> {
56 ~     Box::new(foo)
   |

Some errors have detailed explanations: E0308, E0746.
For more information about an error, try `rustc --explain E0308`.
error: could not compile `hello` (bin "hello") due to 3 previous errors
*/

```
