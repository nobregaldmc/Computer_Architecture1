extern printf
extern scanf

section .data
    formato db '%d', 0
    msg_ano_atual db "Digite o ano atual: ", 10, 0
    msg_ano_nascimento db "Digite o ano de nascimento: ", 10, 0
    msg_idade_anos db "A idade da pessoa em anos: %d", 10, 0
    msg_idade_meses db "A idade da pessoa em meses: %d", 10, 0
    msg_idade_dias db "A idade da pessoa em dias: %d", 10, 0
    const_meses_por_ano db 12
    const_dias_por_ano db 365

section .bss
    valor_ano_atual resd 1
    valor_ano_nascimento resd 1
    valor_idade_anos resd 1
    valor_idade_meses resd 1
    valor_idade_dias resd 1

section .text
    global main
main:
	; Usuário inserir ano de nascimento
    push msg_ano_nascimento
    call printf
    add esp, 4

	; Recebe ano de nascimento do usuário
    push valor_ano_nascimento
    push formato
    call scanf
    add esp, 8

	; Usuário inserir ano atual
    push msg_ano_atual
    call printf
    add esp, 4

	; Recebe ano atual do usuário
    push valor_ano_atual
    push formato
    call scanf
    add esp, 8

	; Calculo da idade
    mov eax, [valor_ano_atual]
    sub eax, [valor_ano_nascimento]
    mov [valor_idade_anos], eax

	; Idade em meses
    xor ebx, ebx
    mov ecx, [valor_idade_anos]
calcular_meses:
    add ebx, 12
    loop calcular_meses
    mov [valor_idade_meses], ebx

	; Idade em dias
    xor ebx, ebx
    mov ecx, [valor_idade_anos]
calcular_dias:
    add ebx, 365
    loop calcular_dias
    mov [valor_idade_dias], ebx

	; Print idade
    push dword [valor_idade_anos]
    push msg_idade_anos
    call printf
    add esp, 8

	; Print idade em meses
    push dword [valor_idade_meses]
    push msg_idade_meses
    call printf
    add esp, 8

	; Print idade em dias
    push dword [valor_idade_dias]
    push msg_idade_dias
    call printf
    add esp, 8

    mov eax, 1
    xor ebx, ebx
    int 0x80

