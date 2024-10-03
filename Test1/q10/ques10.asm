section .data
    fmt db '%d', 0
    msg_rep db 'REPROVADO!', 10, 0
    msg_apr db 'APROVADO!', 10, 0
    msg_int db 'Digite a media do final aluno: ', 10, 0
    msg_erro db 'Voce digitou numero invalido', 10, 0
    msg_fim db 'Fim do programa!', 10, 0

section .bss
    media resd 1

section .text
    extern printf, scanf
    global main

main:
    com_loop:
    push msg_int
    call printf
    add esp, 4

    push media
    push fmt
    call scanf
    add esp, 8

    mov eax, [media]

    cmp eax, 11
    jl next

    push msg_erro
    call printf
    add esp, 4
    jmp com_loop



next:
    cmp eax, -1
    je encerrar

    cmp eax, 7
    jl repr

    push msg_apr
    call printf
    add esp, 4
    jmp com_loop

rep:
    push msg_rep
    call printf
    add esp, 4
    jmp com_loop

finish:
    push msg_fim
    call printf
    add esp, 4
    
    xor ebx, ebx
    mov eax, 1
    int 0x80
