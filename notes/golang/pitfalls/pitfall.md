# Pitfall

## compare error with nil

> A function shall return an error interface
> instead of a specific error type. Otherwise,
> its user is easy to fall into a pitfall.
>
> "The Go Programming Language Specification":
>
> Two interface values are equal if they have
> ***identical dynamic types and equal dynamic values*** or if both have value nil.

```golang
package main

import (
        "fmt"
)

type appErr string
func (e *appErr) Error() string {
        return string(*e)
}

// suggest to return an error interface
// instead of a specific error type
func login() *appErr {
        return nil 
}

func start() error {
        return login()
}

func main() {
        // fall into a pitfall when comparing with nil
        // output: error: *main.appErr, <nil>
        if err := start(); err != nil {
                fmt.Printf("error: %T, %v\n", err, err)
        }

        fmt.Println(login() == nil) // output: true
        fmt.Println(start() == nil) // output: false

        // the underlying principle:
        // err1 is a pointer whereas err2 is an interface
        var err1 *appErr = nil 
        var err2 error = err1

        fmt.Println(err1 == nil) // output: true
        fmt.Println(err2 == nil) // output: false

        fmt.Printf("%T, %v\n", err1, err1) // output: *main.appErr, <nil>
        fmt.Printf("%T, %v\n", err2, err2) // output: *main.appErr, <nil>
}
```
