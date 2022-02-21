AREA RESET, DATA, READONLY
		EXPORT __Vectors
			
__Vectors	DCD 0x20001000
			DCD Reset_Handler
		ALIGN

; Array of integers indicate ISBN number
ARRAY	DCB 5 ,4 ,1 ,4 ,4 ,3 ,2 ,9 ,7 ,9

; =================================================|

	AREA MYCODE, CODE, READONLY
		ENTRY
		EXPORT Reset_Handler
			
Reset_Handler

START
	MOV R1, #1     		; i (counter)
	MOV R4, R1, #1 		; i+1
	
	; Load array to R2
	LDR R2, = ARRAY
	
	: sum var in R3
	MOV R3, #0 

ISBN_LOOP 
	;;;;;; first check if the number we scanning is less than 9 
	CMP R4, #9
	
	;;;;;; if we go more than 9 then -> END_ISBN_LOOP label
	BGT END_ISBN_LOOP
	
	;;;;;; load one byte from array -> R5 = array[i]
	LDRB R5,[R2,R1]
	
	;;;;;; R6 = i * R5(array[i])
	MUL R6, R5 ,R4
	
	;;;;;; add R6 result to the sum
	ADD R3, R3 ,R6
	
	;;;;;; increment counter
	ADD R1, R1 ,#1
	
	;;;;;; R4 = i+1
	ADD R4, R1 ,#1
	
	;;;;;; branch to ISBN_LOOP
	B ISBN_LOOP
	
END_ISBN_LOOP 	; if condition in ISBN_LOOP is true
	
	;;;;;; R8 = the first element in the array which is the check parity 
	LDRB R8, [R2]
	
	;;;;;; R9 = 11
	MOV R9, #11
	
	;;;;;; Divide sum / 11
	UDIV R10, R3, R9
	
	;;;;;; R11 = calculated divide * 11
	MUL R11, R10 ,R9
	
	SUB R12,R9,R11
	SUB R12, R9, R12
	
	;;;;;; check if the number is ISBN by compare with first barity
	CMP R12, R1
	END

