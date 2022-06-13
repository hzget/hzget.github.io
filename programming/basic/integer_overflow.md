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

As we know, the human-readable 2-bits representation of the integer 1 and -1:

* 1:  0000 0001
* -1: 1000 0001

Add them together:

```golang
1 + (-1) => 0000 0001 + 1000 0001 => 1000 0001
```

The result is not 0. Why?

In fact, the computer takes corresponding
complement code for Arithmetic operation.

Suppose the complement code of positive integer does not change,
to get the rule of complement code of negative integers, consider the following:

```golang
to make the following work:

1 + (-1) = 0 ==> 0000 0001 + ???? ???? = 0000 0000
2 + (-2) = 0 ==> 0000 0010 + ???? ???? = 0000 0000
3 + (-3) = 0 ==> 0000 0011 + ???? ???? = 0000 0000

we get the complement code:

-1 : 1111 1110
-2 : 1111 1101
-3 : 1111 1100

Find the pattern (take -1 as an example) of origin code to complement code:

from negative integer:     -1
==> 2-bits representation: 1000 0001
==> absolute value:        0000 0001
==> one-complement:        1111 1110
==> add one:               1111 1111  -- the complement code

Thus we can get rule of the opposite side (take 1000 0001 as an example):

from complement code:    1000 0001
==> abstract 1:          1000 0000
==> one-complment:       0111 1111
==> change sign:         1111 1111    -- 2-bits representation
==> negative integer:    -127

```

There's a clockface for the integer arithmetic operation
(with complement code as the rule):

![integer clockface][integer_clockface]

Here're related video (the above picture is from the latter video):

[Complement Code][Complement Code],
[Interger Oveflow][integer overflow]

After learning the above videos, can you explain
the phenomenon of the integer overflow?

```golang
var d, e, f int8 = 0x1, 0x2, 0x7f
fmt.Println(d, e, f, d-e, d+f, e+f)
// Output:
//    1 2 127 -1 -128 -127
```

[unsigned integer overflow]: https://www.bilibili.com/video/BV1kA4y1Z77h?spm_id_from=333.999.0.0&vd_source=db99336273bc60b960a922e981c6b9d0
[Complement Code]: https://www.bilibili.com/video/BV16U4y1t7LD?spm_id_from=333.999.0.0&vd_source=db99336273bc60b960a922e981c6b9d0
[integer overflow]: https://www.bilibili.com/video/BV1P541197N2?spm_id_from=333.999.0.0&vd_source=db99336273bc60b960a922e981c6b9d0
[integer_clockface]: ../../pics/programming/integerclockface.png
