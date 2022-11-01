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

## Use a Multiplex as a Middleware

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

We can just write a function to implment the Handler interface.
However, we need to manually parse the uri pattern in the
request line of the http message, and then trigger corresponding
actions. Here's an example of the Request Line:

```golang
GET /admin/users HTTP/1.1
```

A more appropriate way is to add a multiplex which matches the
URL of each incoming request against a list of ***registered*** patterns
and calls the handler for the pattern that most closely matches
the URL.

The type ServeMux does this job. It implements the Handler
interface and works as a ***middleware*** in the handling process.
Once a conn is established, ServeMux will invoke its ServeHTTP()
method which ***multiplexes*** the conn.

```golang
type ServeMux struct {
	mu    sync.RWMutex
	m     map[string]muxEntry // store handlers for each pattern
}

func (mux *ServeMux) ServeHTTP(w ResponseWriter, r *Request) {
	...
	h, _ := mux.m[path]
	h.ServeHTTP(w, r)
}

```

The registration mechnism is described in the above "Usage" Section.

[net/http]: https://pkg.go.dev/net/http
[tcp interaction]: ../../../programming/basic/network_concepts.md
