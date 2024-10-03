section .data
    fmt db "%d", 10, 0          ; Formato para printf (integer seguido de newline)
    buffer times 1000 dd 0      ; Espaço para armazenar até 1000 números

section .bss
    index resd 1                ; Índice para o buffer, inicializado a 0

section .text
    global main

extern printf

main:
    ; Inicializa ecx com 1000 para divisão e comparação
    mov ecx, 1000

loop_start:
    ; Verifica se o ecx é menor que 1999
    cmp ecx, 1999
    jg print_values            ; pula caso ecx seja maior que 1999

    ; Calcula se o resto da divisão de ecx por 11 é 5
    mov eax, ecx
    cdq                         ; realizado antes de qualquer divisão
    mov ebx, 11
    idiv ebx                    ; EAX = EAX / EBX, EDX = EAX % EBX

    ; Verifica se o resto é igual a 5
    cmp edx, 5
    jne nao_armazena              ; Se o resto não for 5, pula o armazenamento

    ; Armazena o valor de ecx no buffer
    mov eax, [index]            ; Carrega o valor atual do índice
    mov [buffer + eax*4], ecx   ; Armazena ecx no buffer
    inc dword [index]           ; Incrementa o índice

nao_armazena:
    ; Incrementa o contador
    inc ecx
    jmp loop_start              ; Volta ao início do loop

print_values:
    ; Inicializa o índice para impressão
    mov ecx, 0

print_loop:
    mov eax, [index]            ; Carrega o valor atual do índice
    cmp ecx, eax                ; Compara o índice de impressão com o índice atual
    jge end_print               ; Se ecx >= index, termina a impressão

    ; Imprime o valor do buffer usando printf
    mov eax, [buffer + ecx*4]
    
    pushad
    
    push eax                    ; Empilha o valor
    push fmt              ; Empilha o endereço do formato da string
    call printf                 ; Chama printf
    add esp, 8                  ; Limpa a pilha (2 * 4 bytes)

    popad

    ; Incrementa o índice
    inc ecx
    jmp print_loop              ; Volta ao início do loop de impressão

end_print:
    xor eax, eax
    ret
    
    ; Chama exit(0)
    ; mov eax, 1                  ; Número do syscall para sys_exit
    ; xor ebx, ebx                ; Código de saída 0
    ; int 0x80                    ; Interrupção do kernel
