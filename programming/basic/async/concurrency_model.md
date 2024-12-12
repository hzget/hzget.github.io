Concurrency Model
===

Rust does not natively support **preemptive asynchronous programming** in the same way Go does. Here's a breakdown of how Rust and Go differ in their asynchronous programming models:

### **Go's Preemptive Concurrency**
- Go uses **goroutines**, which are lightweight threads managed by the Go runtime.
- The runtime includes a **scheduler** that preempts goroutines automatically if they are running for too long. This means that even if a goroutine performs a blocking operation, the Go runtime can preempt it and allow other goroutines to run.
- Developers don't need to worry about manually yielding execution; the runtime handles it seamlessly.

### **Rust's Cooperative Concurrency**
- Rust's asynchronous model is built around **async/await** and **futures**, which are lazy and only make progress when polled.
- Rust's `async` tasks are executed by an **executor**, but the system relies on **cooperative scheduling**. This means that:
  - The task must explicitly yield control (e.g., through `.await`).
  - If a task doesn't yield (e.g., if it's running a blocking or computationally intensive operation), it can monopolize the executor and block other tasks.
- Unlike Go, Rust does not have a runtime that can preempt a misbehaving task; the programmer is responsible for ensuring fairness by designing code that yields control appropriately.

### **Comparison**
| Feature                | Go                          | Rust                        |
|------------------------|-----------------------------|-----------------------------|
| Concurrency Model      | Preemptive                  | Cooperative                 |
| Lightweight Threads    | Goroutines (managed by runtime) | `async` tasks (managed by executor) |
| Scheduler              | Preemptive runtime scheduler | Cooperative executors       |
| Blocking Operations    | Automatically handled       | Must avoid or offload to a thread pool |
| Control Yielding       | Automatic                   | Manual (`.await`)           |

### **Achieving Preemption in Rust**
To emulate some form of preemption in Rust, you can:
1. **Use timeouts or checks**: Periodically check for cancellation or progress in long-running tasks.
2. **Spawn threads**: Use OS threads (via `std::thread`) for preemptive behavior, but this sacrifices the lightweight nature of async tasks.
3. **Custom Executors**: Some experimental executors might attempt to offer more preemptive-like behavior, but they are rare and not idiomatic.

### **Why Rust Doesn't Have Preemption**
Rust's design emphasizes **zero-cost abstractions** and giving control to the programmer. Adding preemptive scheduling would require:
- A runtime with more overhead.
- Potential loss of some determinism and predictability that Rust's model provides.

In summary, Go's preemptive concurrency is more beginner-friendly and forgiving, while Rust's cooperative model is more explicit and requires careful design to avoid pitfalls.
