Manually Implementing Future Trait
===

Here's an example of implementing the `Future` trait for a custom data type in Rust. By manually implementing `Future`, you gain fine-grained control over how and when a task yields control and completes.

---

### **Custom Future Example**

We will create a custom type, `MyFuture`, that resolves after a specified delay. It demonstrates implementing the `Future` trait by polling and returning a `Poll` state.

---

#### **Code Example**

```rust
use std::{
    future::Future,
    pin::Pin,
    task::{Context, Poll},
    time::{Duration, Instant},
};
use tokio::time::sleep;

/// A custom Future that resolves after a certain duration.
struct MyFuture {
    start: Instant,
    delay: Duration,
}

impl MyFuture {
    fn new(delay: Duration) -> Self {
        Self {
            start: Instant::now(),
            delay,
        }
    }
}

/// Implement the Future trait for MyFuture
impl Future for MyFuture {
    type Output = String; // The type returned when the Future completes

    fn poll(self: Pin<&mut Self>, _cx: &mut Context<'_>) -> Poll<Self::Output> {
        // Check if enough time has passed since we started
        if self.start.elapsed() >= self.delay {
            // Return Poll::Ready when the delay has passed
            Poll::Ready("Future complete!".to_string())
        } else {
            // Not ready yet, yield control back to the runtime
            Poll::Pending
        }
    }
}

#[tokio::main]
async fn main() {
    println!("Custom future starting...");

    let my_future = MyFuture::new(Duration::from_secs(2));

    // Await the custom future
    let result = my_future.await;

    println!("{}", result);
}
```

---

### **Explanation**

1. **Custom Type**:  
   - `MyFuture` holds a `start` time and a `delay` duration. It will resolve after the specified delay.

2. **Implementing `Future`**:  
   - The `Future` trait requires implementing the `poll` method.  
   - `poll` is called repeatedly by the executor until the future is ready (returns `Poll::Ready`).

   - Inside `poll`, we:
     - Check the elapsed time since the `start`.
     - Return `Poll::Ready` when enough time has passed.
     - Return `Poll::Pending` otherwise, yielding control to the executor.

3. **Using Pin**:  
   - The `poll` method takes `self: Pin<&mut Self>` to ensure the future is pinned in memory (a requirement for async programming).

4. **Running the Future**:  
   - `tokio::main` provides the async runtime.
   - We create an instance of `MyFuture` and await it.

---

### **Output**

When you run the program, the output will look like this:

```
Custom future starting...
Future complete!
```

The program waits for 2 seconds before printing "Future complete!" because `MyFuture` resolves after the specified delay.

---

### **Key Takeaways**
- Implementing the `Future` trait allows full control over asynchronous behavior.
- The `poll` method is repeatedly called by the executor to check the state of the future.
- You can use `Poll::Ready` when the future completes and `Poll::Pending` to yield control back to the executor.
