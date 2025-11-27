`Box<dyn Error>`
===

`Box<dyn Error>` is one of the most common idioms in Rust for returning **any kind of error** without specifying its concrete type.

Examples:  
[minigrep](https://github.com/hzget/rust-apps/blob/main/minigrep/src/lib.rs)
run() return a Result containing such an Error type.

Here's what it means, broken down clearly:

---

# ✅ 1. `dyn Error`: a **trait object**

`Error` is a trait from the standard library:

```rust
use std::error::Error;
```

When you write:

```rust
dyn Error
```

you are saying:

> “Some type that implements the `Error` trait, but I don't know which type at compile time.”

This is called a **trait object**.

The compiler uses **dynamic dispatch (vtable)** to call methods on it at runtime.

---

# ✅ 2. `Box<dyn Error>`: a smart pointer to a trait object

You cannot store a `dyn Error` directly because it has **no known size** — it's unsized.

So you put it in a pointer type that *can* handle unsized values — such as `Box`.

Thus:

```rust
Box<dyn Error>
```

means:

> “A heap-allocated instance of some error type, stored behind a pointer, where the exact type is only known at runtime.”

It allows you to write flexible return types like:

```rust
fn foo() -> Result<(), Box<dyn Error>> {
    // ...
}
```

Now `foo()` can return **any error**:

* `std::io::Error`
* `std::num::ParseIntError`
* your own custom error type
* etc.

---

# ✅ 3. Why use `Box<dyn Error>`?

### **A. To return different error types in a single function**

Example:

```rust
fn run() -> Result<(), Box<dyn Error>> {
    let file = std::fs::File::open("foo.txt")?;   // returns io::Error
    let n: i32 = "123".parse()?;                  // returns ParseIntError
    Ok(())
}
```

This works because `?` automatically converts each error into a trait object implementing `Error`.

---

### **B. You want simplicity over performance**

`Box<dyn Error>` has:

* **dynamic dispatch**
* **heap allocation**
* **no static type guarantees**

But it's extremely *convenient*, especially for command-line apps.

---

# ✅ 4. When not to use `Box<dyn Error>`

Avoid it if you want:

### **Strongly typed errors**

You want the compiler to distinguish different error types.

### **Zero-cost error handling**

`enum MyError { … }` is faster and more expressive.

---

# 📝 Summary (short version)

| Syntax           | Meaning                                                      |
| ---------------- | ------------------------------------------------------------ |
| `Error`          | a trait for error types                                      |
| `dyn Error`      | a trait object: any type implementing `Error`                |
| `Box<dyn Error>` | a boxed pointer to an error trait object, stored on the heap |

**Use it when you want to return “any error” easily.**

