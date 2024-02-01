INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib


.data
a   DWORD   20          ; First integer to add
b   DWORD   30          ; Second integer to add
sum DWORD   ?           ; Variable to store the sum

.code
main PROC
    ; Load the first operand into EAX
    mov eax, a
    
    ; Add the second operand to EAX
    add eax, b
    
    ; Store the result in 'sum'
    mov sum, eax
    
    ; Print the result
    mov eax, sum
    call WriteDec       ; Irvine32 procedure to print a decimal number
    call Crlf           ; Print a new line
    
    exit
main ENDP

END main
