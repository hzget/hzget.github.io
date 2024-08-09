# Network Concepts

## Socket

A tcp socket, consisting of an IP address and a port,
is an ***endpoint instance*** in the context of either
a specific tcp connection or a listenning state.
A tcp connection is identified by two endpoint: local endpoint
and remote endpoint. Thus a tcp socket is not a connection,
but an endpoint of a connection.

A port is a ***service endpoint*** by which a server can
provide a service. A port is not a socket, but a component
of a socket.

A server process creates a socket on startup that are in the
listening state, waiting for initiatives from client programs.
Once a connection is established, a new socket (local endpoint
of the conn) exists and it provides a duplex byte stream
whereby the process can read and write byte data from and to
the peer.

The server process can serve multiple clients concurrently via
maintaining connections with distinct threads. However, the
cost of context switching (of threads) is high, thus the
multi-threads method is not applicable when there're many clients.
The issue is addressed by the I/O multiplexing technique. Only one
thread is needed in this case.

The Golang env goes further, it opens as many goroutines
as connections. Once a new conn is established, register its socket
to the underlying I/O multiplexing routine. The goroutine goes to
sleep status when the socket i/o is not ready. Otherwise, it wakes
up to read from or write to the endpoint.

Here's an example of tcp programming in golang. The socket details
are hidden in the underlying structure.

```golang
// client side
conn, err := net.Dial("tcp", "192.168.1.100:8080")
if err != nil {
	// handle error
}
fmt.Fprintf(conn, "GET / HTTP/1.0\r\n\r\n")
status, err := bufio.NewReader(conn).ReadString('\n')
// ...

// server side
// ln is of type TCPListener that contains local socket
// port 8080 is the service endpoint
ln, err := net.Listen("tcp", ":8080")
if err != nil {
	// handle error
}
for {
	// conn is of type net.TCPConn that implements
	// io.Reader and io.Writer
	// a new conn means a local socket is created
	conn, err := ln.Accept()
	if err != nil {
		// handle error
	}
	// open a new goroutine to handle this conn
	go handleConnection(conn)
}

// source code in package net
type TCPConn struct {
	conn
}
type conn struct {
	fd *netFD
}
// Network file descriptor.
type netFD struct {
	pfd poll.FD

	family      int
	sotype      int
	isConnected bool
	net         string
	laddr       Addr // local endpoint of the network
	raddr       Addr
}
type TCPListener struct {
	fd *netFD
	lc ListenConfig
}
```
