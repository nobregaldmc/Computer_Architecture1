extern printf

section .data
    ; Definindo o array de 5 números 
    numbers dw 2, 3, 4, 5, 6   

    ; Formato de string para printf
    out_fmt db "O resultado da multiplicacao e: %d", 10, 0

section .bss
    result resd 1

section .text
    global main

main:
    ; Inicializa
    mov eax, 1

    ; endereço do array
    mov esi, numbers

    ; Loop 
    mov ecx, 5                  ; elementos
multiply_loop:
    movzx edx, word [esi]       ; próximo número
    imul eax, edx               ; Multiplica EAX por EDX
    add esi, 2                  ; Avança para o próximo elemento
    loop multiply_loop          ; Repete até que ECX seja 0

    ; Armazena no .bss
    mov [result], eax

    ; printf do resultado
    push eax                    ; resultado no topo da pilha
    push out_fmt                ; formato da string no topo da pilha
    call printf                 ; printf
    add esp, 8                  ; Limpa a pilha 

    ; Finaliza o programa
    mov eax, 1                  ; saída 
    xor ebx, ebx                ; retorno 0
    int 0x80                    ; Chama o kernel
