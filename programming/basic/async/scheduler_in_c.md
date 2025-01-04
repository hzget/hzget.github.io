Cooperative Scheduler in C
===

Asynchronous programming in C typically requires the use of lower-level libraries or system calls since the language itself doesn't provide built-in support for asynchronous programming constructs like `async/await`. You can implement asynchronous programming in C using techniques like:

1. **Callbacks** (traditional approach).
2. **POSIX threads** (for concurrency and parallelism).
3. **`select`/`poll`/`epoll`** for asynchronous I/O on sockets.
4. **Libuv** (used by Node.js internally).
5. **Asynchronous state machines** (manual implementation).

To implement truly asynchronous programming in a **single-threaded environment**, you can use a combination of **non-blocking I/O** and an **event loop**. The key idea is to avoid blocking operations entirely and let the event loop handle multiple tasks by reacting to events (e.g., timers, I/O readiness).

In this example, we'll simulate a truly asynchronous task scheduler in a single-threaded environment using **non-blocking I/O** and **timers**. For real-world systems, this approach is similar to how systems like **Node.js** (with libuv) or **Python's asyncio** operate.

It is a Cooperative Scheduler.
Relevant Concepts:

* [Concurrency Model: preemptive and cooperative](./concurrency_model.md)

---

### **Implementation: Asynchronous Programming with Event Loop**

```c
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>
#include <unistd.h>

#define MAX_TASKS 10

// Task states
typedef enum {
    TASK_PENDING,
    TASK_RUNNING,
    TASK_COMPLETED
} TaskState;

// Task function type
typedef void (*TaskFunction)(int task_id, TaskState *state);

// Task structure
typedef struct {
    int task_id;             // Task ID
    TaskFunction func;       // Task function
    TaskState state;         // Current state
    time_t next_execution;   // Time when the task should execute next
    int interval_ms;         // Interval between executions (ms)
} Task;

// Task Scheduler structure
typedef struct {
    Task tasks[MAX_TASKS]; // Array of tasks
    int task_count;        // Number of tasks
} TaskScheduler;

// Add a task to the scheduler
void add_task(TaskScheduler *scheduler, TaskFunction func, int interval_ms, int task_id) {
    if (scheduler->task_count >= MAX_TASKS) {
        printf("Scheduler is full! Cannot add more tasks.\n");
        return;
    }

    Task *task = &scheduler->tasks[scheduler->task_count++];
    task->task_id = task_id;
    task->func = func;
    task->state = TASK_PENDING; // Start as pending
    task->interval_ms = interval_ms;
    task->next_execution = clock() + (interval_ms * CLOCKS_PER_SEC / 1000);

    printf("Task %d added with interval %d ms.\n", task_id, interval_ms);
}

// Run the scheduler
void run_scheduler(TaskScheduler *scheduler) {
    while (1) {
        int active_tasks = 0;

        for (int i = 0; i < scheduler->task_count; i++) {
            Task *task = &scheduler->tasks[i];

            if (task->state == TASK_COMPLETED) {
                continue; // Skip completed tasks
            }

            // Check if the task is ready to execute
            if (clock() >= task->next_execution) {
                task->state = TASK_RUNNING;
                task->func(task->task_id, &task->state); // Run the task function

                if (task->state == TASK_PENDING) {
                    // Schedule the task for its next execution
                    task->next_execution = clock() + (task->interval_ms * CLOCKS_PER_SEC / 1000);
                }
            }

            if (task->state != TASK_COMPLETED) {
                active_tasks++;
            }
        }

        if (active_tasks == 0) {
            break; // Exit the loop if all tasks are completed
        }

        usleep(1000); // Small delay to prevent busy-waiting
    }

    printf("All tasks completed!\n");
}

// Example task functions
void task_function_1(int task_id, TaskState *state) {
    static int counter = 0;

    // do only small chunk of work
    counter++;
    printf("Task %d: Running function 1. Counter: %d\n", task_id, counter);

    // yield control to runtime scheduler
    *state = TASK_PENDING;

    if (counter == 5) {
        printf("Task %d: Completed.\n", task_id);
        *state = TASK_COMPLETED;
    }
}

void task_function_2(int task_id, TaskState *state) {
    static int progress = 0;

    // do only small chunk of work
    progress += 25;
    printf("Task %d: Running function 2. Progress: %d%%\n", task_id, progress);

    // yield control to runtime scheduler
    *state = TASK_PENDING;

    if (progress >= 100) {
        printf("Task %d: Completed.\n", task_id);
        *state = TASK_COMPLETED;
    }
}

// Main function
int main() {
    TaskScheduler scheduler = {0}; // Initialize the scheduler

    // Add tasks to the scheduler
    add_task(&scheduler, task_function_1, 500, 1);  // Task 1: Runs every 500 ms
    add_task(&scheduler, task_function_2, 1000, 2); // Task 2: Runs every 1000 ms

    printf("Starting scheduler...\n");

    // Run the scheduler
    run_scheduler(&scheduler);

    return 0;
}
```

---

### **How This Works**
1. **Non-Blocking Task Execution**:
   - Each task is represented by a function and a timer (`next_execution`). The event loop checks the timer to see if the task is ready to execute.
   - Tasks do not block the main loop, and their execution is interleaved.

2. **Task States**:
   - `TASK_PENDING`: The task is waiting for its next execution.
   - `TASK_RUNNING`: The task is currently being executed.
   - `TASK_COMPLETED`: The task has finished and will not run again.

3. **Timer-Based Scheduling**:
   - Each task has a `next_execution` time (based on the system clock).
   - The event loop executes tasks only when their timers expire.

4. **Event Loop**:
   - The `run_scheduler` function acts as an event loop that continuously checks the state of all tasks and schedules them for execution.

---

### **Example Output**
```
Task 1 added with interval 500 ms.
Task 2 added with interval 1000 ms.
Starting scheduler...
Task 1: Running function 1. Counter: 1
Task 2: Running function 2. Progress: 25%
Task 1: Running function 1. Counter: 2
Task 1: Running function 1. Counter: 3
Task 2: Running function 2. Progress: 50%
Task 1: Running function 1. Counter: 4
Task 1: Running function 1. Counter: 5
Task 1: Completed.
Task 2: Running function 2. Progress: 75%
Task 2: Running function 2. Progress: 100%
Task 2: Completed.
All tasks completed!
```

---

### **Features**

1. **Explicit State Updates**:
   - Each task updates its state (`TASK_PENDING` or `TASK_COMPLETED`) based on its progress, yielding control back to the scheduler after completing a small chunk of work.

2. **Small Chunks of Work**:
   - Tasks only execute a small piece of logic (a "chunk") before yielding control, preventing any single task from monopolizing the CPU. This ensures fairness and allows other tasks to run.

3. **Cooperative Execution**:
   - Tasks "cooperate" with the scheduler by yielding control voluntarily, allowing the scheduler to determine when to execute them again based on the timer (`interval_ms`).

4. **Efficient Scheduling**:
   - The scheduler runs in a non-blocking loop, checking each task's state and scheduling them as needed without creating unnecessary delays or blocking execution.

---

### Key Advantages of the Implementation
- **True Cooperative Async**:
  - The tasks explicitly yield control by updating their state, and the scheduler drives the flow of execution.
- **Fair Scheduling**:
  - No task can monopolize the event loop because each task only executes a small piece of work before yielding.
- **Extensibility**:
  - New tasks with different intervals and logic can easily be added to the scheduler without modifying its core logic.

---

This implementation is asynchronous but single-threaded and
uses **event-driven programming** to achieve concurrency.

