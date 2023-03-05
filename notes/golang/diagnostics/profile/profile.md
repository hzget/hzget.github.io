# Profiling

Profiling helps to analyze run-time performance of a program.

It is useful for identifying expensive or frequently called
sections of code.
Kinds of profiles to analyze: cpu, heap, goroutine, block, mutex, threadcreate.
Users need to collect the profiling data and use pprof tools
to filter and visualize the top code paths.

Useful links:

* [diagnistics profiling][diagnistics profiling] gives basic concepts of profiling

Involved packages or tools:

* Package [net/http/pprof][net/http/pprof] serves via its HTTP server runtime profiling data
* Package [runtime/pprof][runtime/pprof] writes runtime profiling data
* [go tool pprof] is a tool for visualization and analysis of profiling data

## Quick Start

[goroutine leak](./goroutine.md) gives an example of profiling
goroutine leak via pprof. We can examine the goroutine profile
from kinds of aspects. One of them is to use `top` command in
the interactive mode.

```golang
# interactive mode
> go tool pprof main.exe goroutine.pb.gz
File: main.exe
Type: goroutine
Time: Mar 4, 2023 at 11:20pm (CST)
Entering interactive mode (type "help" for commands, "o" for options)
(pprof) top
Showing nodes accounting for 93, 100% of 93 total <----- too many running goroutines
Showing top 10 nodes out of 33
      flat  flat%   sum%        cum   cum%
        92 98.92% 98.92%         92 98.92%  runtime.gopark
         1  1.08%   100%          1  1.08%  runtime.goroutineProfileWithLabels
         0     0%   100%          1  1.08%  internal/poll.(*FD).Accept
         0     0%   100%          1  1.08%  internal/poll.(*FD).Read
         0     0%   100%          1  1.08%  internal/poll.(*FD).acceptOne
         0     0%   100%          2  2.15%  internal/poll.(*pollDesc).wait
         0     0%   100%          2  2.15%  internal/poll.execIO
         0     0%   100%          2  2.15%  internal/poll.runtime_pollWait
         0     0%   100%         90 96.77%  main.logHandler.func1     <----- 90 goroutines unexpected -- leaks
         0     0%   100%          1  1.08%  main.main
(pprof) q
```

As we can see, there're 93 running goroutines. But we expect
only one running goroutine from package main.

There're 90 running goroutines blocked on the function
`main.logHandler.func1`. If we examine the profile via
web interative mode, we can get line of code:

```bash
# visit http://localhost:6061/ui/source
# result:
main.logHandler.func1
D:\proj\github.com\hzget\go-investigation\diagnostics\profile\main.go

  Total:           0         90 (flat, cum) 96.77%
     24            .          .              ch <- http.StatusBadRequest 
     25            .          .              return 
     26            .          .             } 
     27            .          .             // simulation of a time consuming process like writing logs into db 
     28            .          .             time.Sleep(time.Duration(rand.Intn(400)) * time.Millisecond) 
     29            .         90             ch <- http.StatusOK // <------- 90 goroutines blocked here
     30            .          .            }() 
     31            .          .            
     32            .          .            select { 
     33            .          .            case status := <-ch: 
     34            .          .             w.WriteHeader(status) 
```

The goroutine blocked when sending data to the channel.
Go back to the source code, we find it is an unbuffered
channel. If the consumer goroutine exits earlier, this goroutine
will blocked for ever at this line of code.

To fix the issue, just make it a buffered channel.
After that, profile the fixed program, we can see there's no goroutine leaks.

[net/http/pprof]: https://pkg.go.dev/net/http/pprof
[runtime/pprof]: https://pkg.go.dev/runtime/pprof
[go tool pprof]: https://github.com/google/pprof/blob/main/doc/README.md
[diagnistics profiling]: https://golang.google.cn/doc/diagnostics#profiling
