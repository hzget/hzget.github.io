# Useful Interfaces

## io.Writer

[io.Writer][io.Writer] is the interface that wraps the basic Write()
method that writes len(p) bytes from p to the underlying data stream.

```golang
type Writer interface {
	Write(p []byte) (n int, err error)
}
```

A well-designed type, with ***Output functionality***,
can specify an io.Writer and call its Write() method
somewhere when necessary.

### Applications

A Logger in pkg [log][std/log] represents an active logging object
that generates lines of output to an io.Writer. Each logging
operation makes a single call to the Writer's Write method.
New creates a new Logger. The out variable sets the destination
to which log data will be written.

```golang
func New(out io.Writer, prefix string, flag int) *Logger {...}

func (l *Logger) Output(calldepth int, s string) error {
	...
	_, err := l.out.Write(l.buf)
	return err
}
```

Package [flag][std/flag] implements command-line flag parsing.
It will print usage or error messages when the command line
comes across a `-h` flag or an invalid flag. The output destination
is the an object of io.Writer, with os.Stderr as a default.

```golang
func (f *FlagSet) PrintDefaults() {
	...
	fmt.Fprint(f.Output(), b.String(), "\n")
	...
}
// Output returns the destination for usage and error messages.
// os.Stderr is returned if output was not set or was set to nil.
func (f *FlagSet) Output() io.Writer {
	if f.output == nil {
		return os.Stderr
	}
	return f.output
}
```

A [bytes.Buffer][std/bytes] is a variable-sized buffer of bytes
that implements the io.Writer and io.Reader interfaces.
It provides ***a convenient way of writing testcases*** of packages.

```golang
// in standard pkg bytes
func (b *Buffer) Write(p []byte) (n int, err error) {
	b.lastRead = opInvalid
	m, ok := b.tryGrowByReslice(len(p))
	if !ok {
		m = b.grow(len(p))
	}
	return copy(b.buf[m:], p), nil
}

// in standard pkg log
// the testcase uses bytes.Buffer to simulate a console log env
func TestOutput(t *testing.T) {
	const testString = "test"
	var b bytes.Buffer
	l := New(&b, "", 0)   // specify the output destination
	l.Println(testString) // it will trigger l.out.Write()
	if expect := testString + "\n"; b.String() != expect {
		t.Errorf("log output should match %q is %q", expect, b.String())
	}
}
```

[io.Writer]: https://pkg.go.dev/io@go1.19.2#Writer
[std/log]: https://pkg.go.dev/log@go1.19.2
[std/flag]: https://pkg.go.dev/flag@go1.19.2
[std/bytes]: https://pkg.go.dev/bytes@go1.19.2
