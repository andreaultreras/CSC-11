//this program has the LED flash on and off. if the button is pressed when the LED is on it keeps that LED on
//and turns on the next LED. That LED will blink to, if it is pressed when on it will stay on
.equ INPUT,0
.equ OUTPUT, 1
.equ LOW, 0
.equ HIGH, 1
.equ PIN_ONE, 26
.equ PIN_TWO, 27
.equ PIN_THREE, 28
.equ LED_PIN, 29

.text
.global main
main:
	push {lr}
	bl wiringPiSetup

	mov r0, #LED_PIN
	mov r1, #INPUT
	bl pinMode

	//OUTPUTS CODE TO BREADBOARD
	mov r0, #PIN_ONE
	mov r1, #OUTPUT
	bl pinMode
	
	mov r0, #PIN_TWO
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

	mov r0, #LED_PIN
	bl digitalRead	  
	cmp r0, #HIGH
	bne next	 //not equal, go to
	bleq end_while_loop

next:
	mov r0, #PIN_ONE
	mov r1, #HIGH
	bl digitalWrite

	//DELAYS NECESSARY INBETWEEN VOLTAGES
	ldr r0, =#1000
	bl delay

	mov r0, #LED_PIN
	bl digitalRead	  
	cmp r0, #HIGH
	bne then	 //not equal, go to
	beq end_while_loop
	
	ldr r0, =#1000
	bl delay

then:
	mov r0, #PIN_ONE
	mov r1, #LOW
	bl digitalWrite

	ldr r0, =#1000
	bl delay

	mov r0, #LED_PIN
	bl digitalRead	  
	cmp r0, #HIGH
	bne increment	 //not equal, go to
	beq end_while_loop
	
end_while_loop:
	/*mov r0, #PIN_ONE
	mov r1, #HIGH
	bl digitalWrite*/
	
	ldr r0, =#1000
	bl delay
	
	b while_loop_two

//TURN ON SECOND LED----------------------------------------------------
secondlight:
	mov r0, #PIN_ONE
	mov r1, #HIGH
	bl digitalWrite
	
	/*ldr r0, =#10000
	bl delay*/
	
while_loop_two:
	mov r6, #0
	bl end_increment_two

increment_two:
	add r6, #1

end_increment_two:
	cmp r6, #5
	blge end_program

	mov r0, #LED_PIN
	bl digitalRead	  
	cmp r0, #HIGH
	bne next_two	 //not equal, go to
	beq end_while_loop_two

next_two:
	mov r0, #PIN_TWO
	mov r1, #HIGH
	bl digitalWrite

	//DELAYS NECESSARY INBETWEEN VOLTAGES
	ldr r0, =#1000
	bl delay

	mov r0, #LED_PIN
	bl digitalRead	  
	cmp r0, #HIGH
	bne then_two	 //not equal, go to
	beq end_while_loop_two

then_two:
	mov r0, #PIN_TWO
	mov r1, #LOW
	bl digitalWrite

	ldr r0, =#1000
	bl delay

	mov r0, #LED_PIN
	bl digitalRead	  
	cmp r0, #HIGH
	bne increment_two	 //not equal, go to
	beq end_while_loop_two

end_while_loop_two:
	mov r0, #PIN_TWO
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#5000
	bl delay
	b end_program
	
end_program:
	mov r0, #PIN_ONE
	mov r1, #LOW
	bl digitalWrite
	
mov r0, #PIN_TWO
	mov r1, #LOW
	bl digitalWrite

	mov r0, #0
	pop {pc}

