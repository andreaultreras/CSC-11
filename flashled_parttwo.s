//This program makes the LED flash 5 times, if the button is pressed when the LED is lit is stays on for 5 seconds
//then ends the program.
.equ INPUT,0
.equ OUTPUT, 1
.equ LOW, 0
.equ HIGH, 1
.equ PIN, 26
.equ LED_PIN, 29	//button

.text
.global main
main:
	//sets up the LED and button
	push {lr}
	bl wiringPiSetup

	mov r0, #LED_PIN
	mov r1, #INPUT
	bl pinMode

	//OUTPUTS CODE TO BREADBOARD
	mov r0, #PIN 
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
	beq end_while_loop

next:
	mov r0, #PIN
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

then:
	mov r0, #PIN
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
	//keeps the LED on
	mov r0, #PIN
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#5000
	bl delay
	b end_program

end_program:
	mov r0, #PIN
	mov r1, #LOW
	bl digitalWrite

	mov r0, #0
	pop {pc}
