# Pitfall

* compare error with nil
* compare two interfaces

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
        // although the user expects "no error"
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

## compare two interfaces

> The user shall check comparable before comparing
> two interfaces.
>
> "The Go Programming Language Specification":
>
> A comparison of two interface values with identical dynamic types
> causes a ***run-time panic*** if that type is not comparable.
>
> This behavior applies not only to direct interface value comparisons
> but also when comparing arrays of interface values or
> structs with interface-valued fields.

```golang

        var a, b int
        var i, j any

        i, j = a, b
        fmt.Println(i == j) // output: true

        s1, s2 := []int{1}, []int{1}
        // compile error:
        //    invalid operation: s1 == s2 (slice can only be compared to nil)
        // fmt.Println(s1 == s2)

        i, j = s1, s2
        // run-time error:
        //    panic: runtime error: comparing uncomparable type []int
        // fmt.Println(i == j)

        c1 := reflect.TypeOf(s1).Comparable()
        c2 := reflect.TypeOf(s2).Comparable()
        // output: false false
        // fmt.Println(c1, c2)
        if c1 && c2 {
                fmt.Println(i == j)
        }
```
