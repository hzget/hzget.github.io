# Metrics

In **[benchmark testing][benchmark]**, a **metric** is a **measurable quantity used to evaluate the performance of the system under test**.

For example, if you benchmark a database, you might measure:

| Metric              | Meaning                                          |             Example |
| ------------------- | ------------------------------------------------ | ------------------: |
| **Throughput**      | How much work the system completes per unit time | 50,000 requests/sec |
| **Latency**         | How long one operation takes                     |                2 ms |
| **CPU utilization** | How much CPU is being used                       |                 75% |
| **Memory usage**    | How much memory is consumed                      |              1.2 GB |
| **I/O throughput**  | Amount of data read/written per unit time        |            500 MB/s |
| **Error rate**      | Fraction of operations that fail                 |               0.01% |

### Metric vs. benchmark

These two terms are related but different:

* **Benchmark** = the **test/workload** you run.
* **Metric** = the **measurement** you use to evaluate the result.

For example:

> Benchmark: perform 1 million HTTP requests against a web server.

You could collect these metrics:

> throughput = 82,000 requests/sec
> average latency = 12 ms
> p95 latency = 25 ms
> p99 latency = 48 ms
> CPU utilization = 63%

So, conceptually:

```text
             Benchmark
                 │
                 │ runs workload
                 ▼
          ┌───────────────┐
          │ System Under  │
          │     Test      │
          └───────────────┘
                 │
                 │ produces measurements
                 ▼
       ┌──────────────────────┐
       │       Metrics        │
       ├──────────────────────┤
       │ throughput           │
       │ latency              │
       │ CPU utilization      │
       │ memory usage         │
       │ error rate           │
       └──────────────────────┘
```

### An important distinction

A **metric isn't necessarily a single number**.

For latency, for example, you might collect millions of individual observations:

```text
1.2 ms
1.5 ms
1.3 ms
...
87.4 ms
```

Then derive metrics such as:

```text
mean latency  = 3.2 ms
median        = 1.8 ms
p95           = 7.1 ms
p99           = 15.4 ms
max           = 87.4 ms
```

In performance engineering, **p95/p99 latency** are often more informative than average latency because they describe the **tail of the latency distribution**.

So when someone says:

> "We need to define the benchmark metrics."

they usually mean:

> **What quantities will we measure and report to determine how well the system performs?**

This is closely related to the **Metrics** part of observability that you asked about previously, although benchmark metrics are specifically measurements collected to characterize performance under a controlled workload.

[benchmark]: ./benchmark.md
