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

