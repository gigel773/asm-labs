%include "own_defs.asm"

section .text

global sum

;
; Brief: sums up two numbers
;
sum:
    mov eax, edi
    add eax, esi
    ret