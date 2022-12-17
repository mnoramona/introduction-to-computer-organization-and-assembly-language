%include "printf32.asm"
extern printf

section .bss
	product_answer resw 1
	answer resb 24

section .data
	playlist db 0x42, 0x75, 0x76, 0x45, 0x25, 0x79, 0x54, 0x62, 0x94, 0x35, 0x6D, 0x6E, 0x45, 0x4D, 0x7A, 0x14, 0x25, 0x57, 0x94, 0x4C, 0x55, 0x42, 0x78, 0x4B
	playlist_len equ 24
	under_k dd 0
	above_k dd 0 
	multiplu_3 dd 0
	multiplu_4 dd 0

	answer_len equ 12

section .text
global main

main:
    push ebp
    mov ebp, esp


    ; TODO a:
	; Faceti produsul dintre numarul de caractere din vector mai mici decat 'K'
	; si cel al caracterelor mai mari sau egale decat 'K'.
	; Puneti in product_answer rezultatul. (ATENTIE! product_answer asteapta
	; un word (short).

	xor ecx,ecx
	mov dword[under_k],0
	mov dword[above_k],0

FOR:	

IF1:
	mov eax,0
	mov al,byte[playlist + ecx]
;PRINTF32 `%hhd\n\x0`, eax
	cmp	 ax,75
	jl SUM1
	jmp SUM2

SUM1:

	inc dword[under_k]
	jmp INCREMENTED

SUM2:
	inc dword[above_k]

INCREMENTED:

	inc ecx

	cmp ecx,playlist_len
	jl FOR

	mov eax,dword[under_k]
	mov ebx,dword[above_k]

	mul ebx

	mov word[product_answer],ax
PRINTF32 `\n%d %d\n\x0`, dword[under_k],dword[above_k]
	; Instructiune de afisare! NU MODIFICATI!
	a_print:
	PRINTF32 `%d\n\x0`, [product_answer]


    ; TODO b:
	; Pentru fiecare element din playlist, puneti in vectorul answer restul
	; impartirii lui la 41.

	xor ecx,ecx
	mov ebx,41

FOR1:
	xor eax,eax
	xor edx,edx					;;pregatim registrele pt impartire
	mov al,byte[playlist + ecx]

	div ebx						;;in eax am catul,in edx resstul

	mov byte[answer + ecx],dl

	inc ecx

	cmp ecx,playlist_len
	jl FOR1


	; Instructiune de afisare! NU MODIFICATI!
b_print:
	xor ecx, ecx
b_print_loop:
	PRINTF32 `%hhd \x0`, [answer + ecx]
	inc ecx
	cmp ecx, playlist_len
	jb b_print_loop
	PRINTF32 `\n\x0`


    ; TODO c:
	; Pentru elementele de pe indici multiplii de 3 sau de 4, inversati
	; nibbles. Fiecare rezultat va fi pus in vectorul answer.

mov dword[multiplu_3],1
mov dword[multiplu_4],1
mov ecx,1

	mov al,byte[playlist + 0]
	mov ebx,15
	AND eax,ebx
	shl eax,4
	mov edx,eax

	xor eax,eax
	mov al,byte[playlist + 0]

	mov ebx,240
	AND eax,ebx
	shr eax,4

	OR edx,eax
	mov dword[answer + 0],edx

PARCURGERE_VECTOR:	

IF11:

	cmp dword[multiplu_3],3
	je EQUAL_3
	jmp IF22

IF22:
	cmp dword[multiplu_4],4
	je EQUAL_4
	jmp INCREMENT

INVERT_NIBBLES:


EQUAL_3:
	mov dword[multiplu_3],1
	jmp GATA


EQUAL_4:
	mov dword[multiplu_4],1

GATA:

	xor eax,eax	

	mov al,byte[playlist + ecx]
	mov ebx,15
	AND eax,ebx
	shl eax,4
	mov edx,eax

	xor eax,eax
	mov al,byte[playlist + ecx]

	mov ebx,240
	AND eax,ebx
	shr eax,4

	OR edx,eax
	mov dword[answer + ecx],edx

INCREMENT:
	PRINTF32 `MULTIPLU 3-> %d MULTIPLU 4-> %d\n\x0`,dword[multiplu_3],dword[multiplu_4]
	
	cmp dword[multiplu_4],4
	je OF
	jmp NOT_OF

OF:
	mov dword[multiplu_4],1

NOT_OF:
	
	inc dword[multiplu_3]
	inc dword[multiplu_4]
	inc ecx

	cmp ecx,playlist_len
	jl PARCURGERE_VECTOR


	; Instructiune de afisare! NU MODIFICATI!
c_print:
	xor ecx, ecx

c_print_loop:
	PRINTF32 `%c\x0`, [answer + ecx]
	inc ecx
	cmp ecx, answer_len
	jb c_print_loop
	PRINTF32 `\n\x0`

    ; Return 0.
    xor eax, eax
    leave
    ret
