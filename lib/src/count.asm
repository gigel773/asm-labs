%include "own_defs.asm"

section .text

global count

;
; Brief: Counts the present of given symbol in text
;
count:
    %define src_1 rdi
    %define src_size rsi
    %define symbol edx
    %define dest rcx

    push rbp
    push rbx
    push r12
    push r13
    push r14
    push r15

    xor eax, eax

.main_cycle:
    ; Compare next symbols
    mov bl, byte [src_1]

    cmp bl, dl
    jne .next_main
    add eax, 1

.next_main:
    ; Switch to next iteration or not
    add src_1, 1
    sub src_size, 1
    cmp src_size, 0
    jne .main_cycle

.return_value:
    mov dword [dest], eax
    xor eax, eax

    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp

    ret