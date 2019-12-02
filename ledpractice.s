.equ INPUT, 0
.equ OUTPUT, 1	//turns on LED
.equ LOW, 0	//turns off LED
.equ HIGH, 1

.equ RED_PIN, 23
.equ GRN_PIN, 24

.equ UP_PIN, 29		//move up pin

.equ RED_ST, 0
.equ GRN_ST, 1

.equ PAUSE, 1000	//pause 250/1000 = 1/4 second

.global main
.text
main:
	//starts the program and lights up starting red
	push{lr}
	bl wiringPiSetup
	bl my_setup

	mov r4, #RED_ST //r4 holds our current state, start in RED
	mov r0, #RED_PIN
	bl pinOn
lp:
lp_next:
setPinInput:
	push {lr}
	mov r1, #INPUT
	bl pinMode
	pop {pc}

setPinOutput:
	push {lr}
	mov r1, #OUTPUT
	bl pinMode
	pop {pc}

pinOn://turns pin on
	push {lr}
	mov r1, #HIGH
	bl digitalWrite
	pop {pc}

pinOff://turns pin off
	push {lr}
	mov r1, #LOW
	bl digitalWrite
	pop {pc}

readUpButton:
	//reads the button that will advance to the next LED
	push {lr}
	mov r0, #UP_PIN
	bl digitalRead
	pop {pc}

/*action:
	//r0 holds pin to turn off, r1 holds pin to turn on
	push {lr}
	push {r1}
	bl pinOff
	pop {r0}
	bl pinOn
	pop {pc}*/

my_setup:
	//setsup pins
	push {lr}

	mov r0, #RED_PIN
	bl setPinOutput

	mov r0, #GRN_PIN
	bl setPinOutput

	pop {pc}
