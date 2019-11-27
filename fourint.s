
 .section .data

prompt: .asciz "Enter four integer values: "

reply1: .asciz "You entered %d, %d, %d, %d.\n"
reply2: .asciz "The smallest value is %d\n"
reply3: .asciz "The largest value is %d\n"
reply4: .asciz "The sum of all the values is: %d\n"
reply5: .asciz "The average of the four variables is: %d\n"

//format pattern for scanf
pattern: .asciz "%d %d %d %d"

//where input values will be stored
value1: .word 0
value2: .word 0
value3: .word 0
value4: .word 0

.section .text
.global  main
main:
	push {lr}	//saves return address

	ldr r0, =prompt
	bl printf

	//stores input values
	ldr r0, =pattern
	ldr r1, =value1
	ldr r2, =value2
	ldr r3, =value3
	ldr r4, =value4
	push {r4}
	bl scanf
	pop {r4}

	//contains pointer to response message
	ldr r0, =reply1
	ldr r1, =value1
	ldr r1, [r1]
	ldr r2, =value2
	ldr r2, [r2]
	ldr r3, =value3
	ldr r3, [r3]
	ldr r4, =value4
	ldr r4, [r4]
	push {r4}
	bl printf
	pop {r4}

	//loads data into register
	ldr r1, =value1
	ldr r1, [r1]
	ldr r2, =value2
	ldr r2, [r2]
	ldr r3, =value3
	ldr r3, [r3]
	ldr r4, =value4
	ldr r4, [r4]
	//finds the smallest value
	cmp r1, r2
	movle r5, r1
	movgt r5, r2

	cmp r3, r4
	movle r6, r3
	movgt r6, r4

	cmp r5, r6
	movle r7, r5
	movgt r7, r6

	ldr r0, =reply2
	mov r1, r7
	bl printf

	//loads data into register
	ldr r1, =value1
	ldr r1, [r1]
	ldr r2, =value2
	ldr r2, [r2]
	ldr r3, =value3
	ldr r3, [r3]
	ldr r4, =value4
	ldr r4, [r4]
	//finds the largest value
	cmp r1, r2
	movgt r5, r1
	movle r5, r2

	cmp r3, r4
	movgt r6, r3
	movle r6, r4

	cmp r5, r6
	movgt r7, r5
	movle r7, r6

	ldr r0, =reply3
	mov r1, r7
	bl printf

	//loads data into register
	ldr r1, =value1
	ldr r1, [r1]
	ldr r2, =value2
	ldr r2, [r2]
	ldr r3, =value3
	ldr r3, [r3]
	ldr r4, =value4
	ldr r4, [r4]
	//the sum of all values
	ADD r10, r1, r2
	ADD r10, r10, r3
	ADD r10, r10, r4
	ldr r0, =reply4
	mov r1, r10
	bl printf

	//the average of  all values
	mov r2, r10, ASR #2
	ldr r0, =reply5
	mov r1, r2
	bl printf

	pop {pc}
