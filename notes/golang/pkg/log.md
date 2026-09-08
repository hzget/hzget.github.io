# log

Package [log][log] implements a simple logging package.

***Behavior***

```golang
2026/09/08 17:58:02 starting...
2026/09/08 17:58:02 [httpd] a new signup from 192.168.0.5
2026/09/08 17:58:02 main.go:13: [cwmpd] the user requests to upload the image
2026/09/08 09:58:02.369944 exit...
```

***Design***

The header of each log entry are controlled by "flags" that can
be or'ed together.

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

A Logger represents an active logging object that generates
lines of ***formatted output*** to an ***io.Writer***,
which writes to the underlying data stream.

```golang
// default logger writes to the standard error
log.Println("here is a log to std err")
// output: 2022/10/24 22:45:49 here is a log to std err

// a customized logger writes to bytes.Buffer that implements io.Writer
var buf bytes.Buffer
logger := log.New(&buf, "[logger] ", log.Ltime|log.Lmicroseconds)
logger.Printf("here is a log to bytes.Buffer")
fmt.Print(&buf)
// output: [logger] 22:45:49.141439 here is a log to bytes.Buffer
```


The format is very simple.
For complex structured and leveled logging, we need to
turn to [slog][slog].

[log]: https://pkg.go.dev/log
[slog]: slog.md
