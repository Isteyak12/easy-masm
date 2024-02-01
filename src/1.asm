INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
A SDWORD -543210                ; Initialize A as a 32-bit signed integer with -543210
B SWORD -3210                   ; Initialize B as a 16-bit signed integer with -3210
varC SDWORD ?                      ; Declare C as a 32-bit signed integer
D SBYTE ?                       ; Declare D as an 8-bit signed integer
Z SDWORD ?                      ; Declare Z to hold the result of the expression

promptC BYTE "What is the value of C? ", 0
promptD BYTE "What is the value of D? ", 0
expressionMsg BYTE "Z = (A - B) - (C - D)", 0Ah, 0 ; 0Ah is newline
resultFormat BYTE "A ;   B ;   C ;   D", 0Ah, 0    ; 0Ah is newline

.code
main PROC
    ; Initialize registers
    mov eax, A
    movsx ebx, B
    sub eax, ebx

    ; Prompt and read value for C
    mov edx, OFFSET promptC
    call WriteString
    call ReadInt
    mov varC, eax

    ; Display the value of C beside the message
    call WriteInt
    call Crlf

    ; Prompt and read value for D
    mov edx, OFFSET promptD
    call WriteString
    call ReadInt
    movsx edx, al
    mov D, dl

    ; Display the value of D beside the message
    movzx eax, D
    call WriteInt
    call Crlf

    ; Compute (C - D)
    mov eax, varC
    sub eax, edx

    ; Compute (A - B) - (C - D)
    mov ebx, eax
    mov eax, A
    movsx ecx, B
    sub eax, ecx
    sub eax, ebx
    mov Z, eax

    ; Display the expression
    mov edx, OFFSET expressionMsg
    call WriteString

    ; Display the values of A, B, C, D
    mov eax, A
    call WriteInt
    call WriteString ; Write " ;   "
    movsx eax, B
    call WriteInt
    call WriteString ; Write " ;   "
    mov eax, varC
    call WriteInt
    call WriteString ; Write " ;   "
    movzx eax, D
    call WriteInt
    call Crlf

    ; Display an empty line
    call Crlf

    ; Display the final result contained in variable Z
    mov eax, Z
    mov edx, OFFSET resultFormat
    call WriteString ; Write "Binary: "
    call WriteBin
    call Crlf
    mov eax, Z
    call WriteString ; Write "Decimal: "
    call WriteInt
    call Crlf
    mov eax, Z
    call WriteString ; Write "Hexadecimal: "
    call WriteHex
    call Crlf

    exit
main ENDP

END main
