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

***api***

A Logger represents an active logging object that generates
lines of ***formatted output*** to an ***io.Writer***,
which writes to the underlying data stream.

```golang
/*
 * New creates a new Logger. The header is controlled by the flag.
 * 
 *   func New(out io.Writer, prefix string, flag int) *Logger
 *
 */
  9 logger1 := log.New(os.Stderr, "[httpd] ", log.LstdFlags|log.Lmsgprefix)
 10 logger1.Println("a new signup from 192.168.0.5")
 11
 12 logger2 := log.New(os.Stderr, "[cwmpd] ", log.LstdFlags|log.Lmsgprefix|log.Lshortfile)
 13 logger2.Println("the user requests to upload the image")
 14
 15 logger := log.New(os.Stderr, "", log.LstdFlags|log.Lmicroseconds|log.LUTC)
 16 logger.Println("exit...")
```


The format is very simple.
For complex structured and leveled logging, we need to
turn to [slog][slog].

[log]: https://pkg.go.dev/log
[slog]: slog.md
