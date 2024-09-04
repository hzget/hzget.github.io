Programming
===========

Testing
---

**keyword**:
[Unit Testing][unit test tech],
[Benchmark Testing][benchmark],
[Test Coverage][coverage],
[Test-Driven Development (TDD)][tdd],

Automatic testcases make life easer for developers.
After adding a new feature, the programmer shall add
new cases to the pool of the existing testcases.
And then run related cases to avoid any new bugs.

[Automated Docs](./docs/docs.md)
--------------------------------

The libary (or package) document helps its users
quickly get its usage. And the docs should be generated
automatically from the source code.

Golang and Rust have their own commands to extract
docs from the ***doc comment*** inside the source code.
[doxygen](https://www.doxygen.nl/) is a tool that can
generate docs from kinds of source files: c, c++, c#,
object-c, python and so on.

Basics
------

| topic | contents |
|:---:|:---|
|standards|[Unicode][unicode]|
|Language| [Integer Overflow][Integer overflow], [Sign Extention][sign]|
|Networks| [socket][network concepts]|
|Algorithms| [Data Structure and Algorithms][data structure and algorithms] |
|compliants| [FFI][ffi] - Foreign Function Interface,<br /> [ABI][abi] - Application Binary Interface, |
|Development| [BDD][bdd], [TDD][tdd], [CDD][cdd], [CI/CD][ci/cd]|

Performance
-----------

[Benchmark Testing][benchmark] measures the performance by running a series of standardized tests  
[Profiling][profiling] helps to analyze run-time performance of a program  
[Atomic][Atomic] helps to avoid contention issue with a "lock" in CPU instruction level  
[Deferment][deferment] helps to avoid unnecessary expense  
[Allocation][allocation]  
[Multicore][multicore]

Others
------

* [Logs](./log.md)
* [Tools](./tools/tools.md)
* [Program](./program.md)

[allocation]: ./performance/allocation.md
[Integer Overflow]: ./basic/integer_overflow.md
[sign]: ./basic/sign_extention.md
[unicode]: ./basic/unicode.md
[ffi]: ./basic/ffi.md
[abi]: ./basic/abi.md
[bdd]: ./basic/bdd.md
[cdd]: ./basic/cdd.md
[tdd]: ./basic/tdd.md
[ci/cd]: ./basic/ci_cd.md
[multicore]: ./performance/multicore.md
[data structure and algorithms]: ../notes/practice/algorithm.md
[network concepts]: ./basic/network_concepts.md
[unit test tech]: https://github.com/hzget/tech/tree/main/testing
[Atomic]: https://github.com/hzget/go-investigation/tree/main/performance/atomic
[deferment]: ./performance/deferment.md
[profiling]: ../notes/golang/diagnostics/profile/profile.md
[benchmark]: ./performance/benchmark.md
[coverage]: ./testing/coverage.md
