Operation System
================

Before Running OS
-----------------

After POWERING ON the computer, the process is:

    BIOS --> MBR --> loader --> kernel

BIOS will check hardware conditions, and then load MBR into memory,
run it.
MBR runs in REAL mode and loads the "loader" into memory.
The "loader" switches to PROTECTED mode and loads kernel
into memory and run it.

I/O interfaces
--------------

CPU interacts with kinds of hardware devices via kinds of I/O interfaces.
There're 2 methods:

* "visits" device memory "directly" just as visiting memory in mother board
* interacts with registers inside I/O interface

visit device memory directly
----------------------------

The following code will write "2 MBR" into memory of display card
which will control the "display" to display it.

	mov ax, 0xb800
	mov gs, ax
	mov byte [gs:0x00], '2'
	mov byte [gs:0x01], 0xA4
	mov byte [gs:0x02], ' '
	mov byte [gs:0x03], 0xA4
	mov byte [gs:0x04], 'M'
	mov byte [gs:0x05], 0xA4
	mov byte [gs:0x06], 'B'
	mov byte [gs:0x07], 0xA4
	mov byte [gs:0x08], 'R'
	mov byte [gs:0x09], 0xA4

interacts with registers inside I/O interface
---------------------------------------------

The following code is excerpted from MBR. It just
loads data from 1st sector to memory 0x1000.

	mov edi, 0x1000; target memory location
	mov ecx, 0; starting sector
	mov bl, 1; num of sectors
	call read_disk
	xchg bx, bx

	; block here
	jmp $

	; 0x1F0: 16bits, read/write data
	; 0x1F1: check errors of previous command
	; 0x1F2: num of sectors
	; 0x1F3: starting sector location - 0 ~ 7 bits
	; 0x1F4: starting sector location - 8 ~ 15 bits
	; 0x1F5: starting sector location - 16 ~ 32 bits
	; 0x1F6: 
	;	0 ~ 3: starting sec location - 24 ~ 27 bits
	;	4: 0 main, 1 slave
	;	6: 0 CHS, 1 LBA
	;	5, 7: 1s fixed
	; 0x1F7: out
	;	0xEC: detect hardware
	;	0x20: read
	;	0x30: write
	; 0x1F7: in / 8bits
	;	0 ERR
	;	3 DRQ data is ready
	;	7 BSY busy

	read_disk:
		; num of sectors
		mov dx, 0x1f2
		mov al, bl
		out dx, al
		
		inc dx; 0x1f3
		mov al, cl
		out dx, al

		inc dx; 0x1f4
		shr ecx, 8
		mov al, cl
		out dx, al

		inc dx; 0x1f5
		shr ecx, 8
		mov al, cl
		out dx, al

		inc dx; 0x1f6
		shr ecx, 8
		and cl, 0b1111; retain lower 4 bits

		; main disk, LBA mode
		mov al, 0b1110_0000
		or al, cl
		out dx, al

		inc dx; 0x1f7
		mov al, 0x20; read disk
		out dx, al

		xor ecx, ecx
		mov cl, bl

		.read:
			push cx
			call .waits
			call .reads; read a sector
			pop cx
			loop .read

		ret

		.waits:
			mov dx, 0x1f7	
			.check:
				in al, dx
				jmp $+2; jump to next line (a delay just as nop)
				jmp $+2
				jmp $+2
				and al, 0b1000_1000
				cmp al, 0b0000_1000
				jnz .check
			ret

		.reads:
			mov dx, 0x1f0
			mov cx, 256; sec size = 256
			.readw:
				in ax, dx
				jmp $+2
				jmp $+2
				jmp $+2
				mov [edi], ax
				add edi, 2
				loop .readw
			ret
