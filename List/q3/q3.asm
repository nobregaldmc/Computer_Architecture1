section .data
    format db "A soma eh: %d", 10, 0

section .bss
    a resd 1
    b resd 1
    soma resd 1

section .text
    extern printf
    global _start

funcao:
    ; Initialize variables
    mov dword [a], 5
    mov dword [b], 2
    ; Calculate sum
    mov eax, [a]
    add eax, [b]
    mov [soma], eax
    ; Print result
    push dword [soma]
    push format
    call printf
    add esp, 8
    ret

_start:
    call funcao
    ; Exit the program
    mov eax, 1        ; syscall number for exit
    xor ebx, ebx      ; exit code 0
    int 0x80          ; make syscall to exit

