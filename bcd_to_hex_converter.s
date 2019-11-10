
@ BSS section
.bss


.data
BCDNUM: .word 0x92529679
NUMBER: .byte 0
.text

.globl main
main:

MOV R2, #8@used to keep count of the decimal place
EOR R3, R3@used to store result in decimal format
MOV R5, #0xF
MOV R7, #10
LDR R0, =BCDNUM@ load address of BCDNUM
LDR R0, [R0]

loop: @loop one by one for all decimal places, 7 to 0
SUBS R2, #1
BMI exit_loop

LSL R1, R2, #2 @R1<-[R2]*4, R1 stores the number of bits 0xF needs to be left shifted to create mask
LSL R8, R5, R1 @R8<-[R5]<<[R1],create mask to extarct current decimal place digit
AND R4, R0, R8 @R4 <- R0 AND R8, AND by mask to get digit
LSR R4, R1@R4<- [R4]>>[R1], Right shift the digit to LSB 4 bits

MLA R3, R3, R7, R4@R3<- [R3] * 10 + [R4]

B loop

exit_loop:
LDR R0, =NUMBER @ load address of NUMBER
STR R3, [R0]@Store result @NUMBER

END: NOP @END
.end