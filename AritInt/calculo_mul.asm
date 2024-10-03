global multiplicacao_mul:function
extern printf

section .bss
	a_mul resd 1

section .data
	i      dd 0
	limite dd 3
	v_mul  dd 5
	saida_ant_mul db "valor antigo mul: %d",0AH,0H
	saida_nov_mul db "valor novo mul %d x (2^%d): %d",0AH,0H

section .text

multiplicacao_mul:
	mov eax, [v_mul]
	mov [a_mul], eax	
	push DWORD [a_mul]
	push saida_ant_mul
	call printf	
	add esp, 8
	
	mov ebx, [i]	
laco_mul:
	cmp ebx, [limite]
	jae next_mul
	inc ebx

	mov eax, [a_mul]	
	mov edx, 2	
	mul edx	

	mov [a_mul], eax
	push DWORD [a_mul]
	push ebx
	push DWORD [v_mul]
	push saida_nov_mul
	call printf	
	add esp, 16
	
	jmp laco_mul
	
next_mul:
	ret
	
	
	
	
