global calculo_ror:function
extern printf

section .bss
	a_ror resb 1

section .data
	i dd 0
	limite dd 3
	v_ror dd 10000110b
	saida_ant_ror db "valor antigo ror: %02X", 10, 0
	saida_nov_ror db "valor novo ror %02X, rotacionado %d vezes: %02X", 10, 0

section .text

calculo_ror:
	push ebp
	mov ebp, esp

	mov al, [v_ror]
	mov [a_ror], al
	push dword [a_ror]
	push saida_ant_ror
	call printf
	add esp, 8

	mov bl, [i]
laco_ror:
	cmp bl, [limite]
	jae next_ror

	inc bl
	mov al, [a_ror]
	ror al, 1
	mov [a_ror], al

	movzx eax, al
	movzx ebx, bl
	mov edx, [v_ror]

	push eax
	push ebx
	push edx
	push saida_nov_ror
	call printf
	add esp, 16

	jmp laco_ror

next_ror:
	mov esp, ebp
	pop ebp
	ret

