INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
userInput BYTE 129 DUP(0) ; Allocate space for 128 characters + null terminator
promptMsg BYTE "Please enter a string (max 128 characters): ", 0

.code
main PROC
    ; Display prompt message
    mov edx, OFFSET promptMsg
    call WriteString

    ; Read string from user
    mov edx, OFFSET userInput
    mov ecx, SIZEOF userInput - 1 ; Limit input to 128 characters
    call ReadString

    ; Convert lowercase to uppercase and uppercase to lowercase
    mov esi, OFFSET userInput  ; ESI points to the start of the string

convertLoop:
    mov al, [esi]              ; Load the current character into AL
    test al, al                ; Test if the current character is the null terminator (0)
    jz   prepareReverse        ; If we've hit the null terminator, prepare for reversal
    
    ; Check if the character is lowercase (a-z)
    cmp  al, 'a'
    jb   checkUppercase
    cmp  al, 'z'
    ja   checkUppercase
    ; Convert to uppercase
    sub  al, 32
    mov  [esi], al
    jmp  nextChar

checkUppercase:
    ; Check if the character is uppercase (A-Z)
    cmp  al, 'A'
    jb   nextChar
    cmp  al, 'Z'
    ja   nextChar
    ; Convert to lowercase
    add  al, 32
    mov  [esi], al

nextChar:
    inc  esi                   ; Move to the next character
    jmp  convertLoop           ; Continue the loop

prepareReverse:
    dec  esi                   ; Move back to the last valid character (before null terminator)
    mov  edi, OFFSET userInput ; EDI points to the start of the string
reverseLoop:
    cmp  edi, esi              ; Check if pointers have met or crossed
    jge  displayConverted      ; If so, we're done reversing
    mov  al, [edi]             ; Swap characters pointed to by EDI and ESI
    mov  bl, [esi]
    mov  [edi], bl
    mov  [esi], al
    inc  edi                   ; Move EDI forward
    dec  esi                   ; Move ESI backward
    jmp  reverseLoop           ; Continue the loop

displayConverted:
    ; Display the converted and reversed string
    mov edx, OFFSET userInput ; Point EDX to the buffer where the converted input was stored
    call WriteString          ; Write the converted string to the console
    call Crlf                 ; New line for clean output

    exit                      ; Exit the program
main ENDP

END main
