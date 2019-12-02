// g++ ladder_game.s -lwiringPi -g -o ladder_game
.equ INPUT,0
.equ OUTPUT, 1
.equ LOW, 0
.equ HIGH, 1
.equ RED_LED, 26
.equ YELLOW_LED, 27
.equ GREEN_LED, 28
.equ BUTTON, 29

.text
.global main
main:
	push {lr}
	bl wiringPiSetup

	mov r0, #BUTTON
	mov r1, #INPUT
	bl pinMode

	//OUTPUTS CODE TO BREADBOARD
	mov r0, #RED_LED
	mov r1, #OUTPUT
	bl pinMode
	
	mov r0, #YELLOW_LED
	mov r1, #OUTPUT
	bl pinMode
	
	mov r0, #GREEN_LED
	mov r1, #OUTPUT
	bl pinMode

while_loop:
	mov r5, #0
	bl end_increment

increment:
	add r5, #1

end_increment:
	cmp r5, #5
	blge end_program

	mov r0, #BUTTON
	bl digitalRead	  
	cmp r0, #HIGH
	bne next	 //not equal, go to
	bleq end_while_loop

next:
	mov r0, #RED_LED
	mov r1, #HIGH
	bl digitalWrite

	//DELAYS NECESSARY INBETWEEN VOLTAGES
	ldr r0, =#1000
	bl delay

	mov r0, #BUTTON
	bl digitalRead	  
	cmp r0, #HIGH
	bne then	 //not equal, go to
	beq end_while_loop
	
	ldr r0, =#1000
	bl delay

then:
	mov r0, #RED_LED
	mov r1, #LOW
	bl digitalWrite

	ldr r0, =#1000
	bl delay

	mov r0, #BUTTON
	bl digitalRead	  
	cmp r0, #HIGH
	bne increment	 //not equal, go to
	beq end_while_loop
	
end_while_loop:
	ldr r0, =#250
	bl delay
	
	//b while_loop_two
	b secondlight

//TURN ON SECOND LED----------------------------------------------------
secondlight:
	mov r0, #RED_LED
	mov r1, #HIGH
	bl digitalWrite
	
while_loop_two:
	mov r6, #0
	bl end_increment_two

increment_two:
	add r6, #1

end_increment_two:
	cmp r6, #5
	blge end_program

	mov r0, #BUTTON
	bl digitalRead	  
	cmp r0, #HIGH
	bne next_two	 //not equal, go to
	beq end_while_loop_two

next_two:
	mov r0, #YELLOW_LED
	mov r1, #HIGH
	bl digitalWrite

	//DELAYS NECESSARY INBETWEEN VOLTAGES
	ldr r0, =#750
	bl delay

	mov r0, #BUTTON
	bl digitalRead	  
	cmp r0, #HIGH
	bne then_two	 //not equal, go to
	beq end_while_loop_two

then_two:
	mov r0, #YELLOW_LED
	mov r1, #LOW
	bl digitalWrite

	ldr r0, =#750
	bl delay

	mov r0, #BUTTON
	bl digitalRead	  
	cmp r0, #HIGH
	bne increment_two	 //not equal, go to
	beq end_while_loop_two

end_while_loop_two:
	ldr r0, =#250
	bl delay
	
	b thirdlight
	
	
//TURN ON THIRD LED----------------------------------------------------	
thirdlight:
	mov r0, #YELLOW_LED
	mov r1, #HIGH
	bl digitalWrite
	
	b while_loop_three
	
while_loop_three:
	mov r7, #0
	bl end_increment_three

increment_three:
	add r7, #1

end_increment_three:
	cmp r7, #5
	blge end_program

	mov r0, #BUTTON
	bl digitalRead	  
	cmp r0, #HIGH
	bne next_three	 //not equal, go to
	bleq end_while_loop_three

next_three:
	mov r0, #GREEN_LED
	mov r1, #HIGH
	bl digitalWrite

	//DELAYS NECESSARY INBETWEEN VOLTAGES
	ldr r0, =#500
	bl delay

	mov r0, #BUTTON
	bl digitalRead	  
	cmp r0, #HIGH
	bne then_three	 //not equal, go to
	beq end_while_loop_three
	
	ldr r0, =#500
	bl delay

then_three:
	mov r0, #GREEN_LED
	mov r1, #LOW
	bl digitalWrite

	ldr r0, =#500
	bl delay

	mov r0, #BUTTON
	bl digitalRead	  
	cmp r0, #HIGH
	bne increment_three	 //not equal, go to
	beq end_while_loop_three
	
end_while_loop_three:
	ldr r0, =#500
	bl delay
	b end_program

end_program:
	//turns off all LEDs
	mov r0, #RED_LED
	mov r1, #LOW
	bl digitalWrite
	
	mov r0, #YELLOW_LED
	mov r1, #LOW
	bl digitalWrite
	
	mov r0, #GREEN_LED
	mov r1, #LOW
	bl digitalWrite

	mov r0, #0
	pop {pc}
/*
//can try something like this instead of the delay
mov r0, #0
bl time
mov r4, r0
*/
