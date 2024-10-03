extern printf

section .data
    ; Definindo o array de 10 números inteiros (2 bytes cada)
    numbers dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    
    ; Formato para printf
    out_fmt db "A soma dos números é: %d", 10, 0

section .bss
    sum resd 1           ; Reservar espaço

section .text
    global main

main:
    ; Inicializando
    mov ecx, 10          ; Número de elementos 
    mov ebx, numbers     ; Endereço do array de números
    xor eax, eax         ; Zerar o registrador eax 

calculate_soma:
    add ax, [ebx]        ; Elemento para o ax
    add ebx, 2           ; Próximo elemento 
    loop calculate_soma   ; Repetir até que ecx seja 0

    ; Armazenar a soma na variável 'soma'
    mov [soma], eax

    ; Preparar para chamar printf
    mov eax, 4           ; syscall para sys_write 
    push eax             ; Colocar 4
    push dword [soma]    ; soma na pilha
    push out_fmt         ; formato na pilha

    ; Chamar printf
    call printf

    ; Finalizar o programa
    ; A syscall 'exit' em Linux não pode ser chamada diretamente, então usamos 'int 0x80'
    mov eax, 1           ; Código da syscall para sys_exit
    xor ebx, ebx         ; Código de saída 0
    int 0x80             ; Interrompe a execução para terminar o programa
