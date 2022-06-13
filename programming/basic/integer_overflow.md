# Integer Overflow

## Unsigned Integer Overflow

For an unsigned integer with 8-bits width, it
ranges from 0 to 255. Consider the following
code (via golang) and its output:

```golang
var a, b, c uint8 = 0x1, 0x2, 0xff
fmt.Println(a, b, c, a-b, a+c, b+c)
// Output:
//    1 2 255 255 0 1
```

What happened with the Arithmetic operation?
Why `1-2 == 255`?

We can observe similar things when watching the time.
There're 24 hours in two rounds in the clockface (in a day).
Suppose it's at one o'clock in the morning now.
Here're the questions:

* what's the time 2 hours earlier? --- at 23 o'clock yesterday
* what's the time 23 hours later?  --- at 0 o'clock tomorrow

You see, `1-2 == 23` and `1+23 == 0`. It can explain
the phenomenon of unsigned integer overflow.

Here's a video of [unsigned integer overflow][unsigned integer overflow].

## Complement Code & Integer Overflow

Before we discuss the integer overflow, we need to think about
the concept of ***Complement Code***.

As we know, the 2-bits representation of the integer 1 and -1:

* 1:  0000 0001
* -1: 1000 0001

Add them together:

```golang
1 + (-1) => 0000 0001 + 1000 0001 => 1000 0001
```

The result is not 0. Why?

In fact, the computer takes corresponding
complement code for Arithmetic operation.

Here're related video:

[Complement Code][Complement Code],
[Interger Oveflow][integer overflow]

After learning the above videos, can you explain
the phenomenon of the following code?

```golang
var d, e, f int8 = 0x1, 0x2, 0x7f
fmt.Println(d, e, f, d-e, d+f, e+f)
// Output:
//    1 2 127 -1 -128 -127
```

[unsigned integer overflow]: https://www.bilibili.com/video/BV1kA4y1Z77h?spm_id_from=333.999.0.0&vd_source=db99336273bc60b960a922e981c6b9d0
[Complement Code]: https://www.bilibili.com/video/BV16U4y1t7LD?spm_id_from=333.999.0.0&vd_source=db99336273bc60b960a922e981c6b9d0
[integer overflow]: https://www.bilibili.com/video/BV1P541197N2?spm_id_from=333.999.0.0&vd_source=db99336273bc60b960a922e981c6b9d0
