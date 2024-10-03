global multiplicacao_imul:function
extern printf

section .bss
	a_imul resd 1

section .data
	i      dd 0
	limite dd 3
	v_imul  dd 5
	saida_ant_imul db "valor antigo imul: %d",0AH,0H
	saida_nov_imul db "valor novo imul %d x (2^%d): %d",0AH,0H

section .text

multiplicacao_imul:
	mov eax, [v_imul]
	mov [a_imul], eax	
	push DWORD [a_imul]
	push saida_ant_imul
	call printf	
	add esp, 8
	
	mov ebx, [i]	
laco_imul:
	cmp ebx, [limite]
	jae next_imul
	inc ebx

	mov eax, [a_imul]	
	mov edx, 2	
	imul edx	

	mov [a_imul], eax
	push DWORD [a_imul]
	push ebx
	push DWORD [v_imul]
	push saida_nov_imul
	call printf	
	add esp, 16
	
	jmp laco_imul
	
next_imul:
	ret
	
	
	
	
