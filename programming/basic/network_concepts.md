# Network Concepts

## Socket

A tcp socket, consisting of an IP address and a port,
is an ***endpoint instance*** in the context of either
a specific tcp connection or a listenning state.
A tcp connection is identified by two endpoint: local endpoint
and remote endpoint. Thus a tcp socket is not a connection,
but an endpoint of a connection.

A server process creates a socket on startup that are in the
listening state, waiting for initiatives from client programs.
Once a connection is established, a new socket (the conn's local
endpoint) exists and it provides a duplex byte stream
whereby the process can read and write byte data from and to
the peer.

The server process can serve multiple clients concurrently via
maintaining each connection in a single thread. However, the
cost of context switching (of threads) is high, thus the
multi-threads method is not applicable when there're many clients.
The issue is addressed by the I/O multiplexing technique.

Here's an example of tcp programming in golang. The socket details
are hidden.

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
// Listen announces on the local network address.
// ln is of type TCPListener
ln, err := net.Listen("tcp", ":8080")
if err != nil {
	// handle error
}
for {
    // conn is of type net.TCPConn that implements
    // io.Reader and io.Writer
	conn, err := ln.Accept()
	if err != nil {
		// handle error
	}
	// open a new goroutine to handle the conn
	go handleConnection(conn)
}

// source code in package net
// TCPConn is an implementation of the Conn interface for TCP network
// connections.
type TCPConn struct {
	conn
}
type conn struct {
	fd *netFD
}
// Network file descriptor.
type netFD struct {
	pfd poll.FD

	// immutable until Close
	family      int
	sotype      int
	isConnected bool // handshake completed or use of association with peer
	net         string
	laddr       Addr
	raddr       Addr
}
// TCPListener is a TCP network listener. Clients should typically
// use variables of type Listener instead of assuming TCP.
type TCPListener struct {
	fd *netFD
	lc ListenConfig
}
```
