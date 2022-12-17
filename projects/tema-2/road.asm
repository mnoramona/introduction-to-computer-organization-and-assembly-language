%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global road
    extern printf

road:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]      ; points
    mov ecx, [ebp + 12]     ; len
    mov ebx, [ebp + 16]     ; distances
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    mov edx, 1
    cmp edx, ecx
    jle ox
    
ox:
    sub edx, 1
    movzx edi, WORD[eax + 4 * edx + point.x]
    add edx, 1
    movzx esi, WORD[eax + 4 * edx + point.x]
    cmp edi, esi
    je oy
    cmp edi, esi
    jl distanta
    cmp edi, esi
    jg invers
    

oy:
    sub edx, 1
    movzx edi, WORD[eax + 4 * edx + point.y]
    add edx, 1
    movzx esi, WORD[eax + 4 * edx + point.y]
    cmp edi, esi
    jl distanta
    cmp edi, esi
    jg invers


distanta:
    sub esi, edi
    PRINTF32 `%d\n\x0`, esi
    mov [ebx + 4*edx - 4], esi
    add edx, 1
    cmp edx, ecx
    jl ox

invers:
    sub edi, esi
    PRINTF32 `%d\n\x0`, edi
    mov [ebx + 4*edx - 4], edi
    add edx, 1
    cmp edx, ecx
    jl ox

end:


    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY