section .data
    fmt db "Soma dos pares é: %d", 10, 0
    fmt2 db "Soma dos impares é: %d", 10, 0

section .bss
    soma_pares resd 1
    soma_impares resd 1

section .text
    extern printf
    global main

main:
    ; Inicializa os valores
    xor ecx, ecx        ; contador, ecx = 0
    xor eax, eax        ; soma dos pares, eax = 0
    xor ebx, ebx        ; soma dos ímpares, ebx = 0

loop_start:
    ; Início do loop
    inc ecx             ; ecx = ecx + 1
    cmp ecx, 101        ; se ecx > 100, sair do loop
    jge done

    ; Verifica se o número é par ou ímpar
    mov edx, ecx
    and edx, 1          ; edx = ecx % 2
    jz par              ; se zero, é par

impar:
    ; se for ímpar
    add ebx, ecx        ; soma dos ímpares
    jmp loop_start

par:
    ; se for par
    add eax, ecx        ; soma dos pares
    jmp loop_start

done:
    ; Armazena os resultados nas variáveis
    mov [soma_pares], eax
    mov [soma_impares], ebx

    ; Chama a função printf para exibir a soma dos pares
    push dword [soma_pares]
    push dword fmt
    call printf
    add esp, 8

    ; Chama a função printf para exibir a soma dos ímpares
    push dword [soma_impares]
    push dword fmt2
    call printf
    add esp, 8

    ; Saída do programa
    mov eax, 1          ; syscall número para exit
    xor ebx, ebx        ; código de saída 0
    int 0x80            ; chama o kernel
