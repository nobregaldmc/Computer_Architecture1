section .data
    fmt_even db "par=%d", 10, 0
    fmt_odd db "impar=%d", 10, 0

section .bss
    a resd 1

section .text
    extern printf
    global _start

_start:
    ; Call par(4)
    mov eax, 4
    call par
    mov [a], eax

    ; Check if a == 0
    cmp eax, 0
    je .even

    ; Print odd case
    mov eax, [a]
    push eax
    push fmt_odd
    call printf
    add esp, 8
    jmp .end

.even:
    ; Print even case
    mov eax, [a]
    push eax
    push fmt_even
    call printf
    add esp, 8

.end:
    ; Exit the program
    mov eax, 1        ; syscall number for exit
    xor ebx, ebx      ; exit code 0
    int 0x80          ; make syscall to exit

par:
    ; int par(int x)
    ; return x % 2
    mov edx, 0
    mov ecx, 2
    div ecx
    mov eax, edx
    ret
