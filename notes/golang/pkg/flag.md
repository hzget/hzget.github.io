# flag

Package [flag][flag] implements command-line flag parsing.

It provides a mechnism to ***parse a slice of textual input***,
which can be used in many situations besides command-line.
Here is an example:

```golang
// parse the command-line arguments
// For example: go run . -fail 5
var nFail int
flag.IntVar(&nFail, "fail", 12, "number of fail")
flag.Parse() // nFail is 5 in this case

// parse a slice of textual input
var nSuccess int
fs := flag.NewFlagSet("ExampleIntVar", flag.ExitOnError)
fs.IntVar(&nSuccess, "success", 100, "number of success")

fs.Parse([]string{"-success", "500"}) // nSuccess is 500 in this case
```

We need to register the parsing rules for each "flag" (in a
map structure in this case). Then extract the rule and apply it during
the parsing process.
The mechnism to parse a slice of texts:

1. register rules: bind a variable to the expected flag
2. register rules: create a Flag structure to store parsing rules
3. register rules: add the Flag to FlagSet
4. parse input: traverse the slice and parse each flag to corresponding variable

```golang
func (f *FlagSet) IntVar(p *int, name string, value int, usage string) {
        // [1] bind a variable to the expected flag
        f.Var(newIntValue(value, p), name, usage)
}

func (f *FlagSet) Var(value Value, name string, usage string) {
        ...
        // [2] create a Flag to store parsing rules
        flag := &Flag{name, usage, value, value.String()}
        ...
        // [3] add the Flag to FlagSet
        f.formal[name] = flag
}

type intValue int
func newIntValue(val int, p *int) *intValue {
        *p = val
        return (*intValue)(p)
}
func (i *intValue) Set(s string) error {/* parsing rules */}
func (i *intValue) String() string { return strconv.Itoa(int(*i)) }

type Value interface {
        String() string
        Set(string) error
}

// [4] Parse flags from input list.
func (f *FlagSet) Parse(arguments []string) error {
        ...
        for {
                ...
                flag, ok := f.formal[name]
                err := flag.Value.Set(value)
        }
}
```

It works like [net/http][net/http] that registers handler functions
in a map structure and extract corresponding handler from the map
when a http request comes in.

```golang
// register handlers and start the service
http.HandleFunc("/hello", helloHandler)
log.Fatal(http.ListenAndServe(":8080", nil))

// src code
func HandleFunc(pattern string, handler func(ResponseWriter, *Request)) {
	...
	e := muxEntry{h: handler, pattern: pattern}
	mux.m[pattern] = e
	...
}
func ListenAndServe(addr string, handler Handler) error {
	...
	for {
		...
		h, _ := mux.m[path]
		h(w, r)
		...
	}
}
```

[flag]: https://pkg.go.dev/flag@go1.19.2
[net/http]: https://pkg.go.dev/net/http@go1.19.2
