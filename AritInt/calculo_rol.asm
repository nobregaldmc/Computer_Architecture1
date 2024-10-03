global calculo_rol:function
extern printf

section .bss
	a_rol resb 1

section .data
	i dd 0
	limite dd 3
	v_rol dd 11110000b
	saida_ant_rol db "valor antigo rol: %02X", 10, 0
	saida_nov_rol db "valor novo rol %02X, rotacionado %d vezes: %02X", 10, 0

section .text

calculo_rol:
	push ebp
	mov ebp, esp

	mov al, [v_rol]
	mov [a_rol], al
	push dword [a_rol]
	push saida_ant_rol
	call printf
	add esp, 8

	mov bl, [i]
laco_rol:
	cmp bl, [limite]
	jae next_rol

	inc bl
	mov al, [a_rol]
	rol al, 1
	mov [a_rol], al

	movzx eax, al
	movzx ebx, bl
	mov edx, [v_rol]

	push eax
	push ebx
	push edx
	push saida_nov_rol
	call printf
	add esp, 16

	jmp laco_rol

next_rol:
	mov esp, ebp
	pop ebp
	ret
