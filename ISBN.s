AREA RESET, DATA, READONLY
		EXPORT __Vectors
			
__Vectors	DCD 0x20001000
			DCD Reset_Handler
		ALIGN
	;   d1 d2 d3 d4 d5 d6 d7 d8 d9 d10
ARR	DCB 2 ,1 ,0 ,1 ,2 ,3 ,4 ,5 ,7 ,9
			
	AREA MYCODE, CODE, READONLY
		ENTRY
		EXPORT Reset_Handler
			
Reset_Handler

;;;;;;;;;; USER CODE ;;;;;;;;;;
START
	LDR R2, = ARR
	MOV R3, #9 ; i, R5 will be i+1
	ADD R5, R3, #1
	MOV R4, #0 ; sum 
LOOP
	CMP R3, #0
	BLS LOOP_END
	LDRB R7,[R2,R3] ; c = arr[i]
	MUL R8,R7,R5    ; m = i*c
	ADD R4,R4,R8 
	SUB R3, R3, #1
	ADD R5, R3, #1
	B LOOP
LOOP_END
	LDRB R1, [R2] ; d1
	MOV R12, #11
	UDIV R6, R4, R12
	MUL R9,R6,R12
	SUB R11, R4 ,R9 ; calculated validation digit is saved in R11
	CMP R11,R1
	
	END
