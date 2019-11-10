
@ BSS section
.bss


.data
STRING: .byte '1'
.byte '1'
.byte '0'        
.byte '1'
.byte '0' 
.byte '7' 
.byte '1'
.byte '0'
NUMBER: .byte 0
ERROR : .byte 0
.text

.globl main

@'0'=0x30....'9'=0x39. 'A'=0x41....'F'=0x46
main:

EOR R1, R1@used to track error, default to 0
MOV R2, #8@used to keep count of the loop
EOR R3, R3@used to store result in binary format
LDR R0, =STRING@ load start address of STRING

loop:
SUBS R2, #1
BMI exit_loop

LDRB R4, [R0], #1   @load value of STRING[0]
AND R4, R4, #0x7F @consider only LSB 7 bits

SUB R4, #'0' @ subtract '0'
CMP R4, #1
BGT set_error
ORR R3, R4, LSL R2 @R3<- R4 << [R2]

B loop

set_error:
ORR R1, #0xFF
LDR R0, =ERROR @ load address of ERROR
STRB R1, [R0]@Store error @ERROR
B END

exit_loop:
store_result:
LDR R0, =NUMBER @ load address of NUMBER
STRB R3, [R0]@Store result @NUMBER

END: NOP @END
.end