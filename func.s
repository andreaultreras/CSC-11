.section .data

prompt: .asciz "Enter three integers between 1 and 50: \n"
reply1: .asciz "You entered %d, %d, and %d\n"
reply2: .asciz "The smallest value is %d\n"
reply3: .asciz "The largest value is %d\n"
err_msg: .asciz "ERROR - Value not within range...\n"

pattern: .asciz "%d %d %d"

value1: .word 0
value2: .word 0
value3: .word 0

.section .text
.global main

.align 4
.text
main:
	push {lr}

	ldr r0, =prompt
	bl printf
	b get_integer

//	b min_three
//	b max_three

	pop {pc}

get_integer:
	//gets data from user
	ldr r0, =pattern
	ldr r1, =value1
	ldr r2, =value2
	ldr r3, =value3
	push {r3}
	bl scanf
	pop {r3}

	//loads data into register
	ldr r0, =reply1
	ldr r1, =value1
	ldr r1, [r1]
	ldr r2, =value2
	ldr r2, [r2]
	ldr r3, =value3
	ldr r3, [r3]

	//prints reply1
	push {r3}
	bl printf
	pop {r3}

	//branches to do while loop
	bl do_while

min_three:
	//loads data into the register
	ldr r1, =value1
	ldr r1, [r1]
	ldr r2, =value2
	ldr r2, [r2]
	ldr r3, =value3
	ldr r3, [r3]

	//finds the smallest number
	cmp r1, r2
	movle r4, r1	//if r1<r2, move r1 to r4
	movgt r4, r2	//if r1>r2, move r2 to r4

	cmp r3, r4
	movle r5, r3
	movgt r5, r4

	//outputs smallest number
	ldr r0, =reply2
	mov r1, r5
	bl printf

max_three:
	//loads data into register
	ldr r1, =value1
	ldr r1, [r1]
	ldr r2, =value2
	ldr r2, [r2]
	ldr r3, =value3
	ldr r3, [r3]

	//finds the largest number
	cmp r1, r2
	movgt r4, r1
	movle r4, r2

	cmp r3, r4
	movgt r5, r3
	movle r5, r4

	//outputs largest number
	ldr r0, =reply3
	mov r1, r5
	bl printf
	pop {pc}

err_out:
	//outputs error message if user input is invalid
	ldr r0, =err_msg
	bl printf

	//loops back to get_integer
	b get_integer

do_while://input validation

	//checks value1
	ldr r1, =value1
	ldr r1, [r1]
	cmp r1, #1
	blt err_out
	cmp r1, #50
	bgt err_out

	//checks value2
	ldr r2, =value2
	ldr r2, [r2]
	cmp r2, #1
	blt err_out
	cmp r2, #50
	bgt err_out

	//checks value3
	ldr r3, =value3
	ldr r3, [r3]
	cmp r3, #1
	blt err_out
	cmp r3, #50
	bgt err_out

	//branches to min_three
	bl min_three

