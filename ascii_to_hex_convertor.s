
@ BSS section
.bss

.data
A_DIGIT: .byte 'C'
H_DIGIT: .byte 0

.text
.globl main

@'0'=0x30....'9'=0x39. 'A'=0x41....'F'=0x46
main:
LDR  R0, =A_DIGIT@ load address of A_DIGIT
LDRB R0, [R0]    @load value of A_DIGIT

AND R0, R0, #0x7F @consider only LSB 7 bits

SUB R0, #'0' @ subtract '0'

CMP R0, #0x0A @compare with 0x0A
BLT store_result @if number is b/w hex 0 to hex 9, branch to store_result
ADD R0, # -'A' + 0xA  + '0'@ else number is b/w hex A to hex hex F, subtract 'A', and add 0x0A

store_result:
LDR R1, =H_DIGIT @ load address of H_DIGIT
STRB R0, [R1]@Store result @H_DIGIT

END: NOP @END
.end