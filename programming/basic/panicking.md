# Panicking

**Panicking** refers to an **unexpected, unrecoverable runtime error** that causes a program to terminate or enter an error-handling state. It typically occurs due to issues like:  
- **Null pointer dereferences** (accessing `NULL` in C, `None` in Rust)  
- **Out-of-bounds array access** (reading beyond valid memory)  
- **Divide by zero**  
- **Explicit program termination (`panic!()` in Rust, `panic()` in Go)**  

Each language handles panicking differently, affecting **safety, performance, and recoverability**. Let's compare **Go, Rust, and C**.

[Panic Handling Best Practices (Rust, Go, and C)][practices]

---

## **Comparison of Panicking in Go, Rust, and C**  

| Feature             | C (Low-Level) | Go (GC & Concurrency) | Rust (Memory-Safe & Performance) |
|--------------------|--------------|---------------------|--------------------------------|
| **Default Behavior** | **Crash** (undefined behavior) | **Stops execution unless recovered** | **Unwinds stack or aborts** |
| **Error Handling Mechanism** | **Return codes, `errno`** | **`panic()` + `recover()`** | **`panic!()` + `catch_unwind()`** |
| **Stack Unwinding** | ❌ No | ❌ No (but `defer` allows cleanup) | ✅ Yes (by default) |
| **Memory Safety** | ❌ Manual (unsafe) | ✅ Garbage Collector (safe) | ✅ RAII + Ownership (safe) |
| **Can Catch Panic in Main Thread?** | ❌ No | ✅ Yes (`recover()`) | ❌ No (`catch_unwind` only in separate threads) |
| **Panic Handling in Threads** | ❌ No built-in | ✅ Goroutines recover independently | ✅ `catch_unwind()` in threads |
| **Performance Impact** | ⚡ Fastest (no safety checks) | 🐢 Slightly slower (GC overhead) | ⚡ Fast but safety-checked |

---

## **1. Panicking in C: No Built-in Handling (Undefined Behavior)**
C does not have **built-in panic handling**—errors result in **undefined behavior (UB)** or program crashes.

### **Example: Null Pointer Dereference in C**
```c
#include <stdio.h>

int main() {
    int *ptr = NULL;
    *ptr = 42;  // ❌ Segmentation fault (crash)
    return 0;
}
```
- The program **immediately crashes** due to a segmentation fault.  
- There is **no built-in recovery** unless using `setjmp/longjmp`.

### **Workarounds for Error Handling in C**
- **Return error codes (`-1`, `NULL`)**
- **Use `setjmp/longjmp` for limited panic recovery**
- **Signal handlers (`sigaction`) for certain errors (e.g., `SIGSEGV`)**  

However, none of these mechanisms provide **automatic cleanup** like Go or Rust.

---

## **2. Panicking in Go: `panic()` and `recover()`**

Go **supports explicit panics** via `panic()`. However, unlike Rust, **it does not unwind the stack**—it simply stops execution unless `recover()` is used.

### **Example: Panic in Go**

```go
package main

import "fmt"

func main() {
    fmt.Println("Before panic")
    panic("Something went wrong!") // ❌ Triggers a panic
    fmt.Println("After panic")      // ❌ Unreachable
}
```
Output:
```
Before panic
panic: Something went wrong!

goroutine 1 [running]:
main.main()
    /path/to/main.go:6 +0x40
exit status 2
```
✅ The panic **prints a stack trace** but does **not clean up resources automatically**.  

### **Recovering from a Panic in Go**
Go allows **recovering from a panic** using `recover()`, but only inside `defer` functions.

```go
package main

import "fmt"

func main() {
    defer func() {
        if r := recover(); r != nil {
            fmt.Println("Recovered from panic:", r)
        }
    }()

    fmt.Println("Before panic")
    panic("Something went wrong!") // ❌ Triggers a panic
    fmt.Println("After panic")      // ❌ Unreachable
}
```
✅ The program **recovers from the panic** and continues execution.

### **Panicking in Goroutines**
Go **isolates panics within goroutines**, meaning a panic in one goroutine **does not crash the entire program** unless it's the main goroutine.

```go
package main

import (
    "fmt"
    "time"
)

func worker() {
    defer func() {
        if r := recover(); r != nil {
            fmt.Println("Recovered in worker:", r)
        }
    }()
    panic("Worker panicked!")
}

func main() {
    go worker()
    time.Sleep(time.Second)
    fmt.Println("Main function still running")
}
```
✅ The program **continues running even if a goroutine panics**.

---

## **3. Panicking in Rust: `panic!()` with Stack Unwinding or Abort**
Rust’s `panic!()`:
- **Unwinds the stack by default** (drops variables safely).
- **Can be configured to abort immediately** (`panic = 'abort'` in Cargo.toml).
- **Cannot be recovered in the same thread**, but **`catch_unwind()` allows handling in separate threads**.

### **Example: Panic in Rust**
```rust
fn main() {
    println!("Before panic");
    panic!("Something went wrong!"); // ❌ Triggers a panic
    println!("After panic"); // ❌ Unreachable
}
```
Output:
```
thread 'main' panicked at 'Something went wrong!', src/main.rs:3:5
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```
✅ **Rust unwinds the stack**, ensuring resources (files, memory, etc.) are cleaned up.

### **Preventing Stack Unwinding (`abort` Mode)**
If stack unwinding is **too slow**, Rust can **abort immediately**.

**Cargo.toml:**
```toml
[profile.release]
panic = 'abort'
```

This speeds up panics **but skips cleanup**.

---

### **Recovering Panics in Rust (Only Across Threads)**
Rust **does not allow recovering from a panic in the same thread**, but panics can be caught in separate threads using `catch_unwind()`.

```rust
use std::panic;

fn main() {
    let result = panic::catch_unwind(|| {
        panic!("Something went wrong!");
    });

    if result.is_err() {
        println!("Recovered from panic!");
    }
}
```
✅ The panic is caught, and the program continues execution.

---

## **4. Summary: Panicking Across Languages**

| Feature          | C                  | Go                | Rust               |
|-----------------|--------------------|------------------|-------------------|
| **Panic Handling** | ❌ None (undefined behavior) | ✅ `panic()` + `recover()` | ✅ `panic!()` + `catch_unwind()` |
| **Stack Unwinding** | ❌ No | ❌ No | ✅ Yes (default) |
| **Can Recover in Main Thread?** | ❌ No | ✅ Yes (`recover()`) | ❌ No (`catch_unwind` only in threads) |
| **Memory Safety** | ❌ Manual | ✅ GC | ✅ Ownership & RAII |
| **Performance Impact** | ⚡ Fastest | 🐢 GC overhead | ⚡ Safe + Fast |

---

### **Final Thoughts**
- **C** is the **least safe** (undefined behavior, crashes without recovery).  
- **Go** is **moderately safe** (panics can be recovered but don’t unwind the stack).  
- **Rust** is the **safest** (panics unwind properly, enforcing memory safety).  

Would you like a **deeper dive into panic handling best practices**, or a **performance comparison between stack unwinding vs abort mode**? 🚀

[practices]: ./panicking_practices.md
