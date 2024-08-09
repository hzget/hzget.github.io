# MultiCore

(Some links: [Schedule in Go][Schedule in Go])

To improve the performance, we can make use of
the multicore CPU in the hardware.

## Multiple cores and Multiple threads

One logic CPU can only run one thread -- It runs machine code
in sequence from that thread.
It's a waste of hardware to leave some cores sleeping.
An ideal situation is that the applications open
as many threads as the cores in the hardware and all
the threads run in parellel for the task of the app.

However, the thing is not simple.

There may be many apps running at the same time and
each does not know how many threads other apps are using.
Usually there're more opened threads than cores.

Even when there's only one app running on the machine,
we cannot simplely open as many threads as cores.
The app may need open several threads for its task while
there's only one core. And the app may open one thread while
there're several cores. It depends on properties of the tasks.

We need to take into consideration some important issues.

## Side-effects

If there're more running threads than cores in the hardware,
the threads will take turns to be run on the cores.
Switching the thread on the core is called context switch.
The CPU needs to store and restore registers to save context.
Some instructions will be wasted for this task.

Further more, there're CPU cache lines to fill the gap
between CPU and memory. Switching context will usually
update caches for the threads -- another waste.

Thus we shall reduce the context swtiching rate to
lower down the waste.

## Goroutine

The golang dev environ provides goroutines to run
slides of codes. The GPM mechnism helps to make sure
that goroutines works correctly with the os scheduler.

* G - goroutine
* P - a queue consisting of G's (goroutines)
* M - OS thread, M stands for machine

One P connects with one M. Each time the Go Scheduler takes
one G from the P and run it on the M.

Suppose there're only one core in the hardware, and 
the app can opens one thread but many goroutines.

Specifically, the thread runs on the core, and the goroutines
take turns to be run in the thread. Switching goroutines
will not stop the thread -- it is always in the running status.
There's no context switch, thus no wastes of instructions
for (re)storing registers and updating cache lines.

Here's the question:

How many threads do we need to open? How many goroutines
do we need to run?

It depends.

## I/O-bounded and CPU-bounded tasks

Some tasks will make the thread go to sleep and wake up
after some conditions. For example, network communications
is much slower than CPU speed, the thread will change to
the sleep status and wait for data from the network.
It's called I/O-bounded task.

If there's only calculation instructions in the thread,
it will never change to the sleeping status. CPU
will run the instructions until the task is completed.
It's called CPU-bounded task.

Context switch is useful for the former and is harmful
for the latter.

Thus for the I/O bounded tasks, we can open one thread
but as many goroutines as needed. The goroutines takes
turns to run on the thread. These tasks run concurrently.

For the CPU bounded tasks, we need to avoid context switch
of the thread.

If the task cannot split into several tasks
to run concurrently, or if there's only one core on the hardware,
we shall open one thread and one goroutine
for the task.

If the task can split into several tasks
to run concurrently and there're two or more cores, we can
open as many threads as the cores and as many goroutines
as the threads, so that all the sub-tasks run in parellel
and no context switch happen. Further more, it makes use
of all the compute power.

Note that concurrent is different with parellel. And also note
that two tasks run concurrently means that the instruction orders
between the tasks do not matter.

[Schedule in Go]: https://www.ardanlabs.com/blog/2018/08/scheduling-in-go-part1.html
