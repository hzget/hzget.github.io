Useful Enums
===

***prelude*** types:

* [Result&lt;T, E&gt;][Result] - It represents either success (Ok) or failure (Err).
* [Option&lt;T&gt;][Option] - It encodes the concept of a value being present or absent.

## Result&lt;T, E&gt;

[Result&lt;T, E&gt;][Result]
is the type used for returning and propagating errors.
It is an enum with the variants, Ok(T), representing success and containing a value,
and Err(E), representing error and containing an error value.

```rust
enum Result<T, E> {
   Ok(T),
   Err(E),
}
```

Example:

```rust
use std::fs::File;

fn main() {
    let greeting_file_result = File::open("hello.txt");

    let greeting_file = match greeting_file_result {
        Ok(file) => file,
        Err(error) => panic!("Problem opening the file: {error:?}"),
    };
}
```

* commonly used methods: `unwrap()`, `expect()`, `unwrap_or_else()`
* the `?` operator can be used as a shortcut to propagate errors

## Option&lt;T&gt;

Type [Option&lt;T&gt;][Option] encodes the concept of a value being present or absent.

```rust
enum Option<T> {
    None,
    Some(T),
}
```

***null-reference problems***

`Option<T>` and `T` are different types.
You have to convert an `Option<T>` to a `T` before you can perform T
operations with it. Otherwise, the compiler will give an error.

In other words, it helps to eliminate the null-reference problems
(e.g., assuming that something isn't null when it actually is)
that exist in other languages which have a `null` value.
For example,

```java
// java code
String s = Name(); // It sometimes return a `null` value by mistake
// This will throw a NullPointerException if s is null
System.out.println(s.length());
```

[Result]: https://doc.rust-lang.org/std/result/index.html
[Option]: https://doc.rust-lang.org/std/option/index.html

