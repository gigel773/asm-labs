%include "own_defs.asm"

section .text

global sum_vectors

;
; Brief: sums up two given vectors numbers
;
sum_vectors:
    %define src_1 rdi
    %define src_2 rsi
    %define dest rdx
    %define param_size rcx

.bad_args_check:
    cmp src_1, 0
    je .bad_ptr

    cmp src_2, 0
    je .bad_ptr

    cmp dest, 0
    je .bad_ptr

    cmp param_size, 1
    jl .bad_size

.entry_point:
    cmp param_size, 8
    jg .unrolled_cycle_body
    cmp param_size, 4
    jl .cycle_tail
    jmp .opt_cycle_body

.unrolled_cycle_body:
    ; Summing up to 8 elements
    movdqu xmm0, [src_1 + DWORD_ADDRESS_OFFSET * 0]
    movdqu xmm2, [src_1 + DWORD_ADDRESS_OFFSET * 4]
    movdqu xmm1, [src_2 + DWORD_ADDRESS_OFFSET * 0]
    movdqu xmm3, [src_2 + DWORD_ADDRESS_OFFSET * 4]

    addps xmm0, xmm1
    addps xmm2, xmm3

    movdqu [dest + DWORD_ADDRESS_OFFSET * 0], xmm0
    movdqu [dest + DWORD_ADDRESS_OFFSET * 4], xmm2

    ; Switch to next iteration
    add src_1, DWORD_ADDRESS_OFFSET * 8
    add src_2, DWORD_ADDRESS_OFFSET * 8
    add dest, DWORD_ADDRESS_OFFSET * 8
    sub param_size, 8

    ; Choose next execution branch
    cmp param_size, 8
    jg .unrolled_cycle_body

    cmp param_size, 4
    jg .opt_cycle_body

    cmp param_size, 0
    je .return

.opt_cycle_body:
    ; Summing up to 4 elements
    movdqu xmm0, [src_1]
    movdqu xmm1, [src_2]
    addps xmm0, xmm1
    movdqu [dest], xmm0

    ; Switch to next iteration
    add src_1, DWORD_ADDRESS_OFFSET * 4
    add src_2, DWORD_ADDRESS_OFFSET * 4
    add dest, DWORD_ADDRESS_OFFSET * 4
    sub param_size, 4

    ; Choose next execution branch
    cmp param_size, 4
    jg .opt_cycle_body

    cmp param_size, 0
    je .return

.cycle_tail:
    ; Sum next numbers
    mov eax, dword [src_1]
    add eax, dword [src_2]
    mov dword [dest], eax

    ; Switch to next iteration
    add src_1, DWORD_ADDRESS_OFFSET
    add src_2, DWORD_ADDRESS_OFFSET
    add dest, DWORD_ADDRESS_OFFSET
    sub param_size, 1

    ; Check if next iteration is required
    cmp param_size, 0
    jne .cycle_tail
    xor eax, eax
    jmp .return

.bad_ptr:
    mov eax, BAD_PTR_STATUS
    jmp .return

.bad_size:
    mov eax, BAD_SIZE_STATUS

.return:
    ret
