# A program

## What is a program

A program runs on a system and performs specific
tasks. The input is data flow from the network or
local database. The program handles the input data
with specific algorithms and produces the output.

## how to write a program

Take the C program as an example. The C program file
is written/read by a C programmer. It is a text
file with ".c" suffix. The file will finally be
transformed to an executable file which is a binary
file. The binary file contains machine code that
can be read by the system and runs on cpu.

## how to load a program

The C program can be run directly on the command line.

## under the hood

The ***.text*** and ***.data*** sections are loaded in
the User Process Memory Space. A ***PC*** pointer goes
through the ***.text*** segment, runs the command
it points to.

There're another two important segments on the
memory space: stack and heap. The stack segment
contains data of the call stack frames. Each
frame contains data of a function on the callback
stacks. For example, data of the local variables,
function arguments, which are saved in some
registers. The stack is constructed/destroyed
by the system automatically.

The heap segment contains data that are allocated
by the program explicitly. For example, by the
momory allocation functions: malloc, realloc and so on.

There may be memory leaks on the heap if the
program is not written well. And the stack segement
may go beyond its space if the callback stacks are very deep
and some stacks contains too much space.

Both the two segments can be injected illegal code
by virus.
