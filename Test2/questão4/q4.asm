section .data
    fmt_num db '%d', 0
    sum_msg db 'A soma dos números: %d', 10, 0
    prompt_msg db 'Digite o número: ', 0

section .bss
    number resd 1
    total_sum resd 1

section .text
    extern printf, scanf
    global main

main:
    call print_prompt    ; Mensagem para o usuário

    call read_number     ; scanf/leitura

    mov ecx, [number]
    mov dword [total_sum], 0

calculate_sum:
    ; Adicionar o valor atual de ecx na soma
    add [total_sum], ecx
    dec ecx
    jnz calculate_sum

    call print_sum   ; printf/imprimir

    mov eax, 0
    ret

print_prompt:
    push prompt_msg
    call printf
    add esp, 4
    ret

read_number:
    lea eax, [number]
    push eax
    push fmt_num
    call scanf
    add esp, 8
    ret

print_sum:
    push dword [total_sum]
    push sum_msg
    call printf
    add esp, 8
    ret

