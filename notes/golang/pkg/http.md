# http

Package [net/http][net/http] provides HTTP client and server
implementations.

## Usage

The server just needs to register http handlers in a map
structure (which is inside a ServeMux structure) and then
listen and serve requests on incoming connections.

```golang
// user code
// register handlers and start the service
http.HandleFunc("/hello", helloHandler)
log.Fatal(http.ListenAndServe(":8080", nil))

// the underlying implementation
// src code in pkg net/http
func HandleFunc(pattern string, handler func(ResponseWriter, *Request)) {
	...
	e := muxEntry{h: HandlerFunc(handler), pattern: pattern}
	mux.m[pattern] = e
	...
}
// DefaultServeMux is used if handler is nil
func ListenAndServe(addr string, handler Handler) error {
	...
	for {
		...
		serverHandler{c.server}.ServeHTTP(w, w.req)
		...
	}
}

func (mux *ServeMux) ServeHTTP(w ResponseWriter, r *Request) {
	...
	h, _ := mux.m[path]
	h.ServeHTTP(w, r)
}

type HandlerFunc func(ResponseWriter, *Request)
func (f HandlerFunc) ServeHTTP(w ResponseWriter, r *Request) {
	f(w, r)
}

```

## TCP Connection

The function `ListenAndServe` hides details of the underlying
tcp interaction (pls refer to [socket example][tcp interaction]):

[1] listen to the service port  
[2] accept a new request and create a new conn object (which
contains local and remote endpoints, i.e., sockets)  
[3] open a new goroutine to handle this conn, and then go to [2]

## Multiplexer

The Server structure contains a Handler to handle a connection.

```golang
// src code
type Server struct {
	Addr string
	Handler Handler // handler to invoke
	// other elements ...
}
type Handler interface {
	ServeHTTP(ResponseWriter, *Request)
}
```

We can just write a function to implement the Handler interface.

1. abstract uri in the request line, e.g., `GET /admin/users HTTP/1.1`
2. run a code block of `if-else` conditions
3. trigger corresponding actions

However, the `if-else` block would be complicated and
difficult to maintain. A more appropriate way is to add a
***multiplexer***, working as a ***middleware***, which matches the
URL of each incoming request against a list of ***registered*** patterns
and calls the corresponding handler.

The type ServeMux does this job.

1. registration stage: save handlers for each pattern via `ServeMux.HandleFunc()`
2. dispatching stage: match uri in request line and trigger its handler

```golang
// data structure
type ServeMux struct {
	mu    sync.RWMutex
	m     map[string]muxEntry // store handlers for each pattern
}

// registtration stage
// HandleFunc() --> DefaultServeMux.HandleFunc() --> DefaultServeMux.Handle()
http.HandleFunc("/hello", helloHandler)
// underlyig mechnism
func (mux *ServeMux) Handle(pattern string, handler Handler) {
	...
	e := muxEntry{h: handler, pattern: pattern}
	mux.m[pattern] = e
	...
}

// dispatching stage
func (mux *ServeMux) ServeHTTP(w ResponseWriter, r *Request) {
	...
	h, _ := mux.m[path]
	h.ServeHTTP(w, r)
}

```

When a Server is created,
a ServeMux, with registered handlers, is assigned to its
Handler member. Once a conn is established,
`ServeMux.ServeHTTP()` will be called to dispatch the request.
If the user does not specify a Handler, a default ServeMux is used.

## MiddleWare

The multiplexer ServeMux is also a middleware in the architecture.
There're places that the user can manipulate:

* embed another middleware, e.g., log request info in the Handler
* replace the default multiplexer ServeMux with another one, e.g., httprouter

[HttpRouter][HttpRouter] is a lightweight high performance
HTTP request router (also called multiplexer or just mux for short).

In contrast to the default mux of Go's net/http package,
this router supports variables in the routing pattern and
matches against the request method. It also scales better.

[net/http]: https://pkg.go.dev/net/http
[tcp interaction]: ../../../programming/basic/network_concepts.md
[HttpRouter]: https://github.com/julienschmidt/httprouter
