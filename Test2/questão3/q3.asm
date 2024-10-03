section .data
    msg_format db "soma eh:%d", 10, 0   ; String de formatação para printf

section .text
    global main
    extern printf

sum_function:
    push ebp
    mov ebp, esp
    
    mov ecx, [ebp+12]   ; contador
    mov eax, [ebp+8]    ; valor inicial
    xor edx, edx        ; soma_total = 0
    
.loop_sum:
    add edx, eax        ; soma_total += valor_inicial
    inc eax             ; valor_inicial++
    loop .loop_sum      ; decrementa ecx e salta para .loop_sum se não for zero
    
    mov eax, edx        ; retorna soma_total
    
    pop ebp
    ret

main:
    push ebp
    mov ebp, esp
    
    ; Chama sum_function(1, 5)
    push 5
    push 1
    call sum_function
    add esp, 8         
    
    ; Imprime o resultado
    push eax
    push msg_format
    call printf
    add esp, 8         
    
    xor eax, eax        
    
    mov esp, ebp
    pop ebp
    ret

