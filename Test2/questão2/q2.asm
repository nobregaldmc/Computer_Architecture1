section .data
    fmt_num db "%d ", 0
    fmt_newln db 10, 0
    msg_initial db "Array original: ", 0
    msg_after_rot db "Array após rotação: ", 0
    nums_array dd 10, 20, 30, 40
    nums_size equ ($ - nums_array) / 4

section .text
    global main
    extern printf

rotateRight:
    push ebp
    mov ebp, esp
    mov esi, [ebp + 8]  ; Ponteiro
    mov ecx, [ebp + 12] 

    cmp ecx, 1
    jle .end_rotate

    mov eax, [esi + ecx*4 - 4] 

    .loop_rotate:
        mov edx, [esi + ecx*4 - 8]
        mov [esi + ecx*4 - 4], edx
        loop .loop_rotate

    mov [esi], eax

    .end_rotate:
    pop ebp
    ret

displayArray:
    push ebp
    mov ebp, esp
    mov esi, [ebp + 8]  ; array pointer
    mov ecx, [ebp + 12] ; array size

    .loop_display:
        push ecx
        push dword [esi]
        push fmt_num
        call printf
        add esp, 8
        pop ecx
        add esi, 4
        loop .loop_display

    push fmt_newln
    call printf
    add esp, 4

    pop ebp
    ret

main:
    push ebp
    mov ebp, esp

    ; Print original array
    push msg_initial
    call printf
    add esp, 4

    push nums_size
    push nums_array
    call displayArray
    add esp, 8

    ; Rotate array
    push nums_size
    push nums_array
    call rotateRight
    add esp, 8

    ; Print rotated array
    push msg_after_rot
    call printf
    add esp, 4

    push nums_size
    push nums_array
    call displayArray
    add esp, 8

    xor eax, eax
    leave
    ret

