# Garbage Collection

In the garbage-collected world, we want to
keep the GC overhead as little as possible.
One of the things we can do is limiting
the number of allocations in our application.

***[sync.Pool][sync.Pool]***
caches allocated but unused items for later reuse,
relieving pressure on the garbage collector.
The real power of it is visible when there're
frequent allocations and deallocations of
the same data structure
(especially when the structure object is expensive to create).

The article [Using Sync.Pool][Using Sync.Pool] gives
a clear explanation of the power of the pool.

***[Bigcache][Bigcache]*** gives another solution:
just omit the garbage collection.
In Go, if you have a map, garbage collector will
touch every single item of that map during mark and scan phase.
This can cause a huge impact on the application performance
when the map is large enough (contains millions of objects).

BigCache keeps entries on heap but omits GC for them.
To achieve that, operations on byte slices take place,
therefore entries (de)serialization in front of the cache
will be needed in most use cases.

Specifically, for the key-value pair, just hash the key to
an index of a hash table. Store the entry on an array.

[sync.Pool]: https://pkg.go.dev/sync#Pool
[Using Sync.Pool]: https://developer20.com/using-sync-pool/
[Bigcache]: https://github.com/allegro/bigcache
