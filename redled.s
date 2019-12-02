/*
	does it matter which bcm we use
	how do we set it up physically
*/
//RED LED FLASHING!!!! :))))))
.equ INPUT, 0
.equ OUTPUT, 1
.equ LOW, 0
.equ HIGH, 1
.equ PIN, 29 //place on the breadboard?
.text
.global main
main:
    
	push {lr}
	bl wiringPiSetup //initialize the wiringpi library //MUST HAVE

	//OUTPUTS CODE TO BREADBOARD
	mov r0, #PIN //set the wpi 29 pin for output
	mov r1, #OUTPUT
	bl pinMode

	//SENDS VOLTAGE, TURNS ON
	mov r0, #PIN
	mov r1, #HIGH
	bl digitalWrite

	//KEEPS LED ON FOR 2 SECONDS
	//ldr r0, =#2000, this one or mov works
	mov r0, #2000
	bl delay
	
	//TAKES AWAY VOLTAGE, TURNS OFF LED
	mov r0, #PIN //writes low voltage to wpi 21 to turn off the led
	mov r1, #LOW
	bl digitalWrite
	
	//KEEPS LED OFF FOR 2 SECONDS
	ldr r0, =#2000
	bl delay

for_loop_start: //KEEPS LED FLASHING
	 mov r0, #PIN
	 mov r1, #HIGH
	 bl digitalWrite
	
	//DELAYS NECESSARY INBETWEEN VOLTAGES
	 ldr r0, =#2000
	 bl delay
	 
	 mov r0, #PIN
	 mov r1, #LOW
	 bl digitalWrite
	 
	ldr r0, =#2000
	bl delay
	 
	b for_loop_start
	 
	mov r0, #0 //return 0
	pop {pc}
