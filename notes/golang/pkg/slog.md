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

Package slog defines a type, [Logger][Logger], which provides output methods
for reporting events of interest.

Each [Logger][Logger] is associated with a [Handler][Handler].
A Logger output method, such as [Logger.Info][Logger.Info], creates
a [Record][Record] from the method arguments and passes it to the
[Handler][Handler], which decides how to handle it.

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

[slog]: https://pkg.go.dev/log/slog
[Logger]: https://pkg.go.dev/log/slog#Logger
[Handler]: https://pkg.go.dev/log/slog#Handler
[Record]: https://pkg.go.dev/log/slog#Record
[Logger.Info]: https://pkg.go.dev/log/slog#Logger.Info
[New]: https://pkg.go.dev/log/slog#New
[JSONHandler]: https://pkg.go.dev/log/slog#JSONHandler
