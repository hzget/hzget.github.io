# log

Package [log][log] implements a simple logging package.

A Logger represents an active logging object that generates
lines of ***formatted output*** to an io.Writer, which writes
to the underlying data stream. Besides writing log messages,
it can also be used in many other situations such as sending
messages to the client.

The output "format" is a line of plain text --- the log message
prefixed with a "header". Here is an example:

```golang
// write to standard error
log.Println("here is a log to std err")
// output: 2022/10/24 22:45:49 here is a log to std err

// write to bytes.Buffer that implements io.Writer
var buf bytes.Buffer
logger := log.New(&buf, "[logger] ", log.Ltime|log.Lmicroseconds)
logger.Printf("here is a log to bytes.Buffer")
fmt.Print(&buf)
// output: [logger] 22:45:49.141439 here is a log to bytes.Buffer
```

The header of each log entry are controlled by "flags" that can
be or'ed together. Here is the design:

```golang
const (
	Ldate         = 1 << iota     // the date in the local time zone: 2009/01/23
	Ltime                         // the time in the local time zone: 01:23:23
	Lmicroseconds                 // microsecond resolution: 01:23:23.123123.  assumes Ltime.
	Llongfile                     // full file name and line number: /a/b/c/d.go:23
	Lshortfile                    // final file name element and line number: d.go:23. overrides Llongfile
	LUTC                          // if Ldate or Ltime is set, use UTC rather than the local time zone
	Lmsgprefix                    // move the "prefix" from the beginning of the line to before the message
	LstdFlags     = Ldate | Ltime // initial values for the standard logger
)
```

The format is very simple, thus the pkg is used in very simple
situation. For complex format, like "leveled" log, we need to
refer to other log packages such as [slog][slog] and [zerolog][zerolog].

[log]: https://pkg.go.dev/log
[slog]: https://pkg.go.dev/log/slog
[zerolog]: https://github.com/rs/zerolog
