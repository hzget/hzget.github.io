Unicode
===

[Unicode][wikipedia] is a universal character encoding standard
that ***assigns a Unique Code to every Character or Symbol***,
regardless of the platform, program, or language.
This system allows computers to consistently represent and manipulate
text from any writing system, including alphabets, ideograms,
symbols, and more.

Unicode Representation
---

* Code Points: Unicode characters are represented by code points,
which are written in the form U+XXXX (e.g., U+0041 for the character 'A').
* Encodings: Unicode can be encoded in different formats,
such as UTF-8, UTF-16, and UTF-32.
[UTF-8][wikipedia utf-8] is the most widely used
encoding, especially on the web, because it is efficient and
backward-compatible with ASCII.

Range
---

***code space:*** U+0000 to U+10FFFF (range from 0 to 1,114,111)  
***valid code point:*** U+0000 to U+D7FF and U+E000 to U+10FFFF
(total 1,112,064)


**Breakdown:**

1. Basic Multilingual Plane (BMP):
    * Range: U+0000 to U+FFFF
    * Contains most of the commonly used characters, including those for Latin, Greek, Cyrillic, Chinese, and more.
    * This plane includes the first 65,536 code points.
2. Supplementary Planes:
    * Range: U+010000 to U+10FFFF
    * These planes include additional characters, such as historical scripts, musical notation, emojis, and other symbols.
    * There are 16 supplementary planes, each with 65,536 code points.
3. Exclusions:
    * Surrogate Pairs: The code points in the range U+D800 to U+DFFF are reserved for use in UTF-16 encoding as surrogate pairs and do not represent valid characters by themselves. These 2,048 code points are specifically excluded from being valid Unicode scalar values.
4. Summary of Valid Ranges:
    * Valid Unicode Code Points: U+0000 to U+D7FF and U+E000 to U+10FFFF
    * Invalid (Surrogate Range): U+D800 to U+DFFF (reserved for UTF-16 surrogate pairs)

This makes the total number of valid Unicode scalar values 1,112,064.

[grapheme cluster](./grapheme_cluster.md)
---

A grapheme cluster is a concept used in Unicode to represent what a user perceives as a single character, even though it might be composed of multiple Unicode code points. In simpler terms, it’s the smallest unit of a writing system that represents a single, visible character to the end user.

Unicode in golang
---

In Go (Golang),
a [rune literal][go rune literal] represents an integer value
identifying a Unicode code point. For example:

```bash
'a'    U+0061
'你'   U+4F60  
'\n'   U+000A line feed or newline
```

The `rune` type is an alias for `int32`.
It can hold any valid unicode code point as well as
non-unicode values.

Go enforces that [string literals][go string literal]
consist of valid UTF-8 sequences. If you try to include
an invalid UTF-8 sequence in a string literal,
the Go compiler will produce an error.

A `string` type represents the set of string values.
A string value is a (possibly empty) ***sequence of bytes***. 
(`[]byte`, an alias for `[]uint8`).
It means a string value may contain invalid UTF-8 sequence.

The user shall use go std pkg [unicode/utf8][go pkg utf8]
to verify valid text encoded in UTF-8. For example,

```golang
package main

import (
	"fmt"
	"unicode/utf8"
)

func main() {
	valid := "Hello, 世界"
	invalid := string([]byte{0xff, 0xfe, 0xfd})

	fmt.Println(utf8.ValidString(valid))
	fmt.Println(utf8.ValidString(invalid))
}

// Output:

true
false
```

Unicode in C language
---

In C, there isn't a specific built-in type dedicated exclusively to Unicode code points, but there are a few types commonly used to represent them. These include:

* `char32_t`: An unsigned 32-bit integer specifically designed for Unicode code points, making it ideal for character data. Its usage makes the intent of handling characters clear.
    * C11 standard
    * range 0x00000000 to 0xFFFFFFFF
* `int32_t`: A signed 32-bit integer used for general-purpose integer arithmetic, not specifically tied to character data. It can store Unicode code points but doesn't communicate that purpose as clearly as `char32_t`.
    * C99 standard
    * range 0x80000000 to 0x7FFFFFFF

Unicode in Rust
---

The ***string slice*** [str][rust str],
usually seen in its borrowed form `&str`,
is a reference to some UTF-8 encoded string data stored elsewhere.
It's the only one string type in the core language.

The [String][rust String] type is a growable, mutable, owned, UTF-8 encoded
string type. It is provided by Rust’s standard library rather than
coded into the core language.

Both String and string slices are UTF-8 encoded.

```rust
let s = String::from("hello world");

let hello: &str = &s[0..5];
let world: &str = &s[6..11];
```

The [char][rust char] type represents a single character,
a ***Unicode scalar value***.
If you try to create a char from an invalid code point
(such as a surrogate), Rust will not allow it, and you would
typically get a compile-time error or runtime panic depending on
how you're attempting to create the char.

```rust
fn main() {
    // 0xD7FF is a Unicode scalar value
    // 0xD800 is a surrogate code point

    let _a: char = '\u{D7FF}';
    let _b: char = '\u{D800}'; // fail to compile

    let _c = char::from_u32(0xD7FF).unwrap();
    let _d = char::from_u32(0xD800).unwrap(); // panic: called `Option::unwrap()` on a `None` value
}
```

[wikipedia]: https://en.wikipedia.org/wiki/Unicode
[wikipedia utf-8]: https://en.wikipedia.org/wiki/UTF-8#Encoding
[go rune literal]: https://golang.google.cn/ref/spec#Rune_literals
[go string literal]: https://golang.google.cn/ref/spec#String_literals
[go pkg utf8]: https://pkg.go.dev/unicode/utf8
[rust str]: https://doc.rust-lang.org/core/primitive.str.html
[rust String]: https://doc.rust-lang.org/std/string/struct.String.html
[rust char]: https://doc.rust-lang.org/core/primitive.char.html
