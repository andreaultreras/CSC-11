//This program tells you the LED is on when the buttton is pressed and off when it is not.
.equ INPUT, 0
.equ OUTPUT, 1
.equ LOW, 0
.equ HIGH, 1
.equ LED_PIN, 29

.section .rodata
out_msg1: .asciz "Led should be on!\n"
out_msg2: .asciz "Led should be off!\n"

.text
.global main
main:
//int main()
	push {lr} //{
	bl wiringPiSetup

	mov r0, #LED_PIN 
	mov r1, #INPUT
	bl pinMode

do_while:
	mov r0, #LED_PIN
	bl digitalRead	  // r0 = digitalRead(LED_PIN)
	cmp r0, #HIGH	  // is r0 == HIGH (1)?
	bne continue_while  // no, go to continue_while

	ldr r0, =out_msg1 // output message that LED is on
	bl printf
	b do_while
	
continue_while:
	ldr r0, =out_msg2
	bl printf
	b do_while
	
end_do_while:
	mov r0, #0  //return 0
	pop {pc}//}
