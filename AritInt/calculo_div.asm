global multiplicacao_div:function
extern printf

section .bss
	a_div resd 1

section .data
	i      dd 0
	limite dd 3
	v_div  dd 500
	saida_ant_div db "valor antigo div: %d",0AH,0H
	saida_nov_div db "valor novo div %d x (2^%d): %d",0AH,0H

section .text

multiplicacao_div:
	mov eax, [v_div]
	mov [a_div], eax	
	push DWORD [a_div]
	push saida_ant_div
	call printf	
	add esp, 8
	
	mov ebx, [i]	
laco_div:
	cmp ebx, [limite]
	jae next_div
	inc ebx

	mov eax, [a_div]
	cdq	
	mov ecx, 2	
	div ecx

	mov [a_div], eax
	push DWORD [a_div]
	push ebx
	push DWORD [v_div]
	push saida_nov_div
	call printf	
	add esp, 16
	
	jmp laco_div
	
next_div:
	ret
	
	
	
	
