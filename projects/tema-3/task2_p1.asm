section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b

cmmmc:
	pop ecx ; ret adress
	pop eax ; nr a
	pop ebx ; nr b

	push ebx
	push eax
	push ecx

	xor esi, esi
	add esi, eax
	imul esi, ebx

	cmp eax, ebx
	jg scadere
	jl invers
	je bun

scadere:
	sub eax, ebx
	cmp eax, ebx
	je bun
	jg scadere
	jl invers

invers:
	sub ebx, eax
	cmp ebx, eax
	je bun
	jl scadere
	jg invers

bun:
	xor eax, eax
	add eax, esi
	xor edx, edx
	div ebx

	ret
