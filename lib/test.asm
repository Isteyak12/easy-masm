INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib
; INCLUDE Irvine32.inc

.data
A SDWORD -543210           ; Declare A as a 32-bit signed integer and initialize with -543210
B SWORD -3210              ; Declare B as a 16-bit signed integer and initialize with -3210
C SDWORD ?                 ; Declare C as a 32-bit signed integer
D SBYTE ?                  ; Declare D as an 8-bit signed integer
promptC BYTE "Enter a 32-bit signed integer for C: ", 0
promptD BYTE "Enter an 8-bit signed integer for D: ", 0

.code
main PROC
    ; Prompt and read value for C
    mov edx, OFFSET promptC
    call WriteString
    call ReadInt
    mov C, eax

    ; Display the message and the value of C
    mov edx, OFFSET promptC ; Display the message again
    call WriteString
    mov eax, C              ; Move the value of C into eax
    call WriteInt           ; Display the value of C
    call Crlf               ; New line

    ; Prompt and read value for D
    mov edx, OFFSET promptD
    call WriteString
    call ReadInt
    movsx edx, al           ; Sign-extend the lower 8 bits of EAX to 32 bits and move to EDX
    mov D, dl               ; Move the lower 8 bits of EDX to D

    ; Display the message and the value of D
    mov edx, OFFSET promptD ; Display the message again
    call WriteString
    movzx eax, D            ; Zero-extend D to 32 bits and move to EAX
    call WriteInt           ; Display the value of D
    call Crlf               ; New line

    exit
main ENDP

END main
