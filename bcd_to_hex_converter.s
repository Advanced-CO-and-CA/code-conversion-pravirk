
@ BSS section
.bss


.data
BCDNUM: .byte '9'
.byte '2'
.byte '5'        
.byte '2'
.byte '9' 
.byte '6' 
.byte '7'
.byte '9'
NUMBER: .byte '0'
.text

.globl main
main:

MOV R2, #8@used to keep count of the decimal place
EOR R3, R3@used to store result in decimal format
MOV R5, #10
LDR R0, =BCDNUM@ load start address of BCDNUM

loop: @loop one by one for all decimal places, 7 to 0
SUBS R2, #1
BMI exit_loop

LDRB R4, [R0], #1 @load digit(in ascii) for current decimal place
AND R4, R4, #0x0F @consider only LSB 4 bits

MOV R6, R2 @R6<-[R2], R6 stores the current decimal place

  loop_mul:@ R4 <- [R4] * 10 power[R6] 
  SUBS R6, #1 
  BMI exit_loop_mul
  MUL R4, R4, R5
  B loop_mul

  exit_loop_mul:
  ADD R3, R4 @ store 

B loop

exit_loop:
LDR R0, =NUMBER @ load address of NUMBER
STR R3, [R0]@Store result @NUMBER

END: NOP @END
.end