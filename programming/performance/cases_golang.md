# Cases of Benchmark Testing

## cases from golang

golang std pkg log:

* commit [c3b4c27](https://cs.opensource.google/go/go/+/c3b4c27fd31b51226274a0c038e9c10a65f11657):
reduce lock contention by
using atomics so that the header formatting
can be moved out of the critical lock section.
```txt
Performance:  
	name           old time/op  new time/op  delta
	Concurrent-24  19.9µs ± 2%   8.3µs ± 1%  -58.37%  (p=0.000 n=10+10)
```
* commit [2da8a55](https://cs.opensource.google/go/go/+/2da8a55584aa65ce1b67431bb8ecebf66229d462):
reduce allocation by replacing fmt.Sprintf by fmt.Appendf
```txt
Performance:
	name               old time/op    new time/op    delta
	Println            188ns ± 2%     172ns ± 4%    -8.39%  (p=0.000 n=10+10)
	PrintlnNoFlags     139ns ± 1%     116ns ± 1%   -16.71%  (p=0.000 n=9+9)

	name               old allocs/op  new allocs/op  delta
	Println             1.00 ± 0%      0.00       -100.00%  (p=0.000 n=10+10)
	PrintlnNoFlags      1.00 ± 0%      0.00       -100.00%  (p=0.000 n=10+10)
```

