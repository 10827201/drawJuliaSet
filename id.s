        .data
msg1:    .asciz "*****Input ID*****\n"
msgM:   .asciz "**Please Enter Number %d ID:**\n"
msgC:   .asciz "**Please Enter Command **\n"
msgA:   .asciz "*****Print Team Member ID and ID Summation*****\n"
msgS:   .asciz "ID Summation = %d\n"
msgE:   .asciz "*****End Print*****\n"
sID:    .asciz "%d"
sCOM:   .asciz "%c"
pID:    .asciz "%d\n"
ID1:    .word 0
ID2:    .word 0
ID3:    .word 0
sum:    .word 0
com:    .word 0
p:      .word 112
P:      .word 80

        .text
        .global id
id:         stmfd sp!, {r4-r10,lr}
            mov r5, r0
			mov r10, r5
            ldr r0, =msg1 @printf msg1
            bl  printf
            mov r4, #0

            ldr r0, =msgM @printf msgM
            mov r1, #1
            bl  printf
            ldr r0, =sID @scan ID1
            ldr r1, =ID1
            bl  scanf
            ldr r2, =ID1
            ldr r2, [r2]
            add r4, r4, r2
            str r2, [r10],#4 @word in r2 at the address r5

            ldr r0, =msgM @printf msgM
            mov r1, #2
            bl  printf
            ldr r0, =sID @scan ID2
            ldr r1, =ID2
            bl  scanf
            ldr r2, =ID2
            ldr r2, [r2]
            add r4, r4, r2
            str r2, [r10] @store word in r2 at the address r5

            ldr r0, =msgM @printf msgM
            mov r1, #3
            bl  printf
            ldr r0, =sID @scan ID3
            ldr r1, =ID3
            bl  scanf
            ldr r2, =ID3
            ldr r2, [r2]
            add r4, r4, r2
            ldr r6, =sum
            str r4, [r6]
            ldr r6, [r6]
            str r2, [r10, #4]! @store word in r2 at the address r5
            str r6, [r5, #12]

            ldr r0, =sCOM @scan G
            ldr r1, =com
            bl  scanf

            ldr r0, =msgC @print msg2
            bl  printf

            ldr r0, =sCOM @scan Command
            ldr r1, =com
            bl  scanf

            ldr r0, =p @print all information
            ldr r0, [r0]
            ldr r1, =com
            ldr r1, [r1]
            cmp r0, r1
            bne if_P
            beq after


if_P:       ldr r0, =P
            ldr r0, [r0]
            cmp r0, r1
            beq after
            ldrne r0, =msgE
            bl  printf
            ldmfd   sp!, {r4-r10,lr}
            mov pc, lr


after:      ldr r0, =msgA
            bl  printf
            mov r4, #0

loop :      ldr r0, =pID @print ID1 r2
            ldr r1, [r5, r4, lsl #2] @load r2 with word at the address r5
            bl  printf
            add r4, r4, #1
            cmp r4, #3
            blt loop

            ldrge r0, =msgS
            mov r1, r6      @store the sum in r6
            bl  printf
            ldr r0, =msgE
            bl  printf


            ldmfd   sp!, {r4-r10,lr}
            mov pc, lr




