Avoid indefinite blocking tasks for Cooperative Concurrency Model
===

Rust does not natively support **preemptive** asynchronous
programming in the same way Go does.
It uses **cooperative** scheduling instead.

In Rust, when using **async tasks** with an executor (like `tokio` or `async-std`), it's crucial to ensure that one task doesn't block others indefinitely. If a task performs a **blocking operation** or enters an infinite loop without yielding control, it can monopolize the executor and prevent other tasks from running.

Here are the key approaches to avoid blocking all other tasks forever:

---

## **1. Avoid Blocking Operations in Async Code**
Rust's `async` runtime works using a cooperative scheduling model: tasks run until they explicitly yield control back to the executor. If you perform a blocking operation inside an async task, it will prevent other tasks from running.

### Solution: Use `tokio::task::spawn_blocking` for Blocking Work
If you must perform a blocking operation (like a CPU-bound calculation or synchronous I/O), offload it to a dedicated thread pool using `tokio::task::spawn_blocking`.

Example:
```rust
use tokio::task;
use std::thread;
use std::time::Duration;

#[tokio::main]
async fn main() {
    // Async task that runs blocking work on a thread pool
    let handle = task::spawn_blocking(|| {
        thread::sleep(Duration::from_secs(5)); // Blocking operation
        println!("Blocking task completed");
    });

    println!("Other tasks can run while waiting for blocking work");
    handle.await.unwrap();
}
```
- **`spawn_blocking`** ensures that the blocking task runs on a separate thread pool, leaving the async runtime unaffected.

---

## **2. Use Timeouts for Tasks**
To prevent tasks from running indefinitely (e.g., a bug or external operation hangs), use **timeouts** to cap their execution time.

### Using `tokio::time::timeout`
Example:
```rust
use tokio::time::{sleep, timeout, Duration};

#[tokio::main]
async fn main() {
    let task = async {
        sleep(Duration::from_secs(5)).await; // Simulates a long-running task
        println!("Task completed");
    };

    match timeout(Duration::from_secs(3), task).await {
        Ok(_) => println!("Task finished within the timeout"),
        Err(_) => println!("Task timed out!"),
    }
}
```
- The `timeout` function cancels the task if it exceeds the specified duration.

---

## **3. Avoid Infinite Loops Without `await`**
If a task runs an infinite loop without any `await` points, it will never yield control back to the executor, effectively "locking up" the executor.

### Solution: Add `tokio::task::yield_now`
To ensure a loop yields control to the executor periodically, use `tokio::task::yield_now`.

Example:
```rust
use tokio::task::yield_now;

#[tokio::main]
async fn main() {
    tokio::spawn(async {
        loop {
            // Do some work
            println!("Working...");

            // Yield control to other tasks
            yield_now().await;
        }
    });

    // Simulate other work
    tokio::time::sleep(tokio::time::Duration::from_secs(1)).await;
    println!("Main task finished");
}
```
- **`yield_now`** allows other tasks to run by explicitly giving control back to the executor.

---

## **4. Use Proper Executors**
Ensure you're using an executor that can handle task scheduling well. Executors like **`tokio`** are designed to handle millions of concurrent tasks efficiently.

- `tokio::main` can use either a multi-threaded or single-threaded runtime:
    - **Multi-threaded**: Allows tasks to run in parallel (`#[tokio::main(flavor = "multi_thread", worker_threads = 4)]`).
    - **Current thread**: Tasks run cooperatively on a single thread.

**Choose multi-threaded mode** if you have CPU-bound or potentially slow-running tasks.

Example:
```rust
#[tokio::main(flavor = "multi_thread", worker_threads = 4)]
async fn main() {
    tokio::spawn(async {
        loop {
            println!("Task 1 running");
            tokio::time::sleep(Duration::from_millis(200)).await;
        }
    });

    tokio::spawn(async {
        loop {
            println!("Task 2 running");
            tokio::time::sleep(Duration::from_millis(200)).await;
        }
    });

    tokio::time::sleep(Duration::from_secs(2)).await;
}
```

---

## **5. Monitor and Handle Task Panics**
If a task panics, it can terminate silently depending on how the executor is configured. Ensure panics don't propagate or take down the runtime.

- Use `tokio::spawn` and check the `Result` it returns:
```rust
#[tokio::main]
async fn main() {
    let handle = tokio::spawn(async {
        panic!("Something went wrong!");
    });

    if let Err(err) = handle.await {
        println!("Task failed: {:?}", err);
    }
}
```

---

## **Summary**
To prevent tasks from blocking indefinitely in Rust:
1. **Avoid blocking operations** - offload them using `spawn_blocking`.
2. **Use timeouts** with `tokio::time::timeout`.
3. **Yield control** in long-running loops with `tokio::task::yield_now`.
4. Use a **multi-threaded executor** to maximize concurrency.
5. **Monitor for panics** and handle task failures explicitly.

By combining these approaches, you can ensure that no task monopolizes the async executor and your program remains responsive.
