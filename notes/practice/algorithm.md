# Data structures and Algorithms

Well-designed data structures and algorithms help to
improve the performance of a program. For example,
fast and stable computing, simple and compatible interface,
easy maintenace, scalability and so on.

Every program depends on data structures and algorithms,
but few programs depend on the invention of brand new ones.
Even within an intricate program like a complier or
a web browser, most data structures are arrays, lists,
trees and hash tables. When a program needs something
more elaborate, it will likely be based on these simpler ones.

There're only a handful of basic algorithms that show up in almost
every program --- primarily searching and sorting --- and even
those are often included in libraries.

We need to be familier with these basic structures and algorithms
so that we can choose the appropriate ones in our programs.

* data structures: arrays, lists, trees, hash tables
* algorithms: searching and sorting

## Arrays

Arrays are unbeatable for fix-sized data set or for guaranteed
small collection of data. Arrays have following
properties:

* easy to use
* provide O(1) random access
* work well with binary search and quick sort
* have little space overhead

For example, an event-driven program will trigger correspoding
handlers for each incoming event, with event types being in a known
continuous range of integers. Storing these correspondences
in an array, we can get O(1) access of handler for any event type.

However, the operations such as adding or deleting items in the middle
of an array are inefficent, and we need the ***lists*** structure for that.

## Lists

If the set of items will change frequently, particularly if
the number of items is unpredictable, a list is the way to store
them; by comparison, an array is better for relatively static data.

A list has the following properties:

* easy to use
* takes O(n) times to search for a specific item
* per-item storage overhead to hold pointers
* when items are inserted or deleted, other items aren't moved
* lists can be rearranged by exchanging a few pointers
* suitable for constructing stacks or queues

## Arrays and Lists

Both the array and list structure are sequential struture
in that we can traverse the data set from head to tail in sequential.
We can also call it a linear struture in that, for some operations,
the run-time is a linear function of data size.

For example, the insertion operation in the middle of an array
need O(n) times movements of items in the array. An item search for
the list needs O(n) times comparisons.

To combine ***frequent update*** with ***random access***, however,
it would be wiser to use a less insistently linear data structure,
such as a tree or hash table.

## Hash Tables

When used properly, a hash table has O(1)-time
lookup, insertion and deletion operations,
which are unmatched by other techniques.

A hash table is an unordered collection of key-value pairs,
where each key is unique.
The idea is to ***hash*** a KEY to a VALUE, the index
of an array with each element being a list that chains together
the items that share a hash value.
Along the list, we can lookup/add/delete a specific item.
Just like the following (from wikipedia [hash table](https://en.wikipedia.org/wiki/Hash_table) ):

![hash table](../../pics/programming/Hash_collision_resolved_by_separate_chaining.png)

A hash table of n items is an array of lists whose
average length is "n / (size of array)". Thus retrieving
an item is an O(1) operation. The key point is

* all hashed values shall be evenly distributed along the array
* the array size is "modest"

On the contrary, if the hash function is poor
or the table size is too small, one or more lists
can grow very long. And that leads to O(n) behavior for operations.

Hash tables also have limitations. It's elements are
not directly ordered.

Applicatons:

The [map type][golang map] in golang is [implemented][golang map implementation]
by a hash table. We can access a specific item
by ***indexing*** the map object:

```golang
type Vertex struct {
	Lat, Long float64
}

var m = map[string]Vertex{
	"Bell Labs": {40.68433, -74.39967},
	"Google":    {37.42202, -122.08408},
}

func main() {
	fmt.Println(m["Google"])
}
```

Another example is the golang [net/http][golang net/http] package, which registers
routers via the map structure `map[string]muxEntry`.

```golang
	http.HandleFunc("/", func1)
	http.HandleFunc("/endpoint", func2)
```

[golang map]: https://golang.google.cn/ref/spec#Map_types
[golang map implementation]: https://go.dev/src/runtime/map.go
[golang net/http]: https://pkg.go.dev/net/http
