slog
===

Package [slog][slog] provides ***structured*** and ***leveled*** logging.
A log record consists of a time, a level, a message, and a set
of key-value pairs. For example,

```golang
slog.Info("hello", "count", 3)

// output:
//  2024/07/31 19:18:28 INFO hello count=3 
```

Useful links
---

 - [slog][slog] official documents
 - [slog-handler-guide][slog-handler-guide] is a guide for
writing a custom handler. It also covers the mechnism of
Logger, performance considerations.
 - [Logging in Go: A Comparison of the Top 9 Libraries](https://betterstack.com/community/guides/logging/best-golang-logging-libraries/)
compares the usage of popular Go Logging Libraries
 - [go-logging-benchmarks](https://github.com/betterstack-community/go-logging-benchmarks)
compares the performance of popular Go Logging Libraries

Design
---

Package slog defines a type, [Logger][Logger], which provides output methods
for reporting events of interest.

Each [Logger][Logger] is associated with a [Handler][Handler].
A Logger output method, such as [Logger.Info][Logger.Info], creates
a [Record][Record] from the method arguments and passes it to the
[Handler][Handler], which decides how to handle it.

In summary, slog has a two-part design.

 * A "frontend," implemented by the [Logger][Logger] type,
gathers stuctured log information, constructs a [Record][Record], and then
passes it to the "backend"
 * A "backend", an implementation of the [Handler][Handler]
interface, handles the record


The following example shows how to log a http request.
It uses [New][New] to create a new logger with a [JSONHandler][JSONHandler]
which writes structured records in json form to standard output.

```golang
logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))
reqlogger := logger.WithGroup("request")

http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    reqlogger.Info("http request", "method", r.Method, "remote", r.RemoteAddr)
})

// output
//   {"time":"2024-07-31T22:08:42.0681172+08:00","level":"INFO","msg":"http request","request":{"method":"GET","remote":"[::1]:54393"}}
```

Another example

```golang
// Infof is an example of a user-defined logging function that wraps slog.
func Infof(logger *slog.Logger, format string, args ...any) {
	if !logger.Enabled(context.Background(), slog.LevelInfo) {
		return
	}
	var pcs [1]uintptr
	runtime.Callers(2, pcs[:]) // skip [Callers, Infof]
	r := slog.NewRecord(time.Now(), slog.LevelInfo, fmt.Sprintf(format, args...), pcs[0])
	_ = logger.Handler().Handle(context.Background(), r)
}

func main() {
	logger := slog.New(slog.NewTextHandler(os.Stdout, nil))
	Infof(logger, "message, %s", "formatted")
}
```

[slog]: https://pkg.go.dev/log/slog
[Logger]: https://pkg.go.dev/log/slog#Logger
[Handler]: https://pkg.go.dev/log/slog#Handler
[Record]: https://pkg.go.dev/log/slog#Record
[Logger.Info]: https://pkg.go.dev/log/slog#Logger.Info
[New]: https://pkg.go.dev/log/slog#New
[JSONHandler]: https://pkg.go.dev/log/slog#JSONHandler
[slog-handler-guide]: https://golang.org/s/slog-handler-guide
