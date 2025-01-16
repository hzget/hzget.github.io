string slice vs string literal
===

In Rust, a **string literal** and a **string slice** are closely related but not exactly the same. Here's the distinction:

### **String Literal (`&str`)**
- A string literal is a hardcoded string in your program.
- It has the type `&'static str`. 
  - The `'static` lifetime means the string literal is stored in the program's binary and is valid for the entire duration of the program.
- Example: 
  ```rust
  let s: &'static str = "hello, world!";
  ```
- String literals are immutable and can be treated as string slices.

### **String Slice (`&str`)**
- A string slice is a view into a string. It represents a borrowed reference to a portion of a string (or the entire string).
- It can borrow from:
  - A string literal (`"hello"` is `&'static str`).
  - A `String` (heap-allocated, growable string type).
- Example of slicing a `String`:
  ```rust
  let s = String::from("hello, world!");
  let slice: &str = &s[0..5]; // This is a string slice.
  ```

### Key Differences

| Aspect  | String Literal (`&'static str`) | String Slice (`&str`) |
|:---|:---|:---|
| **Storage**  | Stored in the program's binary (static). | Can borrow from literals or heap.|
| **Lifetime** | Always `'static`.          | Inherits the lifetime of the borrowed string. |
| **Mutability** | Immutable by definition. | Immutable because it's a borrowed reference. |
| **Size**     | Fixed at compile time.     | Depends on what it borrows from.  |

### Example
```rust
let literal: &'static str = "hello"; // A string literal
let s = String::from("world");
let slice: &str = &s; // A string slice borrowing from a `String`

println!("{literal}, {slice}");
```

In summary, a string literal is a specific type of string slice with a `'static` lifetime and is hardcoded into the program, while a string slice can be a reference to any part of a string, regardless of whether it's a literal or a heap-allocated `String`.
