section .data
    msg_instrucoes db "Digite o preco do produto: ", 0
    format_scan db "%d", 0            ; Formato para scanf
    format_printf db "%s", 10, 0      ; Formato para printf com nova linha
    msg_barato db "Barato", 0
    msg_normal db "Normal", 0
    msg_caro db "Caro", 0
    msg_muito_caro db "Muito Caro", 0

section .bss
    preco resd 1       ; Reserva espaço para um inteiro (4 bytes)

section .text
    extern printf, scanf
    global main        ; Define o ponto de entrada para main

main:
    ; Solicita o preço do produto
    push msg_instrucoes    ; Argumento para printf
    call printf            ; Chama printf
    add esp, 4             ; Ajusta a pilha

    ; Lê o preço usando scanf
    push preco             ; Endereço de destino para o preço
    push format_scan       ; Formato para scanf
    call scanf             ; Chama scanf
    add esp, 8             ; Ajusta a pilha

    ; Carrega o preço lido
    mov eax, [preco]       ; Carrega o valor lido em EAX

    ; Avalia o preço de acordo com a tabela
    cmp eax, 80
    jle barato             ; Se o preço for <= 80, é barato

    cmp eax, 120
    jle normal             ; Se o preço for <= 120, é normal

    cmp eax, 200
    jle caro               ; Se o preço for <= 200, é caro

    jmp muito_caro         ; Se o preço for > 200, é muito caro

barato:
    ; Exibe "Barato"
    push msg_barato        ; Argumento para printf
    push format_printf     ; Formato para printf
    call printf            ; Chama printf
    add esp, 8             ; Ajusta a pilha
    jmp fim

normal:
    ; Exibe "Normal"
    push msg_normal
    push format_printf
    call printf
    add esp, 8
    jmp fim

caro:
    ; Exibe "Caro"
    push msg_caro
    push format_printf
    call printf
    add esp, 8
    jmp fim

muito_caro:
    ; Exibe "Muito Caro"
    push msg_muito_caro
    push format_printf
    call printf
    add esp, 8

fim:
    ; Retorna de main
    ret

