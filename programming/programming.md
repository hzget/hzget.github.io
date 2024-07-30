Programming
===========

[Unit Test][unit test tech]
---------------------------

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

[Integer Arithmetic Operation][Integer Overflow] demonstrates
the "overflows" and sign extention  
[Network Concepts][network concepts] shows how a socket is established  
[Data Structure and Algorithms][data structure and algorithms]  

Performance
-----------

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
[multicore]: ./performance/multicore.md
[data structure and algorithms]: ../notes/practice/algorithm.md
[network concepts]: ./basic/network_concepts.md
[unit test tech]: https://github.com/hzget/tech/tree/main/testing
[Atomic]: https://github.com/hzget/go-investigation/tree/main/performance/atomic
[deferment]: ./performance/deferment.md
[profiling]: ../notes/golang/diagnostics/profile/profile.md
