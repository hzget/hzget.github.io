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
    let z = get_fn_get_one();
    println!("z() = {}", z()); // output: z() = 1

    let z = get_fn_get_two();
    println!("z() = {}", z()); // output: z() = 2

    let z = get_fn_get_one_v2();
    println!("z() = {}", z()); // output: z() = 1
}

fn get_fn_get_one() -> fn() -> i32 {
    || 1
}

fn get_fn_get_two() -> Box<dyn Fn() -> i32> {
    let a = 2;
    Box::new(move || a)
}

fn get_fn_get_one_v2() -> Box<dyn Fn() -> i32> {
    Box::new(get_fn_get_one())
}

//
// the following will get compiling error
//

// case 3: mismatched types
//   = note: expected fn pointer `fn() -> i32`
//                 found closure `{closure@src/main.rs:34:5: 34:7}`
fn get_fn_get_three() -> fn() -> i32 {
    let b = 3;
    || b
}

// case 4: mismatched types
//   = note:  expected struct `Box<(dyn Fn() -> i32 + 'static)>`
//           found fn pointer `fn() -> i32`
fn get_fn_get_one_v3() -> Box<dyn Fn() -> i32> {
    get_fn_get_one()
}

// case 5:
//   error[E0746]: return type cannot have an unboxed trait object
//                 which doesn't have a size known at compile-time
fn get_fn_get_five() -> Fn() -> i32 {
    let a = 5;
    || a
}

// compiling errors:
/*
$ cargo build
   Compiling hello v0.1.0 (D:\proj\example.com\rust\hello)
error[E0308]: mismatched types
  --> src/main.rs:34:5
   |
32 | fn get_fn_get_three() -> fn() -> i32 {
   |                          ----------- expected `fn() -> i32` because of return type
33 |     let b = 3;
34 |     || b
   |     ^^^^ expected fn pointer, found closure
   |
   = note: expected fn pointer `fn() -> i32`
                 found closure `{closure@src/main.rs:34:5: 34:7}`
note: closures can only be coerced to `fn` types if they do not capture any variables
  --> src/main.rs:34:8
   |
34 |     || b
   |        ^ `b` captured here

error[E0308]: mismatched types
  --> src/main.rs:41:5
   |
40 | fn get_fn_get_one_v3() -> Box<dyn Fn() -> i32> {
   |                           -------------------- expected `Box<(dyn Fn() -> i32 + 'static)>` because of return type
41 |     get_fn_get_one()
   |     ^^^^^^^^^^^^^^^^ expected `Box<dyn Fn() -> i32>`, found fn pointer
   |
   = note:  expected struct `Box<(dyn Fn() -> i32 + 'static)>`
           found fn pointer `fn() -> i32`
   = note: for more on the distinction between the stack and the heap, read https://doc.rust-lang.org/book/ch15-01-box.html, https://doc.rust-lang.org/rust-by-example/std/box.html, and https://doc.rust-lang.org/std/boxed/index.html
help: store this in the heap by calling `Box::new`
   |
41 |     Box::new(get_fn_get_one())
   |     +++++++++                +

error[E0746]: return type cannot have an unboxed trait object
  --> src/main.rs:47:25
   |
47 | fn get_fn_get_five() -> Fn() -> i32 {
   |                         ^^^^^^^^^^^ doesn't have a size known at compile-time
   |
help: box the return type, and wrap all of the returned values in `Box::new`
   |
47 | fn get_fn_get_five() -> Fn() -> i32 {
   |                         ^^^^^^^^^^^
   |
help: use `impl Fn() -> i32` to return an opaque type, as long as you return a single underlying type
   |
47 | fn get_fn_get_five() -> impl Fn() -> i32 {
   |                         ++++
help: alternatively, you can return an owned trait object
   |
47 | fn get_fn_get_five() -> Box<dyn Fn() -> i32> {
   |                         +++++++            +

Some errors have detailed explanations: E0308, E0746, E0782.
For more information about an error, try `rustc --explain E0308`.
error: could not compile `hello` (bin "hello") due to 4 previous errors
*/
```
