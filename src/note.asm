TITLE
 
INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
 
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib
 
.data
    vector BYTE "Isht"
 
 
.code
main PROC
 
         mov  eax,vector
         mov  ecx, 3
 
    l1:  
         cmp  eax, 100
         call WriteInt
         add  esi, 4
         loop l1
 
main ENDP
END main
 

; Program Description: Generates and displays 5 random integers.
; Author: [Your Name]
; Creation Date: [Date]

; INCLUDE Irvine32.inc
; INCLUDELIB Irvine32.lib

; ; these two lines are only necessary if you're not using Visual Studio
; INCLUDELIB kernel32.lib
; INCLUDELIB user32.lib

; .data
;          val1 DWORD 10
;          val2 DWORD 20

; .code
; main PROC
;          mov  eax, val1
;          mov  ebx, val2

; .IF eax < ebx
;          call WriteInt
;     ; Code to execute if eax is less than ebx
;     ; For example, print "eax is less than ebx"
; .ELSE
;     ; Code to execute if eax is not less than ebx
;     ; For example, print "eax is not less than ebx"
; .ENDIF

;           exit
; main ENDP
   
 
; END main

; ; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;      ; Prompt and read the start index I
;                            mov  edx, OFFSET promptI
;                            call WriteString
;                            call ReadInt
;                            mov  I, eax

;      ; Prompt and read the end index J
;                            mov  edx, OFFSET promptJ
;                            call WriteString
;                            call ReadInt
;                            mov  J, eax

;      ; Load I and J into registers and compare
;                            mov  eax, I
;                            mov  ebx, J
;                            cmp  eax, ebx
;                            jg   inputError                         ; If I is greater than J, go to error
;                            cmp  ebx, VectorSize
;                            ja   inputError                         ; If J is greater than VectorSize, go to error

;      ; Calculate the offset for the starting index I
;                            dec  eax                                ; Adjust EAX (I) for zero-based indexing
;                            mov  esi, OFFSET Vector                 ; ESI points to the start of the Vector array
;                            imul eax, TYPE Vector                   ; Multiply the index by the size of each element
;                            add  esi, eax                           ; ESI now points to the Ith element

;      ; Calculate the range for the minimum search
;                            sub  ebx, eax                           ; Subtract I from J (in EBX) for the range
;                            inc  ebx                                ; Include J in the range

;      ; Find the minimum value in the specified range
;                            mov  eax, [esi]                         ; Load the Ith element into EAX
;                            mov  Minimum, eax                       ; Assume the first checked value is the minimum

;      find_minimum:         
;                            add  esi, TYPE Vector                   ; Move to the next element in the array
;                            dec  ebx                                ; Decrement the loop counter
;                            jz   end_loop                           ; If this is the last iteration, skip to end
;                            mov  eax, [esi]                         ; Load the current element into EAX
;                            cmp  Minimum, eax                       ; Compare current minimum with the new value
;                            jle  find_minimum                       ; If Minimum <= eax, continue loop
;                            mov  Minimum, eax                       ; New minimum found, update Minimum
;                            jmp  find_minimum                       ; Continue loop

;      end_loop:             
;      ; Output the minimum value found
;                            mov  eax, Minimum
;                            call WriteInt                           ; Display the minimum value
;                            call Crlf
;                          ;   jmp  end_program                        ; Go to the end of the program

;      inputError:           
;      ; Output an error message
;                            mov  edx, OFFSET inputErrorMsg
;                            call WriteString

;      ; end_program:          
;      ;                       exit

