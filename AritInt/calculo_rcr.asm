global calculo_rcr:function
extern printf

section .bss
        a_rcr resb 1

section .data
        i dd 0
        limite dd 3
        v_rcr dd 10101010b
        saida_ant_rcr db "valor antigo rcr: %02X", 10, 0
        saida_nov_rcr db "valor novo rcr %02X, rotacionado %d vezes: %02X", 10, 0

section .text

calculo_rcr:
        push ebp
        mov ebp, esp

        mov al, [v_rcr]
        mov [a_rcr], al
        push dword [a_rcr]
        push saida_ant_rcr
        call printf
        add esp, 8

        mov bl, [i]
	mov cl, 1
laco_rcr:
        cmp bl, [limite]
        jae next_rcr

        inc bl
	cmp cl, 1
	jne continue_rcr

	mov cl, 0
	stc
continue_rcr:
        mov al, [a_rcr]
        rcr al, 1
        mov [a_rcr], al

        movzx eax, al
        movzx ebx, bl
        mov edx, [v_rcr]

        push eax
        push ebx
        push edx
        push saida_nov_rcr
        call printf
        add esp, 16

        jmp laco_rcr

next_rcr:
        mov esp, ebp
        pop ebp
        ret

