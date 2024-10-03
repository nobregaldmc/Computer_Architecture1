global calculo_shrd:function
extern printf

section .bss
        a_shrd resd 1

section .data
	i dd 0
        limite dd 3
        v_shrd1 dd 0xC1
	v_shrd2 dd 0x1D
        saida_ant_shrd db "valor antigo shrd: 0x%x", 10, 0
        saida_nov_shrd db "valor novo shrd 0x%x rotacionado %d vezes: 0x%x", 10, 0

section .text

calculo_shrd:
        mov eax, [v_shrd1]
	mov [a_shrd], eax
	push eax
	push saida_ant_shrd
	call printf
	add esp, 8

	mov ebx, [i]
laco_shrd:
        cmp ebx, [limite]
	jae next_shrd
	inc ebx

	mov eax, [v_shrd1]
	mov edx, [v_shrd2]
	mov ecx, ebx
	shrd eax, edx, cl
	mov [a_shrd], eax

	push dword [a_shrd]
	push ebx
	push dword [v_shrd1]
	push saida_nov_shrd
	call printf
	add esp, 16

        jmp laco_shrd

next_shrd:
        ret
