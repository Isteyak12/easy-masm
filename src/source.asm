TITLE   Program Template

;Program Description
;Author 
;Creation Date

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data

	myArray DWORD 11h,22h,333h,44h, 55h, 66h, 77h, 88h, 99h, 0aah
	mySum WORD ?

.code
main PROC
	
	mov ecx, LENGTHOF myArray	; length of array
	mov ebx, SIZEOF myArray	; size of array in number 									of bytes
	mov edx, OFFSET myARRAY	; logical address of first 									element stored in edx

	mov ecx,(LENGTHOF myArray+1)/2 	; loop counter
	mov edi,0 					; edi will be used as 									array index
	mov eax,0 					; clear the accumulator
	L1:
		add eax, myArray[edi] 	; add current array element
		add edi,TYPE myArray * 2 	; point to alternate 							elements (i.e. skip next element)
		loop L1 				; repeat until ECX = 0

	; store the sum in mySum
	mov mySum, ax 	; Assume sum can fit in 16 bits				
	call DumpRegs
	
exit
main ENDP
END main
