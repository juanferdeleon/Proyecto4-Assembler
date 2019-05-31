/*
		Proyecto 4
		Simon Dice

Creado por:

Juan Fernando De Leon Quezada			Carne 17822
Mirka Nicolle Monzon				Carne 18139

*/

.data
.align 2
.global juego

juego:
	/*Juego principal*/

	CMP r11, #0				@Si R11 es 0 el juego devuelve una secuencia
	BLEQ secuencia

	CMP r11, #1				@Si R11 es 1 el jugador ingresa una secuencia
	BLEQ jugador

	B juego

jugador:

	PUSH {lr}

	/*Turno del juegador*/

	CMP r8, r9				@Verifica si hay mas colores por acertar
	BLEQ wait
	MOVEQ r8, #0				@En caso haya acertado todos vuelve 0 a r8
	MOVEQ r11, #0				@Sede el turno al simon
	POPEQ {pc}				@Regresa a subrutina juego

	/*Input LED 1 (AMARILLO)*/
	MOV r1, #13
	BL GetGpio
	BL cargar
	TEQ r5, #0
	BNE led1_in

	/*Input LED 2 (AZUL)*/
	MOV r1, #6
	BL GetGpio
	BL cargar
	TEQ r5, #0
	BNE led2_in

	/*Input LED 3 (VERDE)*/
	MOV r1, #5
	BL GetGpio
	BL cargar
	TEQ r5,#0
	BNE led3_in

	/*Input LED 4 (ROJO)*/
	MOV r1, #11
	BL GetGpio
	BL cargar
	TEQ r5, #0
	BNE led4_in

	/*RESET BUTTON*/
	MOV r1, #21
	BL GetGpio
	TEQ r5, #0
	BNE reset

	POP {lr}

	B jugador

led1_in:

	/*Enciende LED 1 (AMARILLO)*/
	CMP r7, #1				@Compara si el valor de r7 es igual a 1

	BEQ correcto

	BNE reset				@En caso no sea igual se reinicia el juego

correcto:

	ADD r8, r8, #4				@En caso sea igual agrega 4 a r8

	BL buzzerOn

	BL wait

	BL buzzerOff

	POP {lr}

	B jugador				@En caso sea igual vuelve a jugador


cargar:

	PUSH {lr}

	LDR r10, =cadena

	ADD r10, r10, r8			@R10 direccion base del arreglo de la secuencia

	LDR r7, [r10]				@R7 tendra el valor inmediato de la secuencia

/*
	LDR r0, =valoractual
	MOV r1, r7
	BL printf

*/
	POP {pc}



led2_in:

	/*Enciende LED 2 (AZUL)*/
	CMP r7, #2

	BEQ correcto

	BNE reset

led3_in:

	/*Enciende LED 3 (VERDE)*/
	CMP r7, #3

	BEQ correcto

	BNE reset

led4_in:

	/*Enciende LED 4 (ROJO)*/
	CMP r7, #4

	BEQ correcto

	BNE reset

reset:

	/*Reset del juego*/

	LDR r1, =display1
	MOV r0, #0
	STR r0, [r1]

	BL display1_0

	LDR r1, =display2
	MOV r0, #0
	STR r0, [r1]

	BL display2_0
						@GPIO 26 enciende led 1
	MOV r0, #26
	MOV r1, #1
	BL SetGpio

						@GPIO 19 enciende led 2
	MOV r0, #19
	MOV r1, #1
	BL SetGpio

						@GPIO 9 enciende led 3
	MOV r0, #9
	MOV r1, #1
	BL SetGpio

						@GPIO 10 enciende led 4
	MOV r0, #10
	MOV r1, #1
	BL SetGpio

	BL buzzerOn				@Enciende Buzzer

	BL wait					@Deja encendidos los 4 leds

	BL buzzerOff				@Apaga Buzzer

	BL wait

	BL off

	B main

secuencia:

	PUSH {lr}

	/*Secuencia de colores*/

	CMP r8, r9				@R8 contador de la secuencia
	BEQ nuevoColor

	LDR r10, =cadena
	ADD r10, r10, r8			@R10 direccion base del arreglo de la secuencia
	LDR r7, [r10]				@R7 tendra el valor inmediato de la secuencia

	CMP r7, #1
	BLEQ led1_out

	CMP r7, #2
	BLEQ led2_out

	CMP r7, #3
	BLEQ led3_out

	CMP r7, #4
	BLEQ led4_out

	POP {lr}

	B secuencia


verif:
	PUSH {lr}
	LDR r0, =valoractual
	MOV r1, r7
	BL printf
	POP {pc}




nuevoColor:

	MOV r11, #1				@Sede el turno al jugador

	BL displays

	/*Agrega un nuevo color a la secuencia*/

	MOV r12, #4				@Se pide un valor aleatorio entre 1 y 4 (por los cuatro colores)
	BL RANDOM

	LDR r10, =cadena

	CMP r12, #1				@Caso en que el numero sea 1 (AMARILLO)
	BLEQ led1_out

	CMP r12, #2				@Caso en que el numero sea 2 (AZUL)
	BLEQ led2_out

	CMP r12, #3				@Caso en que el numero sea 3 (VERDE)
	BLEQ led3_out

	CMP r12, #4				@Casp en que el numero sea 4 (ROJO)
	BLEQ led4_out


/*	BL verif

/*
	LDR r0, =valoractual
	MOV r1, r7
	BL printf
*/

	MOV r9, r8				@Asigna el turno de secuencia en el que se encuentra

	MOV r8, #0				@Reinicia el contador de la secuencia

	MOV r7, #0				@Reinicia el holder de secuencia actual

	POP {pc}


led1_out:

	PUSH {lr}

	/*LED 1(AMARILLO)*/
						@GPIO 26 enciende el led
	MOV r0, #26
	MOV r1, #1
	BL SetGpio

	BL buzzerOn				@Enciende Buzzer

	BL wait

	BL buzzerOff				@Apaga Buzzer

						@GPIO 26 apaga el led
	MOV r0, #26
	MOV r1, #0
	BL SetGpio
	BL wait

	/*Guarda el valor en el arreglo*/
	LDR r10, =cadena
	MOV r7, #1				@Asigna valor 1 al arreglo
	STR r7, [r10, r8]			@Guarda 1  en el arreglo

	ADD r8, r8, #4				@Agrega 4 a R8

	MOV r12, #0

	POP {pc}

led2_out:

	PUSH {lr}

	/*LED 2(AZUL)*/
						@GPIO 19 enciende el led
	MOV r0,#19
	MOV r1,#1
	BL SetGpio

	BL buzzerOn				@Enciende Buzzer

	BL wait

	BL buzzerOff				@Apaga Buzzer

						@GPIO 19 apaga el led
	MOV r0,#19
	MOV r1,#0
	BL SetGpio
	BL wait

	/*Guarda el valor en el arreglo*/
	LDR r10, =cadena
	MOV r7, #2				@Letra B(BLUE) en ascii decimal
	STR r7, [r10, r8]			@Guarda la letra B en el arreglo

	ADD r8, r8, #4				@Agrega 1 a R8

	MOV r12, #0

	POP {pc}

led3_out:

	PUSH {lr}

	/*LED 3 (VERDE)*/
						@GPIO 9 enciende el led
	MOV r0,#9
	MOV r1,#1
	BL SetGpio

	BL buzzerOn				@Enciende Buzzer

	BL wait

	BL buzzerOff				@Apaga Buzzer

						@GPIO 9 apaga el led
	MOV r0,#9
	MOV r1,#0
	BL SetGpio
	BL wait

	/*Guarda el valor en el arreglo*/
	LDR r10, =cadena
	MOV r7, #3				@Letra G(GREEN) en ascii decimal
	STR r7, [r10, r8]			@Guarda la letra G en el arreglo

	ADD r8, r8, #4				@Agrega 1 a R8

	MOV r12, #0

	POP {pc}

led4_out:

	PUSH {lr}

	/*LED 4 (ROJO)*/
						@GPIO 10 enciende el led
	MOV r0, #10
	MOV r1, #1
	BL SetGpio

	BL buzzerOn				@Enciende el Buzzer

	BL wait

	BL buzzerOff				@Apaga el Buzzer

						@GPIO 10 apaga el led
	MOV r0, #10
	MOV r1, #0
	BL SetGpio
	BL wait

	/*Guarda e; valor en el arreglo*/
	LDR r10, =cadena
	MOV r7, #4				@Letra R(RED) en ascii decimal
	STR r7, [r10, r8]			@Guarda la letra R en el arreglo

	ADD r8, r8, #4				@Agrega 1 a R8

	MOV r12, #0

	POP {pc}

wait:
	PUSH {lr}

	MOV r0, #1
	BL sleep
	NOP

	POP {pc}

buzzerOn:

	PUSH {lr}

	/*BUZZER ON*/
						@GPIO 18 Enciende el Buzzer
	MOV r0, #18
	MOV r1, #1
	BL SetGpio

	POP {pc}

buzzerOff:

	PUSH {lr}

	/*BUZZER OFF*/
						@GPIO 18 Aapaga el Buzzer
	MOV r0, #18
	MOV r1, #0
	BL SetGpio

	POP {pc}
