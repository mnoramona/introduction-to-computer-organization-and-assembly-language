%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here

    mov ebx, 0
    cmp ecx, ebx
    jg pas

loop:
    add byte[esi + ebx], dl
    cmp byte[esi+ebx], 90
    jg verificare
    mov al, byte[esi + ebx]
    mov byte[edi + ebx], al
    add ebx, 1
    jmp pas

verificare:
    sub byte[esi+ebx], 26
    mov al, byte[esi + ebx]
    mov byte[edi + ebx], al
    add ebx, 1
    jmp pas

pas:
    cmp ecx, ebx
    jg loop

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
