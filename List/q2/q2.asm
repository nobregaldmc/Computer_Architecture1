section .data
    format db "soma eh:%d", 10, 0

section .bss
    soma resd 1

section .text
    extern printf
    global _start

_start:
    ; Call funcao(2)
    mov eax, 2
    call funcao

    ; Store the result in soma
    mov [soma], eax

    ; Prepare arguments for printf
    push dword [soma]
    push format
    call printf
    add esp, 8

    ; Exit the program
    mov eax, 1        ; syscall number for exit
    xor ebx, ebx      ; exit code 0
    int 0x80          ; make syscall to exit

funcao:
    ; Function prologue
    push ebp
    mov ebp, esp

    ; Local variables
    mov dword [ebp-4], 5  ; a = 5
    mov dword [ebp-8], eax ; b = x

    ; Calculate a + b
    mov eax, [ebp-4]
    add eax, [ebp-8]

    ; Function epilogue
    pop ebp
    ret
