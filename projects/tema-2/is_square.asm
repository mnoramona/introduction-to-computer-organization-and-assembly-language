%include "../include/io.mac"

section .text
    global is_square
    extern printf

is_square:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; dist
    mov eax, [ebp + 12]     ; nr
    mov ecx, [ebp + 16]     ; sq
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    mov edx, 0 ;i-ul meu
sus:
    mov edi, 0 ; k = 0
    cmp edx, eax ; daca i < nr
    jl patrat
    je end

patrat:
    mov esi, edi
    imul esi, esi
    cmp esi, DWORD[ebx + 4*edx]
    jl cresc
    cmp esi, DWORD[ebx + 4*edx]
    je adaug1
    cmp esi, DWORD[ebx + 4*edx]
    jg adaug0

cresc:
    add edi, 1
    jmp patrat

adaug1:
    mov DWORD[ecx + 4* edx], 1
    add edx, 1
    jmp sus
    

adaug0:
    mov DWORD[ecx + 4* edx], 0
    add edx, 1
    jmp sus

end:
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY