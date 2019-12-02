//urns on red LED, make its blink for 10 seconds then turns off
//RED LED FLASHING!!!! :))))))
.equ INPUT, 0
.equ OUTPUT, 1
.equ LOW, 0
.equ HIGH, 1
.equ PIN, 29 

.text
.global main
main:
    
	push {lr}
	bl wiringPiSetup //initialize the wiringpi library //MUST HAVE

	//OUTPUTS CODE TO BREADBOARD
	mov r0, #PIN //set the wpi 29 pin for output
	mov r1, #OUTPUT
	bl pinMode


	mov r5, #0
while_loop:
	cmp r5, #5
	blge end_while_loop	

	mov r0, #PIN
	mov r1, #LOW
	bl digitalWrite
	
	//DELAYS NECESSARY INBETWEEN VOLTAGES
	ldr r0, =#1000
	bl delay
	 
	mov r0, #PIN
	mov r1, #HIGH
	bl digitalWrite
	 
	ldr r0, =#1000
	bl delay
	 
	add r5, #1
	b while_loop 
	
end_while_loop:
	mov r0, #0 //return 0
	pop {pc}
