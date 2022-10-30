# http

Package [net/http][net/http] provides HTTP client and server
implementations.

The server just needs to register http handlers in a map
structure (which is inside a ServeMux structure) and then
listen and serve requests on incoming
connections. To handle a connection, the server goroutine
parses the uri, extracts its handler in the map, and then
invokes this handler function.

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

The function `ListenAndServe` hides details of the underlying
tcp interaction:

[1] listen to the service port  
[2] accept a new request and create a new conn object (which
contains local and remote endpoints, i.e., sockets)
[3] open a new goroutine to handle this conn, and then go to [2]

[net/http]: https://pkg.go.dev/net/http