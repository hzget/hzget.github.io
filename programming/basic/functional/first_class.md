# **First-Class and Higher-Order Functions in Functional Programming**  

In functional programming (and Rust), **functions are treated as values**, meaning they can be assigned to variables, passed as arguments, and returned from other functions. This leads to two important concepts:  

1. **First-Class Functions**  
2. **Higher-Order Functions**  

---

## **1️⃣ First-Class Functions**

A language has **first-class functions** if functions can:  

✅ Be assigned to variables  
✅ Be stored in data structures  
✅ Be passed as arguments to other functions  
✅ Be returned as results from other functions  

### **Example: Assigning Functions to Variables**
```rust
fn add_one(x: i32) -> i32 {
    x + 1
}

fn main() {
    let f = add_one; // Assigning function to variable
    println!("{}", f(5)); // 6
}
```
✅ `add_one` is treated like a normal value—it can be stored in `f` and called like any function.  

### **Example: Storing Functions in a Struct**
```rust
struct FunctionHolder {
    func: fn(i32) -> i32, // Function type
}

fn multiply_by_two(x: i32) -> i32 {
    x * 2
}

fn main() {
    let holder = FunctionHolder { func: multiply_by_two };
    println!("{}", (holder.func)(3)); // 6
}
```
✅ Here, the function `multiply_by_two` is stored inside a struct—this is only possible because **functions are first-class citizens** in Rust.

---

## **2️⃣ Higher-Order Functions (HOFs)**

A **higher-order function (HOF)** is a function that:

✅ **Takes another function as an argument**  
✅ **Returns a function as a result**  

### **Example: Passing a Function as an Argument**
```rust
fn apply_function<F>(func: F, x: i32) -> i32
where
    F: Fn(i32) -> i32,
{
    func(x)
}

fn square(n: i32) -> i32 {
    n * n
}

fn main() {
    let result = apply_function(square, 4);
    println!("{}", result); // 16
}
```
✅ `apply_function` takes a function `F` and applies it to `x`.

---

### **Example: Returning a Function**
```rust
fn create_multiplier(multiplier: i32) -> impl Fn(i32) -> i32 {
    move |x| x * multiplier
}

fn main() {
    let double = create_multiplier(2); // Returns a function
    println!("{}", double(5)); // 10
}
```
✅ `create_multiplier` **returns a function** that multiplies a number by `multiplier`.

---

## **3️⃣ First-Class vs. Higher-Order Functions**
| Feature | First-Class Functions | Higher-Order Functions |
|---------|-----------------|-------------------|
| **Definition** | Functions can be stored, passed, and returned like variables. | Functions that take or return other functions. |
| **Example** | Assigning `let f = my_function;` | `map()`, `filter()`, `fold()` |
| **Usage** | Store functions in structs, variables, or data structures. | Used for function composition and transformations. |

---

## **4️⃣ Why Are These Important?**
1. **Reusability** – HOFs let us write reusable, generic functions.
2. **Code Simplification** – Eliminates boilerplate loops (`map()`, `filter()`, `fold()`).
3. **Expressiveness** – Enables powerful abstractions in functional programming.

---

## **Final Answer:**
- **First-class functions** mean functions are treated like values.  
- **Higher-order functions** are functions that take or return other functions.  

🚀 Want more examples of HOFs in Rust, like `.map()` and `.fold()`?
