# Escape Analysis

> How do I know whether a variable is allocated on the heap or the stack?

This is a question from [golang FAQ][FAQ].
From a correctness standpoint, the user don't need to know.
Developers shall focus on the business logic itself without
paying too much attention to memory. The allocation is judged
by the compiler after a basic ***escape analysis*** .

However, the storage location does have an effect on writing
efficient programs. The programmer shall notice this issue
when he places a high value on the performance.

There's only two rules to keep in mind:

* Each variable in Go exists as long as there are references to it.
* It makes more sense to store large variable on the heap rather than the stack.

```golang
  3 //go:noinline
  4 func makeSlice() int {
  5         small := make([]int, 100, 100)
  6         large := make([]int, 10000, 10000)
  7         return len(small) + len(large)
  8 }
  9
 10 //go:noinline
 11 func getInt() (int, *int) {
 12         m, n := 1, 2
 13         return m, &n
 14 }
 15
 16 //go:noinline
 17 func Foo() int {
 18         var vsize = 10
 19         const csize = 10
 20         s1 := make([]int, vsize, vsize)
 21         s2 := make([]int, csize, csize)
 22         return len(s1) + len(s2)
 23 }

//compile:
//  go tool compile -m main.go
//output:
//  main.go:5:15: make([]int, 100, 100) does not escape
//  main.go:6:15: make([]int, 10000, 10000) escapes to heap
//  main.go:12:5: moved to heap: n
//  main.go:20:12: make([]int, vsize, vsize) escapes to heap
//  main.go:21:12: make([]int, csize, csize) does not escape
```

Here's the quota from [golang FAQ][FAQ]:

> From a correctness standpoint, you don't need to know. Each variable in Go exists as long as there are references to it. The storage location chosen by the implementation is irrelevant to the semantics of the language.
>
> The storage location does have an effect on writing efficient programs. When possible, the Go compilers will allocate variables that are local to a function in that function's stack frame. However, if the compiler cannot prove that the variable is not referenced after the function returns, then the compiler must allocate the variable on the garbage-collected heap to avoid dangling pointer errors. Also, if a local variable is very large, it might make more sense to store it on the heap rather than the stack.
>
> In the current compilers, if a variable has its address taken, that variable is a candidate for allocation on the heap. However, a basic escape analysis recognizes some cases when such variables will not live past the return from the function and can reside on the stack.

[FAQ]: https://golang.google.cn/doc/faq#stack_or_heap
