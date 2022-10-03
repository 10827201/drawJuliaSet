			.data
maxIter : 	.word 255
zx	:		.word 0
zy	:		.word 0
tmp	:		.word 0
i 	:		.word 0
cx	:		.word 0
cy	:		.word 0
width:		.word 0
height:		.word 0
color :		.hword 0
num1:		.word 1500
num2:		.word 4000000
			.text
			.global drawJuliaSet

drawJuliaSet :
			ldr		r4, =cx
			str		r0, [r4]
			ldr		r4, =cy
			str 	r1, [r4]
			ldr		r4, =width
			str 	r2, [r4]
			ldr		r4, =height
			str 	r3, [r4]
			ldr		r10,[sp]
			stmfd 	sp!, {lr}

			mov		r4, #0 @ x=0
			mov 	r5, #0 @ y=0

loopx :		ldr 	r0, =width
			ldr		r0, [r0]
			cmp		r4, r0 @ i < width
			mov 	r5, #0 @ y=0
			bge		done_x
			blt		loopy

loopy :		ldr 	r0, =height
			ldr 	r0, [r0]
			cmp 	r5, r0 @ j < height
			bge		done_y @>=
			@blt		after  @<

            ldrlt	r6, =num1
			ldr		r6, [r6]
			ldr 	r2, =width
			ldr		r2, [r2]
			mov		r7, r2, asr #1  @width >> 1
			sub 	r9, r4, r7 	@ x - width >> 1
			mul		r6, r6, r9
			mov		r0, r6
			mov		r1, r7
			bl		__aeabi_idiv
			ldr 	r6, =zx
			str		r0, [r6]

			mov		r7, #1000 @ zy
			ldr		r3, =height
			ldr     r3, [r3]
			mov     r0, #1
			mov 	r6, r3, asr r0 @ height >> 1
			sub		r9, r5, r6
			mul		r7, r7, r9
			mov		r0, r7
			mov 	r1, r6
			bl		__aeabi_idiv
			ldr 	r9, =zy
			str		r0, [r9]
			mov  	r8, #255 @i = maxIter

loop1:		ldr		r1, =zx
			ldr		r1, [r1]
			ldr		r2, =zy
			ldr		r2, [r2]
			mul 	r3, r1, r1
			mul		r0, r2, r2
			add		r3, r3, r0
			ldr     r0, =num2
			ldr		r0, [r0]
			cmp		r3, r0
			bge		docolor
			cmplt	r8, #0
			bgt		after2
			ble		docolor

after2:		ldr 	r0, =zx
			ldr 	r0, [r0]
			mul 	r7, r0, r0
			ldr 	r9, =zy
			ldr 	r9, [r9]
			mul 	r9, r9, r9
			sub		r9, r7, r9
			mov		r0, r9
			mov		r1, #1000
			bl		__aeabi_idiv
			ldr 	r1, =cx
			ldr 	r1, [r1]
			adds	r1, r0, r1
			ldr		r0, =tmp
			str		r1,	[r0]

			ldr		r0, =zx
			ldr		r0, [r0]
			ldr		r1, =zy
			ldr		r1, [r1]
			mul 	r9, r0, r1
			mov     r0, #2
			mul 	r9, r9, r0
			mov		r0, r9
			mov 	r1, #1000
			bl		__aeabi_idiv
			ldr 	r1, =cy
			ldr 	r1, [r1]
			add 	r1, r0, r1
			ldr     r0, =zy
			str 	r1, [r0]

			ldr		r0, =zx
			ldr		r1, =tmp
			ldr		r1, [r1]
			str		r1, [r0]

			sub		r8, r8, #1
			b 		loop1

docolor:	ldr     r2, =0xff
            and		r0, r8, r2
			lsl     r1, r0, #8
			ldr     r2, =color
			orr		r2, r1, r0
			mvn		r3, r2
			ldr     r6, =0xffff
			and		r2, r3, r6
			mov     r1, #640
			mul 	r0, r5, r1
			add		r0, r0, r4
			mov		r3, #2
			mul		r0, r0, r3
			strh	r2, [r10,r0]
			add		r5, r5, #1
			b 		loopy


done_y:		add		r4, r4, #1
			b		loopx

done_x:		subs    r0, lr, sp
            ldmfd   sp!, {lr}
            mov     pc, lr
