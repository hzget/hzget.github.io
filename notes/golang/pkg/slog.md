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

Logger, Record & Handler
---

Here's the details that show how a "log" is transferred to
a handler.

```golang

// Suppose we run a Logger.Info() method.
logger := slog.New(slog.NewTextHandler(os.Stdout, nil))
logger.Info("hello", "count", 3)
// Output:
//   time=2024-08-01T18:16:37.637+08:00 level=INFO msg=hello count=3


// pkg slog source code
// Info logs at [LevelInfo].
func (l *Logger) Info(msg string, args ...any) {
	l.log(context.Background(), LevelInfo, msg, args...)
}

func (l *Logger) log(ctx context.Context, level Level, msg string, args ...any) {
	if !l.Enabled(ctx, level) {
		return
	}

	var pcs [1]uintptr
	// skip [runtime.Callers, this function, this function's caller]
	runtime.Callers(3, pcs[:])
	r := NewRecord(time.Now(), level, msg, pcs[0])
	r.Add(args...)

	_ = l.Handler().Handle(ctx, r)
}
```

Options
---

Options help to customize the handler's behavior.
[HandlerOptions][HandlerOptions] are options for a TextHandler or JSONHandler. A zero HandlerOptions consists entirely of default values.

Suppose we set the [HandlerOptions.Level] field to control
the minimum level for logging.

```golang
// a Level value fixes the handler's minimum level throughout its lifetime.
h := slog.NewJSONHandler(os.Stderr, &slog.HandlerOptions{Level: slog.LevelWarn})
slog.SetDefault(slog.New(h))
slog.Info("hello")
slog.Warn("Shanghai")
// Output:
//  {"time":"2024-08-01T18:40:19.5315339+08:00","level":"WARN","msg":"Shanghai"}

// Setting it to a LevelVar allows the level to be varied dynamically.
var programLevel = new(slog.LevelVar) // Info by default
h = slog.NewJSONHandler(os.Stderr, &slog.HandlerOptions{Level: programLevel})
slog.SetDefault(slog.New(h))
programLevel.Set(slog.LevelError)
slog.Info("hi")
slog.Warn("NewYork")
slog.Error("America")
// Output:
//  {"time":"2024-08-01T18:40:19.5315339+08:00","level":"ERROR","msg":"America"}   

```

[slog]: https://pkg.go.dev/log/slog
[Logger]: https://pkg.go.dev/log/slog#Logger
[Handler]: https://pkg.go.dev/log/slog#Handler
[Record]: https://pkg.go.dev/log/slog#Record
[Logger.Info]: https://pkg.go.dev/log/slog#Logger.Info
[New]: https://pkg.go.dev/log/slog#New
[JSONHandler]: https://pkg.go.dev/log/slog#JSONHandler
[TextHandler]: https://pkg.go.dev/log/slog#TextHandler
[HandlerOptions]: https://pkg.go.dev/log/slog#HandlerOptions
[slog-handler-guide]: https://golang.org/s/slog-handler-guide
