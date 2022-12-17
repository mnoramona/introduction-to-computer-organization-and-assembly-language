%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global points_distance
    extern printf

points_distance:
    ;; DO NOT MODIFY
    
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; points
    mov eax, [ebp + 12]     ; distance
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    ;; daca paralele => no need for sqrt

    mov esi, 1
    cmp esi, ebx
    jle ox
    
ox:
    sub esi, 1
    movzx ecx, WORD[ebx + 4 * esi + point.x]
    add esi, 1
    movzx edx, WORD[ebx + 4 * esi + point.x]

    cmp ecx, edx
    jne distanta

    cmp ecx, edx
    je oy

oy:
    sub esi, 1
    movzx ecx, WORD[ebx + 4 * esi + point.y]
    add esi, 1
    movzx edx, WORD[ebx + 4 * esi + point.y]

    cmp ecx, edx
    jne distanta

    cmp ecx, edx
    je ox

distanta:
    sub edx, ecx
    mov [eax], edx
    add esi, 1
    cmp esi, ebx
    jl ox

end:

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret

    ;; DO NOT MODIFY