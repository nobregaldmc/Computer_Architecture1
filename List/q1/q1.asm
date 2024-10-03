section .data
    format db "a=%d, eax=%d", 10, 0
    a dd 5

section .text
    global _start
    extern printf     ; Declara a função printf para uso externo

; Ponto de entrada do programa
_start:
    call print_values ; Chama a função para imprimir os valores
    call exit_program ; Chama a função para sair do programa

; Função para imprimir valores
print_values:
    ; Load the value of a into eax
    mov eax, [a]
    
    ; Prepare the arguments for printf
    push eax          ; Push a
    add eax, 2       ; eax = a + 2
    push eax          ; Push eax (a + 2)
    push format      ; Push format string
    call printf       ; Call printf
    add esp, 12      ; Clean up the stack (3 arguments * 4 bytes)
    
    ret               ; Retorna ao ponto de chamada

; Função para sair do programa
exit_program:
    mov eax, 1       ; syscall: exit
    xor ebx, ebx     ; status: 0
    int 0x80         ; Chama a interrupção para sair do programa

    ret               ; Retorna (não será chamado neste caso, pois o programa termina)

