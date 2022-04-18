SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1

segment .data
    msg1 db "Introduceti cifra",0xA, 0xD
    len1 equ $-msg1
    msg2 db "Cifra se afla in multimea {1,6,4,7}",0xA, 0xD
    len2 equ $-msg2
    msg3 db "Cifra nu se afla in multime",0xA, 0xD
    len3 equ $-msg3

segment .bss
    num1 resb 1  ;initializez num1 cu 1 byte

section .text
    global main
main:
    ;Afisare msg1
    mov eax, SYS_WRITE  
    mov ebx, STDOUT
    mov ecx, msg1
    mov edx, len1
    int 0x80
    ;Citire de la tastatura cifra
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, num1
    mov edx, 1
    int 0x80
    
    mov ecx, [num1] ;mut din nou in registrul ecx valoarea lui num1
    cmp ecx, '1'   ;compara ecx cu '1'
    je in_multime
    cmp ecx, '6'  ; compara ecx cu '6'
    je in_multime
    cmp ecx, '4' ;compara ecx cu '4'
    je in_multime
    cmp ecx, '7'  ;compara ecx cu '7'
    je in_multime
    ;in caz ca numarul citit nu este niciunul din multimea {1,6,4,7} se va afisa msg3
    mov eax, SYS_WRITE
    mov ebx,STDOUT
    mov ecx,msg3
    mov edx,len3
    int 0x80
    jmp exit
;afisare msg2 in caz ca numarul citit apartine multimii
in_multime:  
    mov eax, SYS_WRITE
    mov ebx,STDOUT
    mov ecx,msg2
    mov edx,len2
    int 0x80
exit:
    mov eax, SYS_EXIT
    int 0x80

    
    
