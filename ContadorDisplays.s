/*
			Proyecto 4
			Simon Dice

Creado por:

Juan Fernando De Leon Quezada		Carne 17822
Mirka Nicolle Monzon			Carne 181

*/

.data
.align 2
.global displays, display1_0

displays:

	/*Valor desplegado por display 1*/
	LDR r0, =display1			@Carga el valor actual del display 1
	LDR r0, [r0]

	ADD r0, r0, #1				@Agrega uno al contador del display 1

	/*Despliega contador en display 1*/
	CMP r0, #1
	BEQ display1_1

	CMP r0, #2
	BEQ display1_2

	CMP r0, #3
	BEQ display1_3

	CMP r0, #4
	BEQ display1_4

	CMP r0, #5
	BEQ display1_5

	CMP r0, #6
	BEQ display1_6

	CMP r0, #7
	BEQ display1_7

	CMP r0, #8
	BEQ display1_8

	CMP r0, #9
	BEQ display1_9

	BGT resetDisplay1			@En caso el valor sea mayor de 9

resetDisplay1:

	BL display1_0

	/*Valor desplegado por display 2*/
/*	LDR r0, =display2			@Carga valor actual del display 2
	LDR r0, [r0]

	ADD r0, r0, #1				@Agrega uno al contador del display 2

	CMP r0, #1
	BEQ display2_1

	CMP r0, #2
	BEQ display2_2

	CMP r0, #3
	BEQ display2_3

	CMP r0, #4
	BEQ display2_4

	CMP r0, #5
	BEQ display2_5

	CMP r0, #6
	BEQ display2_6

	CMP r0, #7
	BEQ display2_7

	CMP r0, #8
	BEQ display2_8

	CMP r0, #9
	BEQ display2_9

	BGT display2_0
*/
guardarDisplay1:

	PUSH {lr}

	/*Guarda el valor en memoria*/
	LDR r1, =display1
	STR r0, [r1]

	POP {pc}

display1_1:

	PUSH {lr}

	BL guardarDisplay1

	/*Despliega 1 en display 1*/
							@Enciende el GPIO 20
	MOV r0, #20
	MOV r1, #1
	BL SetGpio
							@Apaga el GPIO 7
	MOV r0, #7
	MOV r1, #0
	BL SetGpio
							@Apaga el GPIO 12
	MOV r0, #12
	MOV r1, #0
	BL SetGpio
							@Apaga el GPIO 16
	MOV r0, #16
	MOV r1, #0
	BL SetGpio

	POP {pc}

display1_2:

	PUSH {lr}

	BL guardarDisplay1

	/*Despliega 2 en el display 1*/
							@Apaga GPIO 20
	MOV r0, #20
	MOV r1, #0
	BL SetGpio
							@Enciende GPIO 7
	MOV r0, #7
	MOV r1, #1
	BL SetGpio
							@Apaga GPIO 12
	MOV r0, #12
	MOV r1, #0
	BL SetGpio
							@Apaga GPIO 16
	MOV r0, #16
	MOV r1, #0
	BL SetGpio

	POP {pc}

display1_3:

	PUSH {lr}

	BL guardarDisplay1

	/*Despliega 3 en el display 1*/

	MOV r0, #20
	MOV r1, #1
	BL SetGpio

	MOV r0, #7
	MOV r1, #1
	BL SetGpio

	MOV r0, #12
	MOV r1, #0
	BL SetGpio

	MOV r0, #16
	MOV r1, #0
	BL SetGpio

	POP {pc}

display1_4:

	PUSH {lr}

	BL guardarDisplay1

	/*Despliega 4 en el display 1*/

	MOV r0, #20
	MOV r1, #0
	BL SetGpio

	MOV r0, #7
	MOV r1, #0
	BL SetGpio

	MOV r0, #12
	MOV r1, #1
	BL SetGpio

	MOV r0, #16
	MOV r1, #0
	BL SetGpio

	POP {pc}

display1_5:

	PUSH {lr}

	BL guardarDisplay1

	/*Despliega 5 en el display 1*/

	MOV r0, #20
	MOV r1, #1
	BL SetGpio

	MOV r0, #7
	MOV r1, #0
	BL SetGpio

	MOV r0, #12
	MOV r1, #1
	BL SetGpio

	MOV r0, #16
	MOV r1, #0
	BL SetGpio

	POP {pc}

display1_6:

	PUSH {lr}

	BL guardarDisplay1

	/*Despliega 6 en el display 1*/

	MOV r0, #20
	MOV r1, #0
	BL SetGpio

	MOV r0, #7
	MOV r1, #1
	BL SetGpio

	MOV r0, #12
	MOV r1, #1
	BL SetGpio

	MOV r0, #16
	MOV r1, #0
	BL SetGpio

	POP {pc}

display1_7:

	PUSH {lr}

	BL guardarDisplay1

	/*Despliega 7 en el display 1*/

	MOV r0, #20
	MOV r1, #1
	BL SetGpio

	MOV r0, #7
	MOV r1, #1
	BL SetGpio

	MOV r0, #12
	MOV r1, #1
	BL SetGpio

	MOV r0, #16
	MOV r1, #0
	BL SetGpio

	POP {pc}

display1_8:

	PUSH {lr}

	BL guardarDisplay1

	/*Despliega 8 en el display 1*/

	MOV r0, #20
	MOV r1, #0
	BL SetGpio

	MOV r0, #7
	MOV r1, #0
	BL SetGpio

	MOV r0, #12
	MOV r1, #0
	BL SetGpio

	MOV r0, #16
	MOV r1, #1
	BL SetGpio

	POP {pc}

display1_9:

	PUSH {lr}

	BL guardarDisplay1

	/*Despliega 9 en el display 1*/

	MOV r0, #20
	MOV r1, #1
	BL SetGpio

	MOV r0, #7
	MOV r1, #0
	BL SetGpio

	MOV r0, #12
	MOV r1, #0
	BL SetGpio

	MOV r0, #16
	MOV r1, #1
	BL SetGpio

	POP {pc}

display1_0:

	PUSH {lr}

	BL guardarDisplay1

	/*Despliega 0 en el display 1*/

	MOV r0, #20
	MOV r1, #0
	BL SetGpio

	MOV r0, #7
	MOV r1, #0
	BL SetGpio

	MOV r0, #12
	MOV r1, #0
	BL SetGpio

	MOV r0, #16
	MOV r1, #0
	BL SetGpio

	POP {pc}
