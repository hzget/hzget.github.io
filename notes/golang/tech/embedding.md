# Embedding

useful links:
[Effecitive Go][effective go embedding],
[embedding in go][embedding in go],
[struct and interface embedding][struct and interface embedding],

aims:

* "borrow" members from another type
* "intecept" methods of another type
* downgrade an implementation

issues:

* conflict
* overload
* hidding

## Normal Usage

[Effective Go][effective go embedding] :
Go does not provide the typical, type-driven notion of
subclassing, but it does have the ability to ***borrow*** pieces
of an implementation by embedding types within a struct or
interface.

```golang
// Example 1: interface in interface
// in std pkg: io
type Reader interface {
    Read(p []byte) (n int, err error)
}

type Writer interface {
    Write(p []byte) (n int, err error)
}

// ReadWriter is the interface that combines the Reader and Writer interfaces.
type ReadWriter interface {
    Reader
    Writer
}

// Example 2: struct in struct
// in std pkg: bufio
type Reader struct {}
func (b *Reader) Read(p []byte) (n int, err error)

type Writer struct {}
func (b *Writer) Write(p []byte) (nn int, err error)

// ReadWriter implements io.ReadWriter.
type ReadWriter struct {
    *Reader  // *bufio.Reader
    *Writer  // *bufio.Writer
}

// Example 3:
type Job struct {
    Command string
    *log.Logger
}
```

## Intercept

Embedding provides a convenience to intercept methods
of the embedded type. We can change its function.

[sort.Sort][pkg sort] sorts data in ascending order as determined by
the Less method. The type `reverse` embeds the interface and intercepts
its Less() methods: the modified version returns the opposite
of the embedded implementation's Less method.

```golang
// in std pkg: sort
type Interface interface {
    Len() int
    Less(i, j int) bool
    Swap(i, j int)
}

func Sort(data Interface) {...}

type reverse struct {
    Interface
}

// Less returns the opposite of the embedded implementation's Less method.
func (r reverse) Less(i, j int) bool {
    return r.Interface.Less(j, i)
}

func Reverse(data Interface) Interface {
    return &reverse{data}
}

// usage:
s := []int{5, 2, 6, 3, 1, 4} // unsorted
sort.Sort(sort.Reverse(sort.IntSlice(s)))
fmt.Println(s) // output: [6 5 4 3 2 1]
```

## Downgrade an implementation

Downgrading intends to use only some part of an implemention.

```golang
io.Copy(struct{ io.Writer }{sw}, r)
```

[effective go embedding]: https://go.dev/doc/effective_go#embedding
[pkg sort]: https://pkg.go.dev/sort#Sort
[embedding in go]: https://eli.thegreenplace.net/2020/embedding-in-go-part-3-interfaces-in-structs/
[struct and interface embedding]: https://ankur-a22.medium.com/struct-and-interface-embedding-f0da8517fa8a
