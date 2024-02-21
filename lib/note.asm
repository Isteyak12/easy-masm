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