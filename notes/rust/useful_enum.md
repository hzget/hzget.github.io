Useful Enum
===

* [Result<T, E>][Result]

Result<T, E>
---

[Result<T, E>][Result]
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

[Result]: https://doc.rust-lang.org/std/result/index.html

