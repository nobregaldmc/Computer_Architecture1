section .data
    format db "soma eh:%d", 10, 0

section .bss
    soma resd 1

section .text
    extern printf
    global _start

_start:
    ; Prologue
    push ebp
    mov ebp, esp

    ; Call funcao(2, 3)
    push 3
    push 2
    call funcao
    add esp, 8

    ; Store result in soma
    mov [soma], eax

    ; Prepare arguments for printf
    push dword [soma]
    push format
    call printf
    add esp, 8

    ; Epilogue
    pop ebp

    ; Exit the program
    mov eax, 1        ; syscall number for exit
    xor ebx, ebx      ; exit code 0
    int 0x80          ; make syscall to exit

funcao:
    ; Prologue
    push ebp
    mov ebp, esp

    ; Get parameters
    mov eax, [ebp + 8]  ; x
    mov ebx, [ebp + 12] ; y

    ; Calculate a + b
    add eax, ebx

    ; Epilogue
    pop ebp
    ret
