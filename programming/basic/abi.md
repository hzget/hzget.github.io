Application Binary Interface (ABI)
===

Application Binary Interface (ABI)
of a programming language defines how different program components
interact at the binary level. For the C programming language,
the ABI outlines ***the Conventions that must be followed*** so that
compiled code can interface with other compiled code or
with system-level functions.

Further reading:

[Difference between FFI and ABI](./ffi_vs_abi.md)

Key Components of C's ABI
---

1. Calling Conventions:
    * Function Call: The ABI defines how functions are called, including how arguments are passed (e.g., via registers or the stack), how the return value is passed back, and how the stack is managed.
    * Register Usage: Specifies which registers are used for argument passing, return values, and which are preserved across function calls (callee-saved vs. caller-saved registers).
2. Data Types and Memory Layout:
    * Size and Alignment: The ABI specifies the size and alignment requirements for basic data types (e.g., int, char, float, double), as well as for structs and unions.
    * Endianness: Defines the byte order used for storing data in memory (little-endian or big-endian).
3. Name Mangling:
    * Symbol Naming: The ABI defines how function names, variable names, and other symbols are represented in the compiled object files. C generally uses a simple name mangling scheme where the function names appear as-is (unlike C++, where name mangling is more complex due to overloading).
4. Struct and Union Layout:
    * The ABI specifies how the fields within a struct or union are laid out in memory, including any padding required for alignment purposes.

5. Calling Stack:
    * Stack Frame Layout: The ABI describes the layout of the stack frame during function calls, including where local variables, return addresses, and saved registers are stored.
    * Stack Growth Direction: Specifies whether the stack grows towards higher or lower memory addresses.
6. Linkage:
    * Static vs. Dynamic: The ABI also defines how functions and variables are linked at the binary level, distinguishing between statically linked symbols (resolved at compile time) and dynamically linked symbols (resolved at runtime).
7. System Calls and Interrupt Handling:
    * The ABI might define conventions for making system calls to the operating system or for handling interrupts, particularly in lower-level programming or embedded systems.

Platform-Specific ABIs
---

* System V ABI: Commonly used on Unix-like systems (e.g., Linux). It is one of the most widely used ABIs for C on platforms like x86 and x86_64.
* Windows ABI: Windows uses a different set of conventions, such as the Microsoft x64 calling convention for 64-bit code.
* ARM ABI: ARM processors have their own ABI, which is used for systems running on ARM architecture, including mobile devices.

Importance of ABI
---

* Interoperability: ABIs ensure that code compiled by different compilers can work together, as long as they adhere to the same ABI. This is crucial for linking third-party libraries, system libraries, and even for cross-language interoperability.
* Portability: An understanding of the ABI is essential when writing code that needs to be portable across different platforms or when working with low-level system programming.
* Binary Compatibility: ABI stability is crucial for ensuring that binary software remains compatible across different versions of compilers and libraries. If the ABI changes, recompilation of dependent code is usually necessary.

Summary
---

The C programming language's ABI defines the low-level details of how compiled C code interacts at the binary level with other code and the operating system. It covers aspects like function calling conventions, data type representation, memory layout, and linkage, ensuring that code can be linked and executed correctly across different compilers and environments. Understanding the ABI is crucial for low-level programming, system programming, and ensuring binary compatibility across software components.
