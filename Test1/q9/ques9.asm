extern printf

section .data
    format db "Aluno Aprovado", 0xa, 0
    format2 db "Aluno em Avaliação Final", 0xa, 0
    format3 db "Aluno Reprovado", 0xa, 0

    ; notas fixas
    note1 db 5
    note2 db 6
    note3 db 8

section .bss
    media resd 1

section .text
    global main

main:
    ; notas em registradores
    movzx eax, byte [note1]  ; primeira nota
    movzx ebx, byte [note2]  ; segunda nota
    movzx ecx, byte [note3]  ; terceira nota

    ; Calcular a média ponderada
    imul eax, 1              ; Nota 1 * Peso 1
    imul ebx, 2              ; Nota 2 * Peso 2
    add eax, ebx             ; Somar Nota 1 * Peso 1 + Nota 2 * Peso 2
    imul ecx, 3              ; Nota 3 * Peso 3
    add eax, ecx             ; Somar Nota 3 * Peso 3
    mov ebx, 6               ; Divisor (Peso total)
    xor edx, edx             ; Limpar EDX
    div ebx                  ; Dividir
    mov [media], eax         ; Armazenar a média calculada

    ; situação do aluno
    cmp dword [media], 7
    jge aprovado
    cmp dword [media], 4
    jge avaliacao
    jmp reprovado

reprovado:
    push format3

avaliacao:
    push format2
    jmp imprimir_resultado

aprovado:
    push format
    jmp imprimir_resultado

imprimir_resultado:
    call printf
    add esp, 8

    ; Encerrar
    mov eax, 1     
    xor ebx, ebx    ; status 0
    int 0x80
