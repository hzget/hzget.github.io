# Autodereferencing and autoborrowing

**Autodereferencing** and **autoborrowing** are two important conveniences in Rust's type system and method resolution that make code easier to write and read. Let's break them down carefully:

---

## 🔍 1. **Autodereferencing**

**Definition:**
When you use `.` syntax to call a method (like `v.method()`), Rust automatically inserts dereference operations (`*`) as needed to find the method definition.

**Why?**

To allow types like `Box<T>`, `Rc<T>`, or any type that implements `Deref<Target = T>` to be treated transparently, so you don't have to manually write `(*v).method()`.

---

### Example:

```rust
use std::ops::Deref;

struct MyBox<T>(T);

impl<T> Deref for MyBox<T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl String {
    fn shout(&self) {
        println!("{}!!!", self.to_uppercase());
    }
}

fn main() {
    let my_box = MyBox(String::from("hello"));

    // Here: my_box.shout()
    // Rust:
    // 1. Looks for shout() on MyBox<String> -> not found
    // 2. Autoderef: *my_box -> String
    // 3. Looks for shout() on String -> found

    my_box.shout();
}
```

---

**Behind the scenes:**

```rust
(*my_box).shout();
```

But Rust's **autoderef** spares you the explicit `*` calls.

---

## 🔍 2. **Autoborrowing**

**Definition:**
When calling a method, Rust **automatically borrows** the receiver (`self`), if the method signature expects `&self` or `&mut self`.

---

### Example:

```rust
struct MyStruct;

impl MyStruct {
    fn greet(&self) {
        println!("Hello!");
    }
}

fn main() {
    let s = MyStruct;

    // s.greet() implicitly borrows s as &s
    s.greet();
}
```

**Behind the scenes:**

```rust
(&s).greet();
```

This is known as **autoborrow**.

---

## 🔄 Putting It Together

When you call a method:

```rust
v.method()
```

Rust does the following (in order):

✅ 1. Check if `v` has the method.  
✅ 2. If not, **autoderef** `v` repeatedly (call `Deref::deref`) until it finds a type with the method.  
✅ 3. Once it finds the method, it checks the method's `self` type (`self`, `&self`, or `&mut self`), and **autoborrows** `v` as needed.

---

## Summary Table

| Concept        | Action                                                       | Example                         |
| -------------- | ------------------------------------------------------------ | ------------------------------- |
| **Autoderef**  | Automatically dereferences values using `Deref`              | `v.method()` -> `(*v).method()` |
| **Autoborrow** | Automatically borrows values to match `&self` or `&mut self` | `v.method()` -> `(&v).method()` |

---

## When doesn't it happen?

🚫 Autoderef happens **only** for method calls (dot syntax), not for functions like `some_func(v)` — that's why sometimes you have to manually call `&v` or `*v`.

