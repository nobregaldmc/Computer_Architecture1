global multiplicacao_binaria:function
extern printf

section .bss
	a_mul_bin resd 1

section .data
	i      dd 0
	limite dd 3
	v_mul_bin  dd 5
	saida_ant_mul_bin db "valor antigo mul_bin: %d",0AH,0H
	saida_nov_mul_bin db "valor novo mul_bin %d x (2^%d): %d",0AH,0H

section .text

multiplicacao_binaria:
	mov eax, [v_mul_bin]
	mov [a_mul_bin], eax	
	push DWORD [a_mul_bin]
	push saida_ant_mul_bin
	call printf	
	add esp, 8
	
	mov ebx, [i]	
laco_mul_bin:
	cmp ebx, [limite]
	jae next_mul_bin
	inc ebx

	; Substituir 'mul_bin' por 'shl' ou 'MUL'
	mov eax, [a_mul_bin]
	shl eax, 1               ; Multiplica por 2 (equivalente a multiplicação binária)
	mov [a_mul_bin], eax

	push DWORD [a_mul_bin]
	push ebx
	push DWORD [v_mul_bin]
	push saida_nov_mul_bin
	call printf	
	add esp, 16
	
	jmp laco_mul_bin
	
next_mul_bin:
	ret

	
