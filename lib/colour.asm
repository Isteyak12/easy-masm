TITLE   Program Template

; Program Description
; Author 
; Creation Date

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
str1 BYTE "Color output is easy!",0
yellow EQU 14     ; Color attribute for yellow
blue EQU 1        ; Color attribute for blue

.code
main PROC
     mov  eax, yellow + (blue * 16)  ; color attribute must be in EAX
     call SetTextColor
     mov  edx, OFFSET str1
     call WriteString
     call Crlf
     exit
main ENDP
END main
