Protected Mode
==============

keyword:  
[Real Mode][RealMode], [Protected Mode][Protected Mode], 
[GDT][GDT] (Global Descriptor Table), 
[A20 line][whyA20line], 

code:  
[RealMode to ProtectedMode][rm2pm], 

Introduction
------------

**[Real Mode][RealMode]** is an operating mode of all x86-compatible CPUs.
It was first used for [intel 8086][Intel8086], which gave rise to the
x86 architecture.
8086 is 16-bit microprocessor, with 16-bit registers, 16-bit data bus
and 20-bit address bus. Real mode can access 1M memory space
using ***segment:offset*** method: segment * 16 + offset.

Real Mode is simple, but it has crons:

* can only access 1M memory space (20-bit address bus)
* 64K memory space for one segment (offset is 16-bit register)
* has no memory and hardware I/O protection
* single task
* if the running task crash, it can not restore

Thus we need to turn to protected mode.

**[Protected Mode][Protected Mode]**
is the main operating mode of modern Intel processors.
A CPU that is initialized by the BIOS starts in Real Mode.
When kernel loader is running, it will change from Real Mode
to Protected Mode.

Since [i386][i386], data width is 32bits, address width is 32 bits,
thus memory space is 4 Gigabytes.

To protect a specific memory segment, we can set some rules
in some place. [GDT][GDT] (Global Descriptor Table) does this work.
Each entry in GDT describes such rules.
When CPU tries to access a specific memory segment, it will check
corresponding descriptor entry to see if it is allowed.

GDT structure is defined in the specific CPU manual.
GDT should be created according to the manual and loaded in the memory, and
CPU can thus decode such rules when running a task.
The following is from [Intel 64 and IA-32 Architectures
Software Developer’s Manual][Intel Manual]:
  
When operating in protected mode, all memory accesses pass through
either the global descriptor table (GDT) or
an optional local descriptor table (LDT).
These tables contain entries called **segment descriptors**.
Segment descriptors provide the base address of segments well as access rights, type, and usage
information.

Each segment descriptor has an associated **segment selector**.
A segment selector provides the software that uses
it with an index into the GDT or LDT, a global/local flag (deter-
mines whether the selector points to the GDT or the LDT),
and access rights information.

Specifically,
To translate a logical address into a linear address,
the processor does the following:

1. Uses the offset in the segment selector to locate the segment descriptor
for the segment in the GDT or LDT and reads it into the processor.
(This step is needed only when a new segment selector is loaded into a segment
register.)
2. Examines the segment descriptor to check the access rights and
range of the segment to ensure that the
segment is accessible and that the offset is within the limits of the segment.
3. Adds the base address of the segment from the segment descriptor to the offset
to form a linear address.

Useful link about GDT:

[Switching to Protected Mode][Switching to Protected Mode], 
[GDT][GDT], [GDT Tutorial][GDT Tutorial],

Useful links:

[Why enable A20 line?][whyA20line]

[RealMode]: https://wiki.osdev.org/Real_Mode#Real_Mode_Memory_Addressing
[Protected Mode]: https://en.wikipedia.org/wiki/Protected_mode
[Intel8086]: https://en.wikipedia.org/wiki/Intel_8086
[whyA20line]: https://stackoverflow.com/questions/13893056/why-enable-disable-a20-line
[GDT]: https://wiki.osdev.org/Global_Descriptor_Table
[GDT Tutorial]: https://wiki.osdev.org/GDT_Tutorial
[Switching to Protected Mode]: https://huichen-cs.github.io/course/CISC3320/19FA/lecture/modeswitch.html
[Intel Manual]: https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-vol-3a-part-1-manual.html
[rm2pm]: https://github.com/hzget/os/blob/main/bare/main_pm.asm
[i386]: https://en.wikipedia.org/wiki/I386

