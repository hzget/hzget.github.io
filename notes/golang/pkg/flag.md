# flag

Package [flag][std/flag] implements command-line flag parsing.

It provides a mechnism to ***parse a slice of textual input***,
which can be used in many situations other than command-line.
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

The mechnism to parse a slice of texts:

1. bind a variable to the expected flag
2. create a Flag structure to store parsing its rules
3. add the Flag to FlagSet
4. traverse the slice and parse each flag to corresponding variable

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

// [4] Parse flag definitions from the argument list.
func (f *FlagSet) Parse(arguments []string) error {
        ...
        for {
                ...
                flag, ok := f.formal[name]
                err := flag.Value.Set(value)
        }
}
```

[std/flag]: https://pkg.go.dev/flag@go1.19.2
