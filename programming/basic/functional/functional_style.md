
# Refactor **imperative-style** into a **functional-style**

Let's take a simple **imperative-style** Rust program and refactor it into a **functional-style** version.  

---

### **Example: Summing Even Numbers in a List**
#### **🚨 Imperative Style (Mutable State & Loops)**
```rust
fn main() {
    let numbers = vec![1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    let mut sum = 0;

    for num in numbers {
        if num % 2 == 0 {
            sum += num;
        }
    }

    println!("Sum of even numbers: {}", sum);
}
```
### **Issues with this approach:**
❌ Uses **mutable state** (`sum`).  
❌ Uses a **for loop**, which is explicit and imperative.  
❌ Not easily composable for other transformations.  

---

### **✅ Functional Style (Using Iterators & Higher-Order Functions)**
```rust
fn main() {
    let numbers = vec![1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    let sum: i32 = numbers
        .iter()                 // Create an iterator
        .filter(|&x| x % 2 == 0) // Keep only even numbers
        .sum();                 // Sum them up

    println!("Sum of even numbers: {}", sum);
}
```
### **Why is this more functional?**
✅ **No mutation** – `sum` is never changed; `.sum()` creates a new value.  
✅ **No explicit loops** – `.filter()` processes elements implicitly.  
✅ **Higher-order functions** – `.filter()` and `.sum()` make the code **more declarative**.  
✅ **More composable** – We can easily add `.map()` or `.fold()` without rewriting the logic.  

---

### **🚀 Bonus: Even More Functional (Composing Transformations)**
Let's say we also want to **square the even numbers** before summing them.  
```rust
fn main() {
    let numbers = vec![1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    let sum_of_squares: i32 = numbers
        .iter()
        .filter(|&x| x % 2 == 0) // Keep evens
        .map(|x| x * x)          // Square them
        .sum();                  // Sum them up

    println!("Sum of squares of even numbers: {}", sum_of_squares);
}
```
✅ **Purely functional transformation pipeline** – each step is clear and composable.  

---

### **Key Takeaways**
1. **Use Iterators (`.iter()`)** instead of loops.  
2. **Use Higher-Order Functions** like `.map()`, `.filter()`, `.fold()`, and `.sum()`.  
3. **Avoid Mutable State** whenever possible.  

