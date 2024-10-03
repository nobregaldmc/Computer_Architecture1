global calculo_rcl:function
extern printf

section .bss
        a_rcl resb 1

section .data
        i dd 0
        limite dd 3
        v_rcl dd 10101010b
        saida_ant_rcl db "valor antigo rcl: %02X", 10, 0
        saida_nov_rcl db "valor novo rcl %02X, rotacionado %d vezes: %02X", 10, 0

section .text

calculo_rcl:
        push ebp
        mov ebp, esp

        mov al, [v_rcl]
        mov [a_rcl], al
        push dword [a_rcl]
        push saida_ant_rcl
        call printf
        add esp, 8

        mov bl, [i]
	mov cl, 1
laco_rcl:
        cmp bl, [limite]
        jae next_rcl

        inc bl
	cmp cl, 1
	jne continue_rcl

	mov cl, 0
	clc
continue_rcl:
        mov al, [a_rcl]
        rcl al, 1
        mov [a_rcl], al

        movzx eax, al
        movzx ebx, bl
        mov edx, [v_rcl]

        push eax
        push ebx
        push edx
        push saida_nov_rcl
        call printf
        add esp, 16

        jmp laco_rcl

next_rcl:
        mov esp, ebp
        pop ebp
        ret

