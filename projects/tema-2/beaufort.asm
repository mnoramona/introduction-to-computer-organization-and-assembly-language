%include "../include/io.mac"
section .data
    len dd 0
    keylen dd 0
section .text
    global beaufort
    extern printf

; void beaufort(int len_plain, char *plain, int len_key, char *key, char tabula_recta[26][26], char *enc) ;
beaufort:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; len_plain
    mov ebx, [ebp + 12] ; plain (address of first element in string)
    mov ecx, [ebp + 16] ; len_key
    mov edx, [ebp + 20] ; key (address of first element in matrix)
    mov edi, [ebp + 24] ; tabula_recta
    mov esi, [ebp + 28] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement spiral encryption
    ;; FREESTYLE STARTS HERE

    mov DWORD[len], eax
    mov DWORD[keylen], ecx

    ; cntr i
    mov eax, 0 
    ; cnrt j
    mov edi, 0
    cmp DWORD[len], eax ; o sa i zic ca l cheama i
    jg pas

pas:
    ;PRINTF32 `%d %d\n\x0`, eax, edi
    cmp DWORD[len], eax
    jg loop
    jle end


loop:
    ; in cl am caracter din sir mare
    ; in byte mm am caracter key
    mov cl, byte[ebx + eax]
    cmp cl, byte[edx + edi]
    jg scad
    jl invers
    je da


da: 
    mov byte[esi + eax], 'A'
    add eax, 1
    add edi, 1
    jmp schema



schema:
    cmp DWORD[keylen], edi ; o sa i zic ca l cheama j
    jg pas
    jle revin

revin:  
    mov edi, 0
    jmp pas

scad:
    mov cl, byte[edx + edi]
    sub cl, byte[ebx + eax]
    mov byte[esi + eax], cl
    add byte[esi + eax], 'A'
    add byte[esi + eax], 26
    add eax, 1
    add edi, 1
    jmp schema

invers:
    mov cl, byte[edx + edi]
    sub cl, byte[ebx + eax]
    mov byte[esi + eax], cl
    add byte[esi + eax], 'A'
    add eax, 1
    add edi, 1
    jmp schema

end:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
