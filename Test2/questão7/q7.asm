extern printf
extern scanf

section .data
    fmt db '%d', 0  ; entrada e saída de números inteiros
    prompt_lado1 db "Informe o valor do primeiro lado: ", 0
    prompt_lado2 db "Informe o valor do segundo lado: ", 0
    prompt_lado3 db "Informe o valor do terceiro lado: ", 0
    mensagem_nao_triangulo db "Os lados não formam um triângulo.", 10, 0
    mensagem_equilatero db "O triângulo é equilátero.", 10, 0
    mensagem_isosceles db "O triângulo é isósceles.", 10, 0
    mensagem_escaleno db "O triângulo é escaleno.", 10, 0

section .bss
    valor_lado1 resd 1  ; primeiro lado
    valor_lado2 resd 1  ; segundo lado
    valor_lado3 resd 1  ; terceiro lado

section .text
    global main
main:
    ; primeiro lado
    push prompt_lado1
    call printf
    add esp, 4

    push valor_lado1
    push fmt
    call scanf
    add esp, 8

    ; segundo lado
    push prompt_lado2
    call printf
    add esp, 4

    push valor_lado2
    push fmt
    call scanf
    add esp, 8

    ; terceiro lado
    push prompt_lado3
    call printf
    add esp, 4

    push valor_lado3
    push fmt
    call scanf
    add esp, 8

    ; Verificar se os valores formam um triângulo:

    mov eax, [valor_lado2]  ; Primeiro, verificar se lado1 é maior que a soma de lado2 e lado3
    add eax, [valor_lado3]
    cmp [valor_lado1], eax
    jg nao_triangulo  ; Se lado1 for maior, não é um triângulo

    mov eax, [valor_lado1]  ; Verificar se lado2 é maior que a soma de lado1 e lado3
    add eax, [valor_lado3]
    cmp [valor_lado2], eax
    jg nao_triangulo  ; Se lado2 for maior, também não é um triângulo
  
    mov eax, [valor_lado1]  ; Verificar se lado3 é maior que a soma de lado1 e lado2
    add eax, [valor_lado2]
    cmp [valor_lado3], eax
    jg nao_triangulo  ; Se lado3 for maior, não é um triângulo

    ; tipo de triângulo
    mov eax, [valor_lado1]
    cmp eax, [valor_lado2]
    jne verifica_isosceles  ; Se lado1 for diferente de lado2, verificar se é isósceles

    cmp eax, [valor_lado3]
    jne verifica_isosceles  ; Se lado1 for diferente de lado3, verificar se é isósceles

    push mensagem_equilatero  ; Se todos os lados forem iguais = equilátero
    call printf
    add esp, 4
    jmp final

verifica_isosceles:
    mov eax, [valor_lado1]  ; Verificar se o triângulo é isósceles
    cmp eax, [valor_lado2]
    je isosceles

    mov eax, [valor_lado1]
    cmp eax, [valor_lado3]
    je isosceles

    mov eax, [valor_lado2]
    cmp eax, [valor_lado3]
    je isosceles

    push mensagem_escaleno  ; Se todos os lados forem diferentes = escaleno
    call printf
    add esp, 4
    jmp final

isosceles:
    push mensagem_isosceles
    call printf
    add esp, 4
    jmp final

nao_triangulo:
    push mensagem_nao_triangulo
    call printf
    add esp, 4

final:
    mov eax, 1 
    xor ebx, ebx 
    int 0x80  

