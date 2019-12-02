.equ INPUT,0
.equ OUTPUT, 1
.equ LOW, 0
.equ HIGH, 1
.equ PIN, 26
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

/*mov r0, #LED_PIN
bl digitalRead
mov r1, #PIN
cmp r0, r1
bne increment
beq end_while_loop*/

/*things to get done by wed:
	1. get LED to stay on if button is pressed when light is on
		a. are if statements possible? am i building it correctly?
		   how to cmp pins and buttons?
		b. ideas: do, blinking while button = low
		c. compare pin voltage to button voltage if equal LED stay on
		d. if not branch to loop or end
	2. get LED to keep blinking if button is pressed when LED is off 
	   or get program to end
	3. add a second LED
	4. get button to turn on second LED if pressed when 1st LED is on
	5. repeat number 2
*/
