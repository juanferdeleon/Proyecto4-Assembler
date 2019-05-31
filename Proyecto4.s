/*
		Proyecto 4
		Simon Dice

Creado por:

Juan  Fernando De Leon Quezada			Carne 17822
Mirka Nicolle Monzon				Carne 18139

*/

.data
.align 2
.global myloc, cadena

myloc: .word 0

.align 2
cadena: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
valoractual: .asciz "\nEl valor guardado es: %d\n"

.text
.align 2
.global main
.type main, %function

main:

	STMFD sp!, {lr}

	BL GetGpioAddress				@Llama a la biblioteca GPIO

	/*GPIO para entrada puerto 13*/			@AMARILLO ENTRADA
	MOV r0, #13
	MOV r1, #0
	BL SetGpioFunction

	/*GPIO para entrada puerto 6*/			@AZUL ENTRADA
	MOV r0, #6
	MOV r1, #0
	BL SetGpioFunction

	/*GPIO para entrada puerto 5*/			@VERDE ENTRADA
	MOV r0, #5
	MOV r1, #0
	BL SetGpioFunction

	/*GPIO para entrada puerto 11*/			@ROJO ENTRADA
	MOV r0, #11
	MOV r1, #0
	BL SetGpioFunction

	/*GPIO para salida puerto 26*/			@AMARILLO SALIDA
	MOV r0,#26
	MOV r1,#1
	BL SetGpioFunction

	/*GPIO para salida puerto 19*/			@AZUL SALIDA
	MOV r0,#19
	MOV r1,#1
	BL SetGpioFunction

	/*GPIO para salida puerto 9*/			@VERDE SALIDA
	MOV r0,#9
	MOV r1,#1
	BL SetGpioFunction

	/*GPIO para salida puerto 10*/			@ROJO SALIDA
	MOV r0,#10
	MOV r1,#1
	BL SetGpioFunction

	/*GPIO para entrada puerto 22*/			@RESET BUTTON
	MOV r0,#22
	MOV r1,#0
	BL SetGpioFunction

	BL off

	MOV r12, #0					@R12 RANDOM

	MOV r11, #0					@R11 Turno de jugador o secuencia

	MOV r10, #0

	LDR r10, =cadena				@R10 Direccion base de arreglo

	MOV r9, #0					@R9 Contador turno

	MOV r8, #0					@R8 contador de la secuencia

	MOV r7, #0					@Tiene el color actual

	B juego

fin:
	MOV r0, #0
	MOV r3, #0
	LDMFD sp!, {lr}
	BX lr

off:
	PUSH {lr}

							@GPIO 26 off el led
	mov r0,#26
	mov r1,#0
	bl SetGpio

							@GPIO 19 off el led
	mov r0,#19
	mov r1,#0
	bl SetGpio

							@GPIO 9 off el led
	mov r0,#9
	mov r1,#0
	bl SetGpio

							@GPIO 10 off el led
	mov r0,#10
	mov r1,#0
	bl SetGpio

	POP {pc}
