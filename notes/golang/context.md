# Context

You can manage in-progress operations by using Go [context.Context][context].
A Context is a standard Go data value that can report
whether the overall operation it represents has been
cancelled and is no longer needed. By passing a context.Context
across function calls and services in your application,
those can stop working early and return an error
when their processing is no longer needed.

The context's Done channel is closed when the deadline expires,
when the returned cancel function is called, or
when the parent context's Done channel is closed, whichever happens first.

The caller function checks status of the context's Done channel
and then stops the task if it is closed.

## Examples

### Cancelling database operations after a timeout

Code in the following timeout example derives a Context and
passes it into the sql.DB QueryContext method.

```golang
func QueryWithTimeout(ctx context.Context) {
    // Create a Context with a timeout.
    queryCtx, cancel := context.WithTimeout(ctx, 5*time.Second)
    defer cancel()

    // Pass the timeout Context with a query.
    rows, err := db.QueryContext(queryCtx, "SELECT * FROM album")
    if err != nil {
        log.Fatal(err)
    }
    defer rows.Close()

    // Handle returned rows.
}
```

### End a goroutine

This example demonstrates the use of a cancelable context
to prevent a goroutine leak. By the end of the example function,
the goroutine started by gen will return without leaking.

```golang
func main() {
    gen := func(ctx context.Context) <-chan int {
        dst := make(chan int)
        n := 1
        go func() {
            for {
                select {
                case <-ctx.Done():
                    return // returning not to leak the goroutine
                case dst <- n:
                    n++
                }
            }
        }()
        return dst
    }

    ctx, cancel := context.WithCancel(context.Background())
    defer cancel() // cancel when we want to quit the outer function

    for n := range gen(ctx) {
        fmt.Println(n)
        if n == 5 {
//            cancel() // or cancel whenever we want 
            break
        }
    }
}
```

[context]: https://pkg.go.dev/context@go1.17.3
