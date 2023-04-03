# Programming

## [Unit Test][unit test tech]

Automatic testcases make life easer for developers.
After adding a new feature, the programmer can add
new cases to the pool of the existing testcases.
And then run (corresponding) testcases to keep
code quality.

## Basics

[Integer Arithmetic Operation][Integer Overflow] demonstrates
the "overflows" and sign extention  
[Network Concepts][network concepts] shows how a socket is established  
[Data Structure and Algorithms][data structure and algorithms]  

## Performance

[Profiling][profiling] helps to analyze run-time performance of a program  
[Atomic][Atomic] helps to avoid contention issue with a "lock" in CPU instruction level  
[garbage collection][garbage collection]  
[Multicore][multicore]

## Others

* [Logs](./log.md)
* [Tools](./tools/tools.md)
* [Program](./program.md)

[garbage collection]: ./performance/garbagecollection.md
[Integer Overflow]: ./basic/integer_overflow.md
[multicore]: ./performance/multicore.md
[data structure and algorithms]: ../notes/practice/algorithm.md
[network concepts]: ./basic/network_concepts.md
[unit test tech]: https://github.com/hzget/tech/tree/main/testing
[Atomic]: https://github.com/hzget/go-investigation/tree/main/performance/atomic
[profiling]: ../notes/golang/diagnostics/profile/profile.md
