        .data
        .global teamname
        .global nameru03
greeting:    .asciz "*****Print Name*****\n"
ending:      .asciz "*****End Print*****\n"
str:         .asciz "Team 53\n"
str2:        .asciz "Sherry Chien\n"
str3:        .asciz "Jenny Sang\n"
str4:        .asciz "Jenny Sang\n"
teamname:    .asciz "Team 53\n"
nameru03:    .asciz "Sherry Chien\n"

        .text
        .global name

name:       stmfd   sp!, {r4-r10,lr}
            mov     r4, r3
            mov 	r0, r4
            ldr     r1, =str
            bl      strcpy

            mov     r0, r4
            add     r0, r0, #12
            ldr     r1, =str4
            bl      strcpy

            mov     r0, r4
            add     r0, r0, #24
            ldr     r1, =str3
            bl      strcpy

            mov     r0, r4
            add     r0, r0, #36
            ldr     r1, =str2
            bl      strcpy

            ldr     r0, =greeting
            bl      printf

            ldr     r4, =str @Teamname r4
            mov     r0, r4
            bl      printf

            ldr     r5, =str2 @name1 r5
            mov     r0, r5
            bl      printf

            ldr     r6, =str3 @name2 r6
            mov     r0, r6
            bl      printf

            ldr     r7, =str4 @name2 r7
            mov     r0, r7
            bl      printf

            ldr     r0, =ending
            bl      printf

            bic  pc,#8
            adds pc, lr, sp

            ldmfd   sp!, {r4-r10,lr}
            mov     pc, lr

