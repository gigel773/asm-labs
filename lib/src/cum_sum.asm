%include "own_defs.asm"

section .text

global cum_sum

;
; Brief: calculates the sum of the elements
;
cum_sum:
    ; Check bad arguments
    cmp rdi, 0
    jne .bad_size_check
    mov eax, BAD_PTR_STATUS
    jmp .return_error

.bad_size_check:
    cmp rsi, 0
    jne .entry_point
    mov eax, BAD_SIZE_STATUS
    jmp .return_error

.entry_point:
    ; Function start
    xor eax, eax
    xor ecx, ecx

.cycle_tail:
    add eax, dword [rdi]
    add rdi, DWORD_ADDRESS_OFFSET
    add ecx, 1
    cmp rcx, rsi
    jne .cycle_tail

.return_error:
    ret
