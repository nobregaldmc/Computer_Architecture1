section .data
    hello db 'Hello, World!', 0

section .text
    global _start

_start:
    ; escrever a mensagem
    mov rax, 1          ; número da syscall (sys_write)
    mov rdi, 1          ; file descriptor (stdout)
    mov rsi, hello      ; ponteiro para a mensagem
    mov rdx, 13         ; tamanho da mensagem
    syscall             ; chamada de sistema

    ; sair do programa
    mov rax, 60         ; número da syscall (sys_exit)
    xor rdi, rdi        ; código de saída (0)
    syscall             ; chamada de sistema

