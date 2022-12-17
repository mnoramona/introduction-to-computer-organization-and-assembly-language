%include "printf32.asm"
extern printf
extern calloc
extern scanf

section .data
    arr dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    N dd 10
    P dd 4
    Q dd 8
    fmt_int db "%u ", 0
    fmt_newline db 10, 0
    citire dd 0

section .text
global main

;TODO a: Implementati functia `void print_array(unsigned int *a, int N)` pentru a afisa
;   elementele vectorului `a` de dimensiune `N` pe o singura linie separate de cate un spatiu.
;
;   Afisarea se va face folosind functia `int printf(const char *format, ...);` din biblioteca standard C.
;
;   ATENTIE: Functia `printf` poate modifica registerele EAX, ECX si EDX. Pentru simplitate puteti folosi
;   instructiunile `pusha`, `popa` pentru a salva respectiv restaura toate registrele modificate de un apel de biblioteca.

print_array:
    push ebp
    mov ebp, esp

    mov eax,[ebp + 8]       ;;len 
    mov ebx,[ebp + 12]      ;;vectorul

    xor ecx,ecx

PARCURGERE_VECTOR:
    pusha

    mov edx,dword[ebx + 4*ecx]
    push edx
    push fmt_int
    call printf
    add esp,8

    popa
    inc ecx
    
    cmp ecx,eax
    jl PARCURGERE_VECTOR 



    leave
    ret

;TODO b: Implementati functia `int* alloc_array(int N)` care aloca memorie (dinamic) pentru `N` intregi. Memoria alocata va trebui zeroizata.
;   Pentru alocare de memorie puteti folosi functiile:
;   - `void *malloc(int size)`, care aloca `size` octeti. Memoria alocata nu este zeroizata.
;  SAU
;   - `void *calloc(size_t nmemb, size_t size)`, care aloca `nmemb` elemente fiecare de dimensiune `size`. Memoria alocata este zeroizata.
;
;   RECOMANDARE: folositi functia `calloc`
alloc_array:
    push ebp
    mov ebp, esp

    mov ecx,dword[N]

    push 4
    push ecx
    call calloc
    add esp,8

    leave
    ret

;TODO c: Implementati functia `void read_array(unsigned int *a, int N)` care citeste de la intrarea standard
;   un vector `a` de `N` numere intregi fara semn.
;
;   Citirea de la intrarea standard se va face folosind functia `int scanf(const char *format, ...);` din biblioteca standard C.
;   e.g pentru citirea unui intreg
;       unsigned int elem;
;       scanf("%u", &elem);

read_array:
    push ebp
    mov ebp, esp

    mov eax,[ebp + 8]       ;;len
    mov ebx,[ebp + 12]      ;;vectorul

PRINTF32 `\n\x0`

    xor ecx,ecx
  ;  inc eax

OF:

    pusha

    push citire
    push fmt_int
    call scanf
    add esp,8

    popa
    mov edx,dword[citire]
    mov dword[ebx + 4 *ecx],edx

;PRINTF32 `\n%d\n\x0`, dword[citire]

    inc ecx

    cmp ecx,eax
    jl OF

    mov eax,[ebp + 12]

    leave
    ret

; TODO d: Implementati functia void update_interval(int *a, int N, int P, int Q)` care
;   va face urmatoarele operatii asupra sirului de elemente intregi fara semn `a` de dimensiune `N`"
;
;   a[i] = 2 * a[i], daca elementul a[i] se gaseste in intervalul [P, Q]
;   a[i] = a[i] / 2, daca elemente a[i] se gaseste in afara intervalului [P, Q]
;
; ATENTIE: este garantat ca P <= Q pentru toate apelurile functiei `update_interval`.

update_interval:
    push ebp
    mov ebp, esp

    mov ebx,[ebp + 8]       ;;  Q
    mov ecx,[ebp + 12]      ;;  P
    mov edx,[ebp + 16]      ;;N
    mov eax,[ebp + 20]      ;;vectorul

;PRINTF32 `%d %d %d %d\n\x0`,ecx,ebx,edx,dword[eax]

    mov ebx,0

FOR_0:

;    xor edx,edx
;    mov esi,2
;    mov edx,dword[eax + 4*ebx]
;    xor eax,eax
;    mov eax,edx

;    div esi

;    mov edx,eax
 
    mov edx,dword[eax + 4*ebx]
    shr edx,1
    mov dword[eax + 4*ebx],edx

    inc ebx

    cmp ebx,ecx
    jl FOR_0

    mov ebx,ecx
FOR_2:


    mov edx,dword[eax + 4*ebx]
    shr edx,1
    mov dword[eax + 4*ebx],edx

    inc ebx

    cmp ebx,dword[N]
    jl FOR_2


FOR:
    mov edx,dword[eax + 4*ecx]
    mov eax,edx
    mov esi,2
    mul esi


    mov edx,eax
    mov eax,[ebp + 20]
    mov dword[eax + 4*ecx],edx
PRINTF32 `WTF %d\n\x0`,dword[eax + 4*ecx]
    inc ecx
    mov edx,[ebp + 8]
    cmp ecx,edx
    jl FOR

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Apelati functia `print_array(int *a, int N)` pentru a afisa vectorul `arr` de dimensiune `N` definit in sectiunea `.data`

    push arr
    push dword[N] 
    call print_array
    add esp,8


	PRINTF32 `\n\x0`
    ; TODO b: Alocati memorie pentru un vector de N intregi fara semn, apeland functia `alloc_array`
    ; si apoi afisati vectorul apeland functia `print_array`.

    push dword[N]
    call alloc_array
    add esp,4

  ;  mov ebx,eax
pusha
    push eax
    push dword[N]
    call print_array
    add esp,8
popa
    ; TODO c: Cititi de la intrarea standard un vector de `N` intregi apeland functia `read_array`
    ; si apoi afisati vectorul folosind functia `print_array`.

;mov eax,ebx
pusha
    push eax
    push dword[N]
    call read_array
    add esp,8
popa

pusha

    push eax
    push dword[N]
    call print_array
    add esp,8
popa
    ; TODO d: Transformati vectorul `a` de `N` elemente intregi fara semn citit la TODO c) apeland functia
    ; `update_array` si apoi afisati vectorul folosind functia `print_array`.
    ; Functia `update_array` va fi apelata astfel:
    ; `update_array(a, N, P, Q)` unde N, P si Q se gasesc in sectiunea `.data` iar vectorul `a` este cel citit la TODO c;

    push eax
    push dword[N]
    push dword[P]
    push dword[Q]
    call update_interval
    add esp,16

pusha

    push eax
    push dword[N]
    call print_array
    add esp,8
popa

    ; Return 0.
    xor eax, eax
    leave
    ret
