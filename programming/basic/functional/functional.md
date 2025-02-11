# Functional Programming (FP)

The term **"functional programming" (FP)** comes from the idea that
**functions** are the **primary building blocks** of computation,
rather than **objects**, **states**, or **imperative** commands.
The name emphasizes the focus on **pure functions**
(i.e., functions without side effects) and the way they are
**composed** to solve problems.  

It is a **paradigm** that emphasizes **immutable data**,
**first-class functions**, and **recursion** over
traditional looping and mutable state. Rust, while primarily
**imperative and systems-focused**, borrows **FP concepts**,
especially in areas like **ownership, iterators, and pattern matching**.

🚀 [Refactor **imperative-style** into a **functional-style**](./functional_style.md)

🚀 [**Why Is `enum` More Functional Than `struct`**](./list.md) 

---

## **1️⃣ Why "Functional"?**
The word **"functional"** refers to:
1. **Mathematical Functions**: FP is inspired by **lambda calculus**, where functions are **mathematical mappings** from inputs to outputs.
2. **Function-First Design**: In FP, computations are built by **composing functions**, rather than modifying state.
3. [**First-Class Functions**](./first_class.md): Functions can be **passed as arguments**, **returned from other functions**, and **assigned to variables**.

### **(1) Inspired by Mathematics: Pure Functions**
- A **pure function** always gives the same output for the same input and has **no side effects**.
- Example in Rust:
  
  ```rust
  fn square(x: i32) -> i32 {
      x * x  // No side effects!
  }

  fn main() {
      println!("{}", square(4)); // Always 16
  }
  ```
  ✅ **"Functional" programming relies on these kinds of functions.**  
  ❌ In contrast, **imperative** code modifies variables:
  ```rust
  fn square_and_log(mut x: i32) -> i32 {
      x *= x;
      println!("Computed: {}", x); // Side effect: printing
      x
  }
  ```
  - This **depends on an external effect** (`println!()`), making it **less functional**.

---

### **(2) Function Composition Instead of State Changes**
- Instead of **mutating variables**, FP **chains functions** together.
- Example: **Imperative (mutating)**
  ```rust
  fn main() {
      let mut numbers = vec![1, 2, 3, 4, 5];
      for i in 0..numbers.len() {
          numbers[i] *= 2;
      }
      println!("{:?}", numbers); // [2, 4, 6, 8, 10]
  }
  ```
  - The `for` loop **mutates** `numbers`, making it **state-dependent**.

- Example: **Functional (transforming)**
  ```rust
  fn main() {
      let numbers = vec![1, 2, 3, 4, 5];
      let doubled: Vec<_> = numbers.iter().map(|x| x * 2).collect();
      println!("{:?}", doubled); // [2, 4, 6, 8, 10]
  }
  ```
  ✅ Instead of changing `numbers`, we **return a new transformed list**, following **function composition**.

---

### **(3) First-Class and Higher-Order Functions**
FP allows functions to be **treated as values**, meaning they can:
1. Be **assigned to variables**.
2. Be **passed as arguments**.
3. Be **returned from other functions**.

Example:
```rust
fn apply_twice<F>(func: F, x: i32) -> i32
where F: Fn(i32) -> i32 {
    func(func(x))
}

fn double(n: i32) -> i32 {
    n * 2
}

fn main() {
    let result = apply_twice(double, 3);
    println!("{}", result); // 12
}
```
✅ `apply_twice` takes a function `func` and applies it **twice**. This is a core **functional programming** idea.

---

## **2️⃣ How Is FP Different from Imperative Programming?**

| Feature | Functional Programming | Imperative Programming |
|---------|------------------------|------------------------|
| **State** | Avoids mutation | Modifies variables |
| **Flow Control** | Function composition | Loops (`for`, `while`) |
| **Side Effects** | Avoids side effects | Allows side effects |
| **Data Handling** | Uses recursion & transformations | Uses explicit iteration |
| **Functions** | First-class, higher-order | Often secondary to objects |

---

## **3️⃣ Why Is Rust Not Fully Functional?**
Rust **borrows** many FP ideas (like `map`, `filter`, `iterators`, `closures`) but is **not purely functional** because:
- It allows **mutable state** (`let mut`).
- It **does not enforce immutability** (like Haskell or Elm).
- It focuses on **performance & memory safety**, which sometimes requires imperative techniques.

However, Rust **lets you use FP** **when it makes sense**, while still being a **systems programming language**.

---

### **Summary** :

Functional programming is called **"functional"** because:
1. It treats **functions as the core building blocks**.
2. It is inspired by **mathematical functions**.
3. It **avoids mutable state and imperative constructs**.
4. It emphasizes **function composition and transformations**.

