section .data
    fmt_matriz db "Matriz original: ", 10, 0
    fmt_elemento db "%d ", 0
    fmt_newline db 10, 0
    fmt_menor db "Menor valor é %d na linha %d e coluna %d", 10, 0
    fmt_maior db "Maior valor é %d na linha %d e coluna %d", 10, 0

section .bss
    matriz resd 18  ; Matriz 6x3 de inteiros (4 bytes cada)
    cont resd 1
    aux resd 1
    aux2 resd 1
    linha resd 1
    coluna resd 1
    linha1 resd 1
    coluna1 resd 1

section .text
    global main
    extern printf

main:
    push ebp
    mov ebp, esp

    ; Inicializa variáveis
    mov dword [cont], 1
    mov dword [aux], 999999
    mov dword [aux2], -999999

    ; Define os valores da matriz
    mov dword [matriz], 10
    mov dword [matriz + 4], 20
    mov dword [matriz + 8], 30
    mov dword [matriz + 12], 40
    mov dword [matriz + 16], 50
    mov dword [matriz + 20], 60
    mov dword [matriz + 24], 70
    mov dword [matriz + 28], 80
    mov dword [matriz + 32], 90
    mov dword [matriz + 36], 100
    mov dword [matriz + 40], 110
    mov dword [matriz + 44], 120
    mov dword [matriz + 48], 130
    mov dword [matriz + 52], 140
    mov dword [matriz + 56], 150
    mov dword [matriz + 60], 160
    mov dword [matriz + 64], 170
    mov dword [matriz + 68], 180

    ; Imprime "Matriz original: "
    mov eax, fmt_matriz
    push eax
    call printf
    add esp, 4

    ; Imprime a matriz
    xor eax, eax  ; i = 0
.outer_loop:
    cmp eax, 6
    jge .outer_loop_end

    xor ebx, ebx  ; j = 0
.inner_loop:
    cmp ebx, 3
    jge .inner_loop_end

    ; Calcula o índice da matriz
    mov edx, eax
    imul edx, 12  ; 3 colunas * 4 bytes
    add edx, ebx
    imul edx, 4  ; 4 bytes por elemento

    ; matriz[i][j] = cont
    mov ecx, [matriz + edx]

    ; Imprime elemento
    push ecx
    mov eax, fmt_elemento
    push eax
    call printf
    add esp, 8

    inc ebx
    jmp .inner_loop

.inner_loop_end:
    ; Imprime nova linha
    mov eax, fmt_newline
    push eax
    call printf
    add esp, 4

    inc eax
    jmp .outer_loop

.outer_loop_end:

    ; Encontra o valor mínimo e máximo
    xor eax, eax  ; i = 0
.outer_loop2:
    cmp eax, 6
    jge .outer_loop2_end

    xor ebx, ebx  ; j = 0
.inner_loop2:
    cmp ebx, 3
    jge .inner_loop2_end

    ; Calcula o índice da matriz
    mov edx, eax
    imul edx, 12  ; 3 colunas * 4 bytes
    add edx, ebx
    imul edx, 4  ; 4 bytes por elemento

    mov edx, [matriz + edx]

    ; Se (matriz[i][j] < aux)
    cmp edx, [aux]
    jge .skip_min
    mov [aux], edx
    mov [linha], eax
    mov [coluna], ebx
.skip_min:

    ; Se (matriz[i][j] > aux2)
    cmp edx, [aux2]
    jle .skip_max
    mov [aux2], edx
    mov [linha1], eax
    mov [coluna1], ebx
.skip_max:

    inc ebx
    jmp .inner_loop2

.inner_loop2_end:
    inc eax
    jmp .outer_loop2

.outer_loop2_end:

    ; Imprime o menor valor
    mov eax, [aux]
    push eax
    mov eax, [linha]
    inc eax ; Para ajustar para base 1
    push eax
    mov eax, [coluna]
    inc eax ; Para ajustar para base 1
    push eax
    mov eax, fmt_menor
    push eax
    call printf
    add esp, 16

    ; Imprime o maior valor
    mov eax, [aux2]
    push eax
    mov eax, [linha1]
    inc eax ; Para ajustar para base 1
    push eax
    mov eax, [coluna1]
    inc eax ; Para ajustar para base 1
    push eax
    mov eax, fmt_maior
    push eax
    call printf
    add esp, 16

    mov esp, ebp
    pop ebp
    ret

