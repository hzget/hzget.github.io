[org 0x7c00]

; set screen mode to text mode and clear screen
mov ax, 3
int 0x10

; init sec registers
mov ax, 0
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00

; 0xb800 -- memory
mov ax, 0xb800
mov ds, ax
mov byte [0], 'H'

; block here
jmp $

; fill in with 0s
times 510 - ($-$$) db 0

; last two bytes
db 0x55, 0xaa
