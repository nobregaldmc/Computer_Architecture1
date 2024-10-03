section .data
    fmt db "O menor número é: %d", 10, 0      ; imprimir o menor número
    fmt2 db "O maior número é: %d", 10, 0      ; imprimir o maior número

    ; transformando em constantes
    nums dd 10, 20, 5, 30, 15, 25, 35, 40, 50, 45

section .bss
    smallest resd 1 ; menor número
    largest resd 1  ; maior número

section .text
    extern printf
    global main

main:
    ; Inicializa o menor e o maior número
    mov dword [smallest], 0x7FFFFFFF  ; Inicializa com o maior valor positivo possível
    mov dword [largest], 0x80000000  ; Inicializa com o menor valor negativo possível

    ; Inicializa o ponteiro 
    lea esi, [nums]

    ; Laço 
    mov ecx, 10  ; Contador 
process_loop:
    ; Carrega o próximo número
    mov eax, [esi]
    add esi, 4    ; Avança o ponteiro 

    ; Compara e atualiza o menor número
    mov ebx, [smallest]
    cmp eax, ebx
    jge skip_smallest
    mov [smallest], eax
skip_smallest:

    ; Compara e atualiza o maior número
    mov ebx, [largest]
    cmp eax, ebx
    jle skip_largest
    mov [largest], eax
skip_largest:

    ; Decrementa o contador e continua o laço
    loop process_loop

    ; Imprime o menor número
    push dword [smallest]
    push dword fmt
    call printf
    add esp, 8    ; Limpa a pilha (2 argumentos * 4 bytes cada)

    ; Imprime o maior número
    push dword [largest]
    push dword fmt2
    call printf
    add esp, 8    ; Limpa a pilha (2 argumentos * 4 bytes cada)

    ; Termina
    mov eax, 1    ; sys_exit
    xor ebx, ebx  ; Código de saída 0
    int 0x80
