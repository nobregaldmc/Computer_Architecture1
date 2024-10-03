global calculo_shl:function
extern printf

section .bss
	a_shl resd 1

section .data
	i      dd 0
	limite dd 3
	v_shl  dd 5
	saida_ant_shl db "valor antigo shl: %d",0AH,0H
	saida_nov_shl db "valor novo shl %d x (2^%d): %d",0AH,0H

section .text

calculo_shl:
	mov eax, [v_shl]
	mov [a_shl], eax	
	push DWORD [a_shl]
	push saida_ant_shl
	call printf	
	add esp, 8
	
	mov ebx, [i]	
laco_shl:
	cmp ebx, [limite]
	jae next_shl
	inc ebx
	mov eax, [a_shl]		
	shl eax, 1	
	mov [a_shl], eax
	push DWORD [a_shl]
	push ebx
	push DWORD [v_shl]
	push saida_nov_shl
	call printf	
	add esp, 16
	
	jmp laco_shl
	
next_shl:
	ret
	
	
	
	
