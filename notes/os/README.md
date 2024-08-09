Operation System
================

This tutorial intends to write an operating system from scratch
and demonstrates key points of each stage.
What's the difference from other tutorials of OS ?
***It is written from MY point of view***.

[Before Running OS][bare]
-------------------------

After POWERING ON the computer, the process is:

    BIOS --> MBR --> kernel loader --> kernel

BIOS will check hardware conditions, and then load MBR into memory,
run it.
MBR runs in REAL mode and loads the "kernel loader" into memory.
The "loader" switches to PROTECTED mode and loads kernel
into memory and run it. Now the Operating System (the kernel) is running.

[bare]: ./bare/bare.md
