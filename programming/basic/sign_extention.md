Sign Extension
===

From [Golang Specification][golang spec],

> When converting between integer types, if the valueis a
> signed integer, it is sign extended to implicit infinite precision;
> otherwise it is zero extended. It is then truncated to fit in the result type's size.
>
> The conversion always yields a valid value; there is no indication of overflow.

In the following example, integers are
shown in the human-readable origin code in the source text.
But they are stored as two's complement code in the
underlying memory. CPU will only calculate that code.

```golang
// Suppose the CPU is 32-bits width, 
// list the 2's complement code:
g := int16(0xff)
// extend the sign:       00 ff --> 00 00 00 ff
// truncate:        00 00 00 ff --> 00 ff
h := int8(g)
// extend the sign:       00 ff --> 00 00 00 ff
// truncate:        00 00 00 ff --> ff
i := int16(h)
// extend the sign:          ff --> ff ff ff ff
// truncate:        ff ff ff ff --> ff ff
j := uint16(h)
// extend the sign:          ff --> ff ff ff ff
// truncate:        ff ff ff ff --> ff ff
k := uint16(g)
// extend the sign:       00 ff --> 00 00 00 ff
// truncate:        00 00 00 ff --> 00 ff
fmt.Println(j==k, g==i, g>0, h>0, i>0)
fmt.Printf("0x%X, 0x%X, 0x%X, 0x%X, 0x%X\n", g, h, i, j, k)
// Output:
//     false false true false false
//     0xFF, 0x-1, 0x-1, 0xFFFF, 0xFF

l := int8(0xff)
// Compiler Error:
//    cannot convert 0xff (untyped int constant 255) to type int8
if h == 0xff {}
// Compilier Error:
//    0xff (untyped int constant 255) overflows int8

l := uint8(i)    //       ff ff --> ff ff ff ff --> ff
m := uint16(i)   //       ff ff --> ff ff ff ff --> ff ff
n := int16(l)
// zero extended:            ff --> 00 00 00 ff
// truncate:        00 00 00 ff --> 00 ff
o := int8(m)
// zero extended:         ff ff --> 00 00 ff ff
// truncate:        00 00 ff ff --> ff
fmt.Printf("0x%X, 0x%X, 0x%X, 0x%X\n", l, m, n, o)
fmt.Println(l, m, n, o)
// Output:
//      0xFF, 0xFFFF, 0xFF, 0x-1
//      255 65535 255 -1
```

[golang spec]: https://golang.google.cn/ref/spec#Conversions
