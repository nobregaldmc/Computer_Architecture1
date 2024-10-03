section .data
    out_fmt db "O número %d é %s.", 10, 0   ; saída para printf
    msg_par db "par", 0
    msg_impar db "ímpar", 0
    num dd 6  ; Número constante

section .text
    extern printf
    global main

main:
    ; Carregar o número constante
    mov eax, [num]

    ; Verificar se é par ou ímpar
    test eax, 1          ; Verifica o bit menos significativo
    jz is_even           ; zero -> é par

    ; Se ímpar
    push msg_impar       ; Mensagem ímpar
    push eax             ; Número
    push out_fmt         ; Formato
    call printf
    add esp, 12
    jmp done

is_even:
    ; Se par
    push msg_par         ; Mensagem par
    push eax             ; Número
    push out_fmt         ; Formato
    call printf
    add esp, 12

done:
    mov eax, 1             ; syscall número para sys_exit
    xor ebx, ebx           ; status de saída 0
    int 0x80               ; invoca a syscall
