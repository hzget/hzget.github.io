Allocation Overhead
===================

In the garbage-collected world, we want to
keep the GC overhead as little as possible.
One of the things we can do is limiting
the number of allocations in our application.

sync.Pool
---------

***[sync.Pool][sync.Pool]***
caches allocated but unused items for later reuse.
It has following advantages.

* relieve pressure on the garbage collector
* amortize allocation overhead across many clients

The real power of it is visible when there're
frequent allocations and deallocations of
the same data structure
(especially when the structure object is expensive to create).

The article [Using Sync.Pool][Using Sync.Pool] gives
a clear explanation of the power of the pool.

Examples:

Standard Package [log][log] use a buffer to assemble
a logged message for each "print" function. And 
[c3b4c27][log c3b4c27] introduce sync.Pool to
relieve pressure on GC.
This approach is identical to how fmt does.

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
[log c3b4c27]: https://cs.opensource.google/go/go/+/c3b4c27fd31b51226274a0c038e9c10a65f11657
[log]: https://pkg.go.dev/log@go1.21.5

