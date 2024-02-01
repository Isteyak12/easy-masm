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

.code
main    PROC
    mov  eax, 10000h
    add  eax, 40000h
    sub  eax, 20000h
    call DumpRegs
    exit
    
main ENDP
END  main