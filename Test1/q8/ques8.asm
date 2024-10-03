section .data
    format db "Segundo menor: %d", 10, "Segundo maior: %d", 10, 0
    nums dd 1, 8, 13, 11, 12, 4, 7, 9, 2, 6  ; Vetor com 10 valores

section .bss
    second_min resd 1
    second_max resd 1

section .text
    extern printf
    global main

main:
    ; Inicia
    mov ecx, 0               ; loop
    mov eax, [nums]          ; menor valor com o primeiro elemento
    mov ebx, 0x7FFFFFFF      ; segundo menor valor com um valor alto
    mov edx, 0x80000000      ; maior valor com o primeiro elemento
    mov edi, 0x80000000      ; segundo maior valor com um valor baixo

    ; Encontrar o menor e o maior valores
find_min_max:
    mov esi, [nums + ecx*4]
    cmp esi, eax
    jge check_max
    mov eax, esi
check_max:
    cmp esi, edx
    jle update_second_max
    mov edx, esi
update_second_max:
    cmp esi, ebx
    jge skip_update_second_min
    mov ebx, esi
skip_update_second_min:
    cmp esi, edi
    jle skip_update_second_max
    mov edi, esi
skip_update_second_max:
    cmp ecx, 9               ; elementos - 1
    je done_min_max
    inc ecx
    jmp find_min_max

done_min_max:
    ; Encontrar o segundo menor e o segundo maior valores
    mov ecx, 0               ; Resetar o índice
    mov ebx, 0x7FFFFFFF      ; segundo menor valor com um valor alto
    mov edi, 0x80000000      ; segundo maior valor com um valor baixo

find_second_min:
    mov esi, [nums + ecx*4]
    cmp esi, eax
    je skip_second_min
    cmp esi, ebx
    jge skip_second_min
    mov ebx, esi
skip_second_min:
    cmp ecx, 9
    je done_second_min
    inc ecx
    jmp find_second_min

done_second_min:
    mov [second_min], ebx

    ; Encontrar o segundo maior
    mov ecx, 0               ; Resetar
    mov ebx, 0x80000000      ; segundo maior valor com um valor baixo

find_second_max:
    mov esi, [nums + ecx*4]
    cmp esi, edx
    je skip_second_max
    cmp esi, ebx
    jle skip_second_max
    mov ebx, esi
skip_second_max:
    cmp ecx, 9
    je done_second_max
    inc ecx
    jmp find_second_max

done_second_max:
    mov [second_max], ebx

    ; Imprimir o resultado
    push dword [second_max]
    push dword [second_min]
    push format
    call printf
    add esp, 12              ; Limpar a pilha

    ; Encerrar o programa
    mov eax, 1               ; saída
    xor ebx, ebx             ; status: 0
    int 0x80
