FFI VS ABI
===

FFI (Foreign Function Interface) and ABI (Application Binary Interface) are related concepts in programming, but they serve different purposes and operate at different levels of abstraction. Here's how they differ:

Foreign Function Interface (FFI)
---

* Purpose: FFI is a mechanism that allows code written in one programming language to call functions or use services written in another language. It acts as a bridge between different programming languages, enabling them to work together within the same program or system.

* Role: FFI abstracts away the details of cross-language calls. It typically involves specifying how functions and data types in one language can be used from another language. For example, Rust has an FFI to interact with C libraries.

* Usage: FFI is used in scenarios where you want to leverage existing libraries or systems that are written in another language. For example, you might use Rust's FFI to call C functions, or Python's FFI to interact with C extensions.

* Example: In Rust, you declare an external function with FFI as follows:

```rust
extern "C" {
    fn c_function(arg: i32) -> i32;
}
```

Here, extern "C" specifies the use of C's calling convention, enabling Rust to call a function defined in C.

Application Binary Interface (ABI)
---

* Purpose: ABI defines the low-level details that govern how binary code interacts at the system level, including function calling conventions, data type sizes, memory alignment, and register usage. ABIs ensure that compiled code from different sources (like different compilers or different languages) can work together correctly when linked or executed together.

* Role: The ABI is more about the rules that allow binaries to work together at a very low level. It covers how functions are called, how parameters are passed, how the stack is managed, how data types are represented in memory, and how symbols are named and resolved.

* Usage: ABIs are crucial when you need to ensure that code compiled by different compilers or in different languages can link together and run correctly. They are also important in system-level programming, such as writing operating systems or low-level libraries.

* Example: The System V ABI is a common ABI used on Unix-like systems for the x86-64 architecture. It specifies, among other things, that the first integer arguments to a function are passed in specific registers (e.g., %rdi, %rsi for x86-64).

Key Differences
---

* Abstraction Level:

    * FFI: Operates at a higher level, focusing on how to interface between different languages at the source code level.
    * ABI: Operates at a lower level, focusing on the binary and runtime details that allow compiled code to interact correctly.

* Scope:

    * FFI: Used by developers to create bindings between different languages, such as calling C functions from Rust or Python.
    * ABI: Defines the rules for binary compatibility, ensuring that different compiled binaries (potentially from different languages) can work together.

* Interdependency:

    * FFI often relies on a consistent ABI to ensure that calls between languages behave correctly at the binary level.
    * The ABI defines how functions are called and data is represented, which the FFI must adhere to for correct interoperation.

Summary
---

* FFI is about enabling code from one language to call code in another language, abstracting the complexities of cross-language interactions.
* ABI is about ensuring binary compatibility, defining the low-level rules that allow compiled code from potentially different environments to work together at runtime.

FFI uses the ABI to ensure that cross-language calls work correctly at the binary level, making both concepts essential for language interoperability and system programming.
