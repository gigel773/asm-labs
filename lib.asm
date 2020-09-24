section .text

global _sum, _sum_vector, _sum_vectors

BAD_PTR_STATUS EQU -1
BAD_SIZE_STATUS EQU -2
DWORD_ADDRESS_OFFSET EQU 4

;
; Brief: sums up two numbers
;
_sum:
    mov eax, edi
    add eax, esi
    ret

;
; Brief: calculates the sum of the elements
;
_sum_vector:
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

;
; Brief: sums up two given vectors numbers
;
_sum_vectors:
    %define src_1 rdi
    %define src_2 rsi
    %define dest rdx
    %define param_size rcx

    cmp param_size, 4
    jl .cycle_tail

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

.return:
    xor rax, rax
    ret
