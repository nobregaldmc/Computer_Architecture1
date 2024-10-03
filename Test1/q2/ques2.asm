section .data
    b dd 10                
    c dd 20                
    result dd 0            
    fmt db "Resultado: %d", 10, 0  

section .bss
    ; Nenhuma variável 

section .text
    extern printf
    global main

main:
    mov eax, dword [b] ; Carrega b em eax
    
    ; Calcula 2 * b
    shl eax, 1             ; 'shl eax, 1' é equivalente a 'eax = eax * 2'

    ; Carrega c em ebx
    mov ebx, dword [c]

    ; Divide c por 2
    shr ebx, 1             ; 'shr ebx, 1' é equivalente a 'ebx = ebx / 2'

    ; Soma os resultados de 2 * b e c / 2
    add eax, ebx

    ; Adiciona 200 ao result
    add eax, 200

    ; Armazena o resultado em result
    mov [result], eax

    ; Chama o printf para exibir o result
    push dword [result]    ; Empilha o result
    push dword fmt         ; Empilha o endereço da string de formato
    call printf            
    add esp, 8             ; Limpa a pilha 

    ; Chama a syscall para exit 
    mov eax, 1             ; syscall número para sys_exit
    xor ebx, ebx           ; status de saída 0
    int 0x80               ; invoca a syscall
