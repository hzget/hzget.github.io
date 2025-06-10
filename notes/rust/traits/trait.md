# Useful Traits

* [From][From] - helps to do value-to-value ***Conversions***
* [Deref][Deref] - allows you to ***Treat Smart Pointers Like Regular References***
* [Drop][Drop] - allows you to custom code within the ***Destructor*** which is useful for [RAII][RAII]

## [From][From]

Used to do value-to-value **conversions** while consuming the input value.

It is especially useful when performing error handling.
The '?' operator automatically converts the underlying error type
with [From::from][From].
Here is a snippet from [minigrep][minigrep]:

```rust
/// takes a configuration and runs the grep functionaly.
pub fn run(config: Config) -> Result<(), Box<dyn Error>> {
    let text = fs::read_to_string(config.file_path)?;

    // --snippet--

    Ok(())
}
```

The `?` operator works for the error type conversion because of the following:

* If `read_to_string` fails, it will return `std::io::Error`.
* `std::io::Error` implements `std::error::Error`
* `Box<dyn std::error::Error>` implement `From`:
  ```rust
  impl<'a, E: Error + 'a> From<E> for Box<dyn Error + 'a> {
      /// Converts a type of [`Error`] into a box of dyn [`Error`].
      fn from(err: E) -> Box<dyn Error + 'a> {
          Box::new(err)
      }
  }
  ```

***Qeustion*** :

> Does the `?` operator automatically call `From::from()`?

***Answer*** :

The `?` operator does not automatically call `From::from()` on its own;
instead, it calls `From::from()` **only when needed to convert between error types**
— specifically **when the error returned by the `?` operator does not
directly match the function's return type, but there exists a
`From` implementation between them**.

A list just for clear explanation:

✅ The `?` operator uses `From::from()` **only when converting between error types**.  
✅ The error type conversion happens at **compile time**,
relying on the `From` trait implementation.  
✅ If there is no `From` implementation between the error type returned
by the expression and the function's error type, the compiler gives an error.

## [Deref][Deref]

* explicit: dereferencing operations with the (unary) `*` operator, like `*v`
* implicit: [deref coercion][deref coercion]

[Deref][Deref] is used for immutable dereferencing operations, like `*v`.
Implementing the [Deref][Deref] trait allows you to
***Treat Smart Pointers Like Regular References*** .

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

* explicit dereferencing operation:

  ```rust
  *m ---> *(m.deref())
  ```

* implicit deref coercion:

  For `hello(&m)`, Rust **compiler** does two steps:
  1. turn `&MyBox<String>` into `&String` by inserting deref
  2. insert deref again to turn the `&String` into `&str`

[From]: https://doc.rust-lang.org/std/convert/trait.From.html
[Deref]: https://doc.rust-lang.org/std/ops/trait.Deref.html
[deref coercion]: https://doc.rust-lang.org/std/ops/trait.Deref.html#deref-coercion
[Drop]: https://doc.rust-lang.org/std/ops/trait.Drop.html
[minigrep]: https://github.com/hzget/rust-apps/blob/main/minigrep
[RAII]: ../../../programming/basic/raii.md
