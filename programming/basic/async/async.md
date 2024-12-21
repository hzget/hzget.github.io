Asynchronous programming
===

**Asynchronous programming**
is a programming paradigm that allows a program to perform other tasks
while waiting for long-running operations to complete,
without blocking the execution of the entire program.
It is particularly useful in situations where tasks involve waiting for
external resources, such as file I/O, network requests, or user input.

Useful links:

* [Concurrency Model: Preemptive or Cooperative](./concurrency_model.md)
* [Cooperative Scheduler in C](./scheduler_in_c.md)
* [Preemptive Runtime in Golang](./async_golang.md)
* [Golang vs Rust for Async](./async_golang_vs_rust.md)
* [Async Tasks vs Threads](./threads_vs_async_tasks.md)
* [Avoid indefinite blocking tasks for Cooperative Concurrency model](./avoid_indefinite_blocking_tasks.md)
* [Manually Implementing Future Trait](./manually_implementing_future_trait.md)

Relevant Concepts

* [Parallelism and Concurrency](https://rust-book.cs.brown.edu/ch17-00-async-await.html#parallelism-and-concurrency)

---

### **Key Concepts of Asynchronous Programming**

1. **Non-Blocking Execution**:
   - In a synchronous program, if a task takes time (e.g., reading from a file or querying a database), the program halts until that task finishes.
   - In asynchronous programming, long-running tasks are initiated and allowed to complete in the background, freeing the program to execute other tasks in the meantime.

2. **Concurrency**:
   - Asynchronous programming enables a program to manage multiple tasks concurrently without requiring multiple threads or processes. It relies on an event loop or task scheduler to decide when to execute tasks.

3. **Futures and Promises**:
   - A **future** (or promise in some languages) represents a value that may become available at a later time. It's a placeholder for the result of an asynchronous operation.
   - In many asynchronous programming models, a function returns a future immediately, even if the actual result isn't ready.

4. **Event Loop**:
   - The event loop is a core mechanism in many asynchronous systems. It continuously checks for tasks that are ready to execute and handles their completion.
   - The event loop schedules the execution of tasks, ensuring progress in the program.

5. **Callback Mechanism**:
   - When an asynchronous operation completes, a **callback function** is invoked to process the result. This is common in older asynchronous systems.
   - Modern asynchronous programming often uses constructs like `await` or `.then()` to handle results more cleanly.

6. **Async/Await Syntax**:
   - Many languages (including Rust, Python, and JavaScript) use `async` and `await` keywords to simplify asynchronous programming, making it resemble synchronous code while maintaining non-blocking behavior.

Under the hood
---

Suppose there is only one thread to run several tasks concurrently.
There should be a scheduler/runtime to give some cpu time to each task.
Specificaly, it can pause one task and
switch to others before eventually cycling back to that first task again.

There're two kinds of concurrency models for such **pause-and-resume** mechanisms:  
[preemptive or cooperative](./concurrency_model.md)

### **How Asynchronous Programming Works**
#### Example 1: Synchronous Code
```python
def fetch_data():
    data = slow_network_call()
    print(data)

fetch_data()
```
- The program stops and waits for `slow_network_call` to finish before proceeding.

#### Example 2: Asynchronous Code
```python
async def fetch_data():
    data = await slow_network_call()
    print(data)

# This call doesn't block the program
asyncio.run(fetch_data())
```
- The `await` keyword pauses the function, allowing other tasks to run while `slow_network_call` completes.

---

### **Advantages of Asynchronous Programming**
1. **Efficiency**:
   - By not blocking on slow operations, the program can handle multiple tasks simultaneously.
   - For example, a web server can process thousands of connections using asynchronous I/O instead of dedicating one thread per connection.

2. **Scalability**:
   - Asynchronous systems use fewer resources (e.g., threads or memory) than synchronous systems, making them suitable for high-load scenarios.

3. **Improved Responsiveness**:
   - Applications like GUIs or web servers remain responsive to user inputs or other events while waiting for background operations to complete.

---

### **Challenges of Asynchronous Programming**
1. **Complexity**:
   - Asynchronous code can be harder to reason about compared to synchronous code, especially when dealing with callbacks or nested futures.

2. **Debugging**:
   - Tracing errors or understanding the program's flow can be challenging in asynchronous systems because of the non-linear execution order.

3. **Deadlocks and Race Conditions**:
   - When multiple asynchronous tasks depend on shared resources or each other's completion, bugs like deadlocks and race conditions can occur if not carefully managed.

---

### **Applications of Asynchronous Programming**
1. **Web Servers**:
   - Handle thousands of concurrent requests efficiently (e.g., Node.js, Rust's `tokio`).
2. **Networking**:
   - Perform non-blocking network I/O for chat apps, APIs, or streaming services.
3. **File I/O**:
   - Access files without freezing the main program.
4. **User Interfaces**:
   - Keep GUIs responsive while performing background tasks.

---

### **Summary**
Asynchronous programming enables programs to manage tasks concurrently and efficiently, avoiding bottlenecks caused by waiting for slow operations. With constructs like `async/await`, developers can write asynchronous code that is readable and maintainable, unlocking the potential for highly responsive and scalable applications.
