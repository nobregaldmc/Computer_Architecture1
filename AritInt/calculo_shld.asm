global calculo_shld
extern printf

section .bss
    a_shld resd 1

section .data
    i      dd 0
    limite dd 3
    v_shld_eax  dd 0x00E0
    v_shld_ebx  dd 0x009D
    saida_ant_shld db "valor antigo shld: %d", 0AH, 0H
    saida_nov_shld db "valor novo shld 0x%08X: 0x%08X", 0AH, 0H

section .text

calculo_shld:
    ; Inicializa a_shld com o valor de v_shld_eax
    mov eax, [v_shld_eax]
    mov [a_shld], eax

    ; Imprime o valor antigo
    push dword [a_shld]
    push saida_ant_shld
    call printf
    add esp, 8

    ; Inicializa o índice para o loop
    mov ebx, [i]

laco_shld:
    cmp ebx, [limite]
    jae next_shld

    ; Incrementa o índice
    inc ebx

    ; Realiza o SHLD e atualiza o valor
    mov eax, [a_shld]
    mov ecx, 1  ; Número de bits a serem deslocados
    mov ebx, [v_shld_ebx]
    shld eax, ebx, cl
    mov [a_shld], eax

    ; Imprime o valor após o SHLD
    push dword [a_shld]
    push eax
    push dword [v_shld_eax]
    push saida_nov_shld
    call printf
    add esp, 16

    ; Repete o loop
    jmp laco_shld

next_shld:
    ret

