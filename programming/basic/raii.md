# **RAII (Resource Acquisition Is Initialization) in Rust**

**RAII (Resource Acquisition Is Initialization)** is a programming paradigm where resources (e.g., memory, file handles, locks, network sockets) are tied to object lifetimes. In Rust, RAII is deeply integrated into the language through ownership and the **`Drop`** trait.

🚀 [**Comparison of RAII in Rust, C++, and Go**](./comparison.md)

---

## **1. RAII Basics**
- When an object is created, it **acquires** resources in its constructor.
- When the object **goes out of scope**, its destructor automatically **releases** the resources.
- Rust does this through **ownership and lifetimes**, ensuring no resource leaks.

Example:
```rust
struct Resource;

impl Drop for Resource {
    fn drop(&mut self) {
        println!("Resource released!");
    }
}

fn main() {
    let _r = Resource;  // Acquired
}  // Dropped automatically here
```
### **Key Takeaways:**
- `_r` acquires a resource when initialized.
- It gets dropped automatically when it goes out of scope.
- The `drop` function ensures cleanup.

---

## **2. `Drop` Trait in Rust**
Rust does not have destructors in the C++ sense, but it provides a **`Drop` trait** that allows defining cleanup logic.

Example with file handling:
```rust
use std::fs::File;
use std::io::Write;

struct TempFile {
    file: File,
}

impl TempFile {
    fn new(name: &str) -> Self {
        let file = File::create(name).expect("Failed to create file");
        TempFile { file }
    }
}

impl Drop for TempFile {
    fn drop(&mut self) {
        println!("Temporary file is being deleted.");
        // File gets closed automatically here
    }
}

fn main() {
    let _temp = TempFile::new("temp.txt");
}  // `_temp` is dropped, and its `drop` function is called.
```
### **What Happens?**
- `TempFile::new` opens a file.
- When `_temp` goes out of scope, `Drop::drop` is called.
- The file is closed automatically.

---

## **3. RAII in Smart Pointers**
Rust provides smart pointers that use RAII for memory management:

### **`Box<T>` (Heap Allocation)**

- Automatically deallocates heap memory.

```rust
struct Data {
    value: i32,
}

fn main() {
    let _b = Box::new(Data { value: 42 });
}  // Memory is freed automatically.
```

### **`Rc<T>` (Reference Counting)**

- Uses RAII to track reference counts.

```rust
use std::rc::Rc;

fn main() {
    let a = Rc::new(42);
    let _b = Rc::clone(&a);  // Reference count increased
}  // When last reference is dropped, memory is freed.
```

### **`Arc<T>` (Thread-Safe Reference Counting)**

- Works like `Rc<T>`, but is safe for multi-threading.

---

## **4. RAII in Mutex and Lock Guards**
Locks in Rust use RAII for thread safety:

```rust
use std::sync::{Mutex, Arc};
use std::thread;

fn main() {
    let data = Arc::new(Mutex::new(0));
    
    let handles: Vec<_> = (0..5).map(|_| {
        let data = Arc::clone(&data);
        thread::spawn(move || {
            let mut num = data.lock().unwrap(); // Lock acquired
            *num += 1;
        }) // Lock released here automatically
    }).collect();

    for h in handles {
        h.join().unwrap();
    }
}
```
### **What Happens?**
- `MutexGuard` (from `.lock()`) locks the data.
- When it goes out of scope, the lock is automatically released.

---

## **5. Benefits of RAII in Rust**
✅ **Automatic cleanup** → No manual resource management.  
✅ **Prevents resource leaks** → Ensures memory, locks, and files are released properly.  
✅ **Safe and predictable** → Resources are freed deterministically when the owner goes out of scope.  
✅ **No need for `finally` blocks** → No risk of forgetting to release resources.

---

## **6. How Rust’s RAII Differs from Other Languages**

| **Feature**| **Rust** | **C++** | **Go** |
|---|---|---|---|
| **Memory Mgmt** | RAII via ownership   | RAII with constructors/destructors | GC |
| **Cleanup**    | `Drop` trait         | Destructors (`~Class()`)  | `defer` |
| **Smart Pointers** | `Box`, `Rc`, `Arc` | `std::shared_ptr` etc. | No built-in equivalents |
| **Concurrency** | `Arc<Mutex<T>>` for safe multi-threading | Similar with `std::mutex` | Channels, `sync.Mutex` |

---

### **Summary**
- Rust **strongly enforces RAII** through **ownership** and **the `Drop` trait**.
- Smart pointers (`Box<T>`, `Rc<T>`, `Arc<T>`) leverage RAII for memory safety.
- Mutexes and file handles automatically clean up when they go out of scope.
- Unlike C++, Rust **forbids** manual deallocation (`free()`, `delete`) and **avoids GC overhead**.

