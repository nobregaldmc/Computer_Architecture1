section .data
    hello db 'Hello, World!', 0

section .text
    global _start

_start:
    ; escrever a mensagem
    mov edx, 13           ; tamanho da mensagem
    mov ecx, hello        ; ponteiro para a mensagem
    mov ebx, 1            ; file descriptor (stdout)
    mov eax, 4            ; número da syscall (sys_write)
    int 0x80              ; chamada de sistema

    ; sair do programa
    mov eax, 1            ; número da syscall (sys_exit)
    xor ebx, ebx          ; código de saída (0)
    int 0x80              ; chamada de sistema

