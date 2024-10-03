global multiplicacao_idiv:function
extern printf

section .bss
	a_idiv resd 1

section .data
	i      dd 0
	limite dd 3
	v_idiv  dd 30
	saida_ant_idiv db "valor antigo idiv: %d",0AH,0H
	saida_nov_idiv db "valor novo idiv %d / (2^%d): %d",0AH,0H

section .text

multiplicacao_idiv:
	mov eax, [v_idiv]
	mov [a_idiv], eax
	push DWORD [a_idiv]
	push saida_ant_idiv
	call printf
	add esp, 8

	mov ebx, [i]
laco_idiv:
	cmp ebx, [limite]
	jae next_idiv
	inc ebx

	mov eax, [a_idiv]
	cdq
	mov ecx, -3
	idiv ecx

	mov [a_idiv], eax
	push DWORD [a_idiv]
	push ebx
	push DWORD [v_idiv]
	push saida_nov_idiv
	call printf
	add esp, 16

	jmp laco_idiv

next_idiv:
	ret
