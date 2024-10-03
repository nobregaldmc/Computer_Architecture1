section .data
    msg_prompt db "Digite dois numeros: ", 0  ; Pedindo os valores
    format_in db "%d %d", 0  ; Scanf
    format_out db "Resultado: %d", 10, 0  ; Printf

section .bss
    num1 resd 1  
    num2 resd 1 

section .text
    extern printf, scanf
    global main

main:
    ; Exibe a mensagem para o usuário
    push msg_prompt   
    call printf      
    add esp, 4       

    ; Lê os valores digitados pelo usuário
    push num2
    push num1
    push format_in
    call scanf
    add esp, 12       

    ; Chama a função com os valores lidos
    push dword [num1] 
    push dword [num2] 
    call soma
    add esp, 8        

    ; Chama printf para imprimir o resultado
    push eax          ; Empilha o resultado
    push format_out   ; Empilha a string de formato
    call printf      
    add esp, 8       

    ; Saída do programa
    mov eax, 1        
    int 0x80         

soma:
    ; Salva os registradores que serão usados
    push ebx
    push ecx
    push edx

    ; Recupera os parâmetros da pilha
    mov eax, [esp + 16] ; Primeiro parâmetro
    mov ebx, [esp + 20] ; Segundo parâmetro

    ; Soma os valores
    add eax, ebx

    ; Restaura os registradores
    pop edx
    pop ecx
    pop ebx

    ; Retorna ao chamador
    ret

