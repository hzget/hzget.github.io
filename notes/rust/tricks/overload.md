# Overloading

Rust does not support traditional operator/function overloading like C++
but provides **overloading-like behavior** through **traits** and **type coercion**.
Below is a detailed breakdown of all types of "overloading" in Rust.

---

## **🔹 1. Operator Overloading**

In Rust, operator overloading is primarily enabled through traits
in the [`std::ops`](https://doc.rust-lang.org/std/ops/index.html) module,
and comparability is handled via [`std::cmp`](https://doc.rust-lang.org/std/cmp/index.html),
i.e., the so-called **overloadable operators** and **comparable/orderable utilities**.

### **Examples**

| Operator | Trait | Example Implementation |
|---|---|---|
| `+`         | `std::ops::Add`            | `impl Add for MyType {}` |
| `-`         | `std::ops::Sub`            | `impl Sub for MyType {}` |
| `*`         | `std::ops::Mul`            | `impl Mul for MyType {}` |
| `/`         | `std::ops::Div`            | `impl Div for MyType {}` |
| `%`         | `std::ops::Rem`            | `impl Rem for MyType {}` |
| `==` / `!=` | `std::cmp::PartialEq`      | `impl PartialEq for MyType {}` |
| `<` / `>`   | `std::cmp::PartialOrd`     | `impl PartialOrd for MyType {}` |
| `&`         | `std::ops::BitAnd`         | `impl BitAnd for MyType {}` |
| `|`         | `std::ops::BitOr`          | `impl BitOr for MyType {}` |
| `^`         | `std::ops::BitXor`         | `impl BitXor for MyType {}` |
| `<<` / `>>` | `std::ops::Shl` / `Shr`    | `impl Shl for MyType {}` |
| `!`         | `std::ops::Not`            | `impl Not for MyType {}` |
| `+=` / `-=` | `std::ops::AddAssign` etc. | `impl AddAssign for MyType {}` |

### **Example: Overloading `+` Operator**

```rust
use std::ops::Add;

#[derive(Debug, Copy, Clone)]
struct Point {
    x: i32,
    y: i32,
}

impl Add for Point {
    type Output = Point;

    fn add(self, other: Point) -> Point {
        Point { x: self.x + other.x, y: self.y + other.y }
    }
}

fn main() {
    let p1 = Point { x: 1, y: 2 };
    let p2 = Point { x: 3, y: 4 };
    let p3 = p1 + p2;
    println!("{:?}", p3); // Output: Point { x: 4, y: 6 }
}
```

---

## **🔹 2. Method Overloading via Traits (Associated Types and Generics)**
Rust allows method overloading via **trait bounds** and **generic implementations**:

### **Example: Method Overloading via Traits**
```rust
struct Container<T>(T);

trait Show {
    fn show(&self);
}

impl Show for Container<i32> {
    fn show(&self) {
        println!("Integer container: {}", self.0);
    }
}

impl Show for Container<String> {
    fn show(&self) {
        println!("String container: {}", self.0);
    }
}

fn main() {
    Container(10).show(); // Calls the i32 version
    Container("hello".to_string()).show(); // Calls the String version
}
```

---

## **🔹 3. Generic Function Overloading**
Rust supports **generic overloading using type parameters and traits**.

### **Example: Generic Overloading with Traits**
```rust
fn double<T: std::ops::Mul<Output = T> + Copy>(x: T) -> T {
    x * x
}

fn main() {
    println!("{}", double(4));   // Works for integers
    println!("{}", double(4.2)); // Works for floats
}
```
### **Why This Is "Overloading"**
- The function **accepts multiple types** that implement `Mul`.

---

## **🔹 4. Deref Coercion (Implicit Overloading of `*` and `.`)**
   Rust allows overloading of the dereference (`*`) operator and method resolution via `Deref`:

### **Example: `Deref` Overloading**
```rust
use std::ops::Deref;

struct Wrapper<T>(T);

impl<T> Deref for Wrapper<T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

fn main() {
    let wrapped = Wrapper(String::from("Hello"));
    println!("{}", wrapped.len()); // Works like a normal String
}
```
### **Why This Is "Overloading"**
- `Wrapper<String>` acts like a `String` because of `Deref`.

---

## **🔹 5. Implicit Type Coercion (`From` and `Into`)**

Rust provides implicit type coercion via `From` and `Into`.

### **Example: `From` and `Into` Overloading**
```rust
struct Kilometers(f64);

impl From<f64> for Kilometers {
    fn from(miles: f64) -> Self {
        Kilometers(miles * 1.60934)
    }
}

fn main() {
    let km: Kilometers = 10.0.into();
    println!("10 miles = {:.2} km", km.0);
}
```
### **Why This Is "Overloading"**
- `Into` and `From` allow conversions between types **without explicitly calling conversion methods**.

---

## **🔹 6. Custom Formatting (`std::fmt::Display` and `std::fmt::Debug`)**
Overloading how a type is formatted in `println!` is done via `std::fmt::Display` and `std::fmt::Debug`:

```rust
use std::fmt;

struct Point {
    x: i32,
    y: i32,
}

impl fmt::Display for Point {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "({}, {})", self.x, self.y)
    }
}

fn main() {
    let p = Point { x: 1, y: 2 };
    println!("{}", p); // Custom formatting
}
```

---

## **🔹 Summary Table**

| **Overloading Type**    | **Rust Mechanism** |
|-------------------------|------------------|
| **Operator Overloading** | Implementing `std::ops::*` traits |
| **Comparable & Orderable** | Implementing `std::cmp::{PartialEq, Eq, PartialOrd, Ord}` |
| **Method Overloading** | Using generics or associated types |
| **Generic Function Overloading** | Generics & Trait Bounds |
| **Implicit Overloading of `*` and `.`** | Implementing `Deref` and `DerefMut` |
| **Implicit Type Coercion** | Implementing `From` & `Into` |
| **Custom Formatting Overloading** | Implementing `std::fmt::Display` and `std::fmt::Debug` |

---

### **🚀 Conclusion**
Rust **does not support classical overloading**, but it achieves similar results through **traits, generics, and type conversions**.

