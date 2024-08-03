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
 - [go blog slog][go blog slog] comes into being
 - [slog proposal][slog proposal] proposes adding structured logging with levels to the standard library
 - [projects][projects] that use or enhance slog
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
interface, handles the record.

This design allows to replace the "backend" handler.

slog provides [TextHandler][TextHandler] and [JSONHandler][JSONHandler].
It's default Logger uses a defaultHandler. They have different behavior:

```golang
// defaultLogger with defaultHandler
2024/07/31 19:18:28 INFO hello count=3

// a logger with TextHandler
time=2024-08-01T18:16:37.637+08:00 level=INFO msg=hello count=3

// a logger with JSONHandler
{"time":"2024-08-01T18:40:19.5315339+08:00","level":"INFO","msg":"hello"}
```

For more control over the output format, create a user-specific
handler. And then create a logger via [New][New].

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

// pkg slog source code
//
// enabled reports whether l is greater than or equal to the
// minimum level.
func (h *commonHandler) enabled(l Level) bool {
	minLevel := LevelInfo
	if h.opts.Level != nil {
		minLevel = h.opts.Level.Level()
	}
	return l >= minLevel
}
```

Assemble the output
---

handleState holds state for a single call to commonHandler.handle.
It uses a [Buffer][Buffer], of the type []byte, to construct and
hold the output.
All the "appendxx" methods will call `s.buf.WriteByte()`
or `s.buf.WriteString()` to append msg to the output buffer.

```golang
// pkg slog source code
//
// handleState holds state for a single call to commonHandler.handle.
// The initial value of sep determines whether to emit a separator
// before the next key, after which it stays true.
type handleState struct {
	h       *commonHandler
	buf     *buffer.Buffer // <------- used for constructing the output
	freeBuf bool           // should buf be freed?
	sep     string         // separator to write before next key
	prefix  *buffer.Buffer // for text: key prefix
	groups  *[]string      // pool-allocated slice of active groups, for ReplaceAttr
}

func (h *commonHandler) newHandleState(buf *buffer.Buffer, freeBuf bool, sep string) handleState {
	s := handleState{
		h:       h,
		buf:     buf,
		freeBuf: freeBuf,
		sep:     sep,
		prefix:  buffer.New(),
	}
	if h.opts.ReplaceAttr != nil {
		s.groups = groupPool.Get().(*[]string)
		*s.groups = append(*s.groups, h.groups[:h.nOpenGroups]...)
	}
	return s
}

// handle is the internal implementation of Handler.Handle
// used by TextHandler and JSONHandler.
func (h *commonHandler) handle(r Record) error {
	state := h.newHandleState(buffer.New(), true, "")
	defer state.free()
	if h.json {
		state.buf.WriteByte('{')
	}

	// ...

	// level
	key := LevelKey
	val := r.Level
	if rep == nil {
		state.appendKey(key)
		state.appendString(val.String())
	} else {
		state.appendAttr(Any(key, val))
	}

	// ...

	key = MessageKey
	msg := r.Message
	if rep == nil {
		state.appendKey(key)
		state.appendString(msg)
	} else {
		state.appendAttr(String(key, msg))
	}

	state.groups = stateGroups // Restore groups passed to ReplaceAttrs.
	state.appendNonBuiltIns(r)
	state.buf.WriteByte('\n')

	h.mu.Lock()
	defer h.mu.Unlock()
	_, err := h.w.Write(*state.buf) // <---- buf holds the output
	return err
}

func (s *handleState) appendNonBuiltIns(r Record) {
	// preformatted Attrs
	if pfa := s.h.preformattedAttrs; len(pfa) > 0 {
		s.buf.WriteString(s.sep)
		s.buf.Write(pfa)
		s.sep = s.h.attrSep()
		if s.h.json && pfa[len(pfa)-1] == '{' {
			s.sep = ""
		}
	}

	// Attrs in Record -- unlike the built-in ones, they are in groups started
	// from WithGroup.
	r.Attrs(func(a Attr) bool {
		if s.appendAttr(a) {
			empty = false
		}
		return true
	})

	// ...

}
```

[slog]: https://pkg.go.dev/log/slog
[Logger]: https://pkg.go.dev/log/slog#Logger
[Handler]: https://pkg.go.dev/log/slog#Handler
[Record]: https://pkg.go.dev/log/slog#Record
[Logger.Info]: https://pkg.go.dev/log/slog#Logger.Info
[Buffer]: https://pkg.go.dev/log/slog/internal/buffer#Buffer
[New]: https://pkg.go.dev/log/slog#New
[JSONHandler]: https://pkg.go.dev/log/slog#JSONHandler
[TextHandler]: https://pkg.go.dev/log/slog#TextHandler
[HandlerOptions]: https://pkg.go.dev/log/slog#HandlerOptions
[slog-handler-guide]: https://golang.org/s/slog-handler-guide
[go blog slog]: https://go.dev/blog/slog
[slog proposal]: https://github.com/golang/go/issues/56345
[projects]: https://go.dev/wiki/Resources-for-slog
