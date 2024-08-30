Foreign Function Interface (FFI)
===

FFI enables programs written in one language to
leverage libraries and functions from another language.
For example, a Python program can call a C library to utilize
high-performance functions.

Common use cases for FFI include:

* Accessing system libraries or APIs.
* Reusing existing libraries written in other languages.
* Implementing performance-sensitive code in a lower-level language.

Further reading:

[Difference between FFI and ABI](./ffi_vs_abi.md)

Example: use c code from rust
---

Suppose we have a c code:

```c
// example.c
#include <stdio.h>

void hello_from_c() {
    printf("Hello from C!\n");
}

int add_numbers(int a, int b) {
    return a + b;
}
```

generate a shared library and install it to libs

```bash
gcc -shared -o example.dll example.c -Wl,--out-implib,example.lib
copy example.dll D:\proj\example.com\lib\
copy example.lib D:\proj\example.com\lib\
```

use this library in rust code:

```rust
// main.rs
use std::os::raw::{c_int};

// Declare the functions from the C library that we want to call.
// We use `extern "C"` to specify the C calling convention.
extern "C" {
    fn hello_from_c();
    fn add_numbers(a: c_int, b: c_int) -> c_int;
}

fn main() {
    unsafe {
        // Call the function that prints a message
        hello_from_c();

        // Call the function that adds two numbers
        let sum = add_numbers(5, 7);
        println!("The sum is: {}", sum);
    }
}
```

to build the rust code, generate a build script:

```rust
// build.rs

fn main() {
    println!("cargo:rustc-link-lib=dylib=example");
    println!("cargo:rustc-link-search=native=D://proj//example.com//lib");
}
```

build:

```bash
D:\proj\example.com\rust\hello>cargo build
   Compiling hello v0.1.0 (D:\proj\example.com\rust\hello)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 1.12s

D:\proj\example.com\rust\hello>
D:\proj\example.com\rust\hello>cargo run
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.06s
     Running `target\debug\hello.exe`
error: process didn't exit successfully: `target\debug\hello.exe` (exit code: 0xc0000135, STATUS_DLL_NOT_FOUND)
```

set the environment and run it again:

```bash
D:\proj\example.com\rust\hello>set PATH=D:\proj\example.com\lib;%PATH%

D:\proj\example.com\rust\hello>cargo run
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.06s
     Running `target\debug\hello.exe`
Hello from C!
The sum is: 12

D:\proj\example.com\rust\hello>
```

Example: use rust code from golang
---

suppose we generate a lib of "add":

```bash
cargo new add --lib
```

add code in the file:

```rust
// src/lib.rs
#[no_mangle]
pub extern "C" fn add(left: u32, right: u32) -> u32 {
    left + right
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = add(2, 2);
        assert_eq!(result, 4);
    }
}
```

**Note**:

* `#[no_mangle]`: This attribute tells the Rust compiler not to
mangle the function name, so it can be accessed by other languages like Go.
* extern "C": This specifies the C calling convention, which is needed for FFI.

set Cargo.toml files:

```rust
[lib]
crate-type = ["staticlib"] 
```

build the "add" lib and install it

```bash
D:\proj\example.com\rust\add>cargo build --release
   Compiling add v0.1.0 (D:\proj\example.com\rust\add)
    Finished `release` profile [optimized] target(s) in 0.16s

D:\proj\example.com\rust\add>copy target\release\add.lib D:\proj\example.com\lib\
```

write go code to use add.lib:

```golang
package main

/*
#cgo LDFLAGS: -LD:/proj/example.com/lib -ladd
#include <add.h>
*/
import "C"
import "fmt"

func main() {
    a := C.uint32_t(5)
    b := C.uint32_t(7)
    sum := C.add(a, b)
    fmt.Printf("The sum is: %d\n", sum)
}
```

add header file of add.h inside go workspace

```c
// add.h

#include <stdint.h>

int32_t add(uint32_t a, uint32_t b);
```

build an exe to run:

```bash
D:\proj\example.com\go\main>go build -o main.exe main.go

D:\proj\example.com\go\main>.\main.exe
The sum is: 12
```

***Note:*** to build such a "cgo" file, gcc shall be pre-installed.

```bash
D:\proj\example.com\go\main>gcc --version
gcc (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders) 12.2.0
Copyright (C) 2022 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

