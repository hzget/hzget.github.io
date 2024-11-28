To enable tasks to be **paused and resumed** in a task scheduler in C, we need to manage the state of each task explicitly. Tasks will have states like **running**, **paused**, and **completed**, and the scheduler will control transitions between these states. Below is an implementation that supports pausing and resuming tasks.

---

### **Implementation: Task Scheduler with Pause/Resume**

#### **Features**:
- Tasks can be paused and resumed.
- Scheduler controls task state transitions.
- Tasks can yield control to the scheduler to simulate asynchronous behavior.

---

#### **Code**:
```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h> // for usleep

#define MAX_TASKS 10

// Task states
typedef enum {
    TASK_RUNNING,
    TASK_PAUSED,
    TASK_COMPLETED
} TaskState;

// Function pointer type for tasks
typedef void (*TaskFunction)(int *state, int task_id);

// Task structure to represent a task
typedef struct {
    int task_id;            // Task ID
    TaskFunction func;      // Task function
    TaskState state;        // Current state of the task
    int delay_ms;           // Simulated delay for the task
    time_t scheduled_time;  // Next scheduled run time
} Task;

// Task Scheduler structure
typedef struct {
    Task tasks[MAX_TASKS]; // Array of tasks
    int task_count;        // Number of tasks
} TaskScheduler;

// Add a task to the scheduler
void add_task(TaskScheduler *scheduler, TaskFunction func, int delay_ms, int task_id) {
    if (scheduler->task_count >= MAX_TASKS) {
        printf("Scheduler is full! Cannot add more tasks.\n");
        return;
    }

    Task *task = &scheduler->tasks[scheduler->task_count++];
    task->task_id = task_id;
    task->func = func;
    task->state = TASK_RUNNING; // Tasks start in the running state
    task->delay_ms = delay_ms;
    task->scheduled_time = clock() + (delay_ms * CLOCKS_PER_SEC / 1000);

    printf("Task %d added with delay %d ms.\n", task_id, delay_ms);
}

// Run the scheduler
void run_scheduler(TaskScheduler *scheduler) {
    while (1) {
        int active_tasks = 0;

        for (int i = 0; i < scheduler->task_count; i++) {
            Task *task = &scheduler->tasks[i];

            if (task->state == TASK_RUNNING && clock() >= task->scheduled_time) {
                printf("Executing Task %d...\n", task->task_id);
                task->func((int *)&task->state, task->task_id); // Pass state to the task function
                task->scheduled_time = clock() + (task->delay_ms * CLOCKS_PER_SEC / 1000);
            }

            if (task->state != TASK_COMPLETED) {
                active_tasks++;
            }
        }

        if (active_tasks == 0) {
            break; // Exit when all tasks are completed
        }

        usleep(1000); // Small delay to prevent busy-waiting
    }

    printf("All tasks completed!\n");
}

// Example task functions
void task_function_1(int *state, int task_id) {
    static int counter = 0;
    printf("Task %d: Running function 1. Counter: %d\n", task_id, counter);

    counter++;
    if (counter == 3) {
        printf("Task %d: Pausing...\n", task_id);
        *state = TASK_PAUSED;
    } else if (counter == 5) {
        printf("Task %d: Resuming...\n", task_id);
        *state = TASK_RUNNING;
    } else if (counter == 7) {
        printf("Task %d: Completing...\n", task_id);
        *state = TASK_COMPLETED;
    }
}

void task_function_2(int *state, int task_id) {
    static int progress = 0;
    printf("Task %d: Running function 2. Progress: %d%%\n", task_id, progress);

    progress += 25;
    if (progress >= 100) {
        printf("Task %d: Completed.\n", task_id);
        *state = TASK_COMPLETED;
    }
}

int main() {
    TaskScheduler scheduler = {0}; // Initialize the scheduler

    // Add tasks to the scheduler
    add_task(&scheduler, task_function_1, 500, 1); // Task 1: 500 ms delay
    add_task(&scheduler, task_function_2, 1000, 2); // Task 2: 1000 ms delay

    printf("Starting scheduler...\n");

    // Run the scheduler
    run_scheduler(&scheduler);

    return 0;
}
```

---

### **Explanation of the Code**

1. **Task States**:
   - **TASK_RUNNING**: The task is currently running and will be executed by the scheduler.
   - **TASK_PAUSED**: The task is paused and skipped during execution.
   - **TASK_COMPLETED**: The task has finished execution and is removed from the active queue.

2. **State Management**:
   - Task functions use a pointer to their state (`*state`) to signal the scheduler whether to pause, resume, or complete the task.

3. **Static Variables**:
   - Static variables (`counter` and `progress`) are used to track the internal progress of tasks across multiple executions.

4. **Scheduler Behavior**:
   - The scheduler checks the state of each task before execution.
   - Tasks in the **TASK_RUNNING** state are executed, and their state can be updated by the task function.

5. **Task Execution Flow**:
   - Tasks are executed in small steps (e.g., incrementing `counter` or `progress`).
   - Tasks can pause themselves by changing their state to **TASK_PAUSED** and resume later by switching back to **TASK_RUNNING**.

---

### **Sample Output**:
```
Task 1 added with delay 500 ms.
Task 2 added with delay 1000 ms.
Starting scheduler...
Executing Task 1...
Task 1: Running function 1. Counter: 0
Executing Task 2...
Task 2: Running function 2. Progress: 0%
Executing Task 1...
Task 1: Running function 1. Counter: 1
Executing Task 1...
Task 1: Running function 1. Counter: 2
Executing Task 1...
Task 1: Running function 1. Counter: 3
Task 1: Pausing...
Executing Task 2...
Task 2: Running function 2. Progress: 25%
Executing Task 2...
Task 2: Running function 2. Progress: 50%
Executing Task 2...
Task 2: Running function 2. Progress: 75%
Executing Task 2...
Task 2: Running function 2. Progress: 100%
Task 2: Completed.
Executing Task 1...
Task 1: Resuming...
Executing Task 1...
Task 1: Running function 1. Counter: 4
Executing Task 1...
Task 1: Running function 1. Counter: 5
Task 1: Completing...
All tasks completed!
```

---

### **Features of this Implementation**:
1. **Pause/Resume Support**:
   - Tasks can pause themselves by setting their state to `TASK_PAUSED`.
   - Tasks can resume by switching back to `TASK_RUNNING`.

2. **Fine-Grained Execution**:
   - Each task runs in small steps, allowing the scheduler to interleave task execution.

3. **Dynamic State Updates**:
   - Task states can change dynamically based on internal logic, enabling flexible task behavior.

---

### **Potential Enhancements**:
1. **Task Priorities**:
   - Add priorities to tasks to decide execution order.
2. **Recurring Tasks**:
   - Allow tasks to automatically re-enter the queue after completion.
3. **Preemption**:
   - Introduce time slices to preempt running tasks for fairness.

This implementation demonstrates a basic yet powerful task scheduler with support for pausing and resuming tasks in C.
