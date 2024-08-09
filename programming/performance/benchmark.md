Bechmark Testing
===

Benchmark testing in programming is a process used to measure the
performance of software, algorithms, or hardware by running a series
of standardized tests. The goal of benchmark testing is to assess
how well a system or component performs under specific conditions
and compare it against a standard or other systems.
This type of testing is crucial for understanding the
efficiency, speed, and scalability of the code or system being evaluated.

In a word, benchmark testing is a vital tool for understanding and
improving the performance of systems and software by providing
measurable, comparable, and actionable insights.

Key Aspects of Benchmark Testing
---

* Performance Measurement: Benchmark tests focus on key performance metrics, such as execution time, throughput, memory usage, and resource utilization. These metrics help determine how well a system or code performs under various conditions.

* Standardized Tests: The tests used in benchmarking are typically well-defined and repeatable, allowing for consistent and comparable results. These tests can be based on real-world scenarios or synthetic workloads designed to stress specific parts of the system.

* Comparative Analysis: Benchmark results are often used to compare different systems, algorithms, or configurations. This comparison helps identify the most efficient solutions or the potential need for optimization.

* Optimization and Tuning: Benchmarking can reveal performance bottlenecks or inefficiencies, guiding developers in optimizing code or system configurations. It provides data-driven insights that inform decisions on improving performance.

* Scalability Testing: Benchmark tests can be used to assess how well a system scales with increased load or data size. This is especially important for applications that need to handle growth over time.

* Hardware vs. Software Benchmarks: Benchmark testing can be applied to both hardware (e.g., CPU, GPU, storage) and software (e.g., algorithms, database queries). Hardware benchmarks focus on the physical components' performance, while software benchmarks evaluate the efficiency and speed of code execution.

Examples of Benchmark Testing
---

* Algorithm Benchmarking: Testing different sorting algorithms to compare their execution time on various data sets.
* System Benchmarking: Measuring the performance of a web server under different levels of traffic to determine its scalability.
* Database Benchmarking: Evaluating the speed of query execution in different database management systems.

Benchmark in golang
---

Golang testing framework provides a convenient way for
[benchmark testing][golang benchmark].
The following example shows a benchmark testing
of the performance of assigning a value to an interface.

We can check the number of allocations during the assignment.

```golang
import "testing"

type Big struct {
        A, B, C int
}

type Small struct {
        A int
}

var s string = string([]byte{'h', 'e', 'l', 'l', 'o'})
var p any

func BenchmarkIfAssignment(b *testing.B) {
        b.ReportAllocs()

        b.Run("Integer", func(b *testing.B) {
                for i := 0; i < b.N; i++ {
                        p = i
                }
        })

        b.Run("String", func(b *testing.B) {
                for i := 0; i < b.N; i++ {
                        p = s
                }
        })

        b.Run("Big", func(b *testing.B) {
                for i := 0; i < b.N; i++ {
                        p= Big{A: i}
                }
        })

        b.Run("Small", func(b *testing.B) {
                for i := 0; i < b.N; i++ {
                        p= Small{A: i}
                }
        })
}


# go test -v -bench=IfAssign -benchmem
goos: windows
goarch: amd64
pkg: example.com/go/main
cpu: Intel(R) Core(TM) i5-7200U CPU @ 2.50GHz
BenchmarkIfAssignment
BenchmarkIfAssignment/Integer
BenchmarkIfAssignment/Integer-4         	61519532	        19.31 ns/op	       8 B/op	       0 allocs/op
BenchmarkIfAssignment/String
BenchmarkIfAssignment/String-4          	31193947	        41.25 ns/op	      16 B/op	       1 allocs/op
BenchmarkIfAssignment/Big
BenchmarkIfAssignment/Big-4             	39351229	        59.57 ns/op	      24 B/op	       1 allocs/op
BenchmarkIfAssignment/Small
BenchmarkIfAssignment/Small-4           	30477660	        36.65 ns/op	       7 B/op	       0 allocs/op
PASS
ok  	example.com/go/main	6.409s
```

***Other examples:***

 - [go-logging-benchmarks](https://github.com/betterstack-community/go-logging-benchmarks)
compares the performance of popular Go Logging Libraries

[golang benchmark]: https://pkg.go.dev/testing#hdr-Benchmarks

