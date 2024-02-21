INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
promptSizeMsg     BYTE "What is the size N of Vector? > ", 0
promptValuesMsg   BYTE "What are the ", 0
valuesMsgEnd      BYTE " values in Vector? > ", 0
vector            SDWORD 50 DUP(?) ; Reserve space for 50 SDWORD integers
vectorSize        DWORD ?
inputBuffer       BYTE 11 DUP(0) ; Buffer for converting integers to string

.code
main PROC
    ; Prompt for the size of the vector
    mov edx, OFFSET promptSizeMsg
    call WriteString
    call ReadInt          ; Read the size into EAX
    mov vectorSize, eax   ; Store the size in vectorSize

    ; Ensure the size does not exceed the maximum allowed (50)
    cmp vectorSize, 50
    jle validSize
    mov vectorSize, 50

validSize:
    ; Print part of the prompt for values
    mov edx, OFFSET promptValuesMsg
    call WriteString
    ; Convert vectorSize to string and print
    mov eax, vectorSize
    call WriteDec
    ; Print the rest of the prompt for values
    mov edx, OFFSET valuesMsgEnd
    call WriteString

    ; Loop to read vector values
    mov ecx, vectorSize   ; ECX will serve as our loop counter
    mov esi, 0            ; ESI will serve as the index for storing values in the vector

readVectorLoop:
    test ecx, ecx         ; Check if we've read all values
    jz finishedReading    ; If yes, jump to the end of reading loop
    call ReadInt          ; Read a value from the user
    mov vector[esi * TYPE vector], eax ; Store the value in the vector
    add esi, 1            ; Increment the index for the next value
    loop readVectorLoop

finishedReading:
    ; Now, print the entire vector
    mov ecx, vectorSize   ; Set up the counter for printing loop
    mov esi, 0            ; Reset the index for accessing vector values

printVectorLoop:
    test ecx, ecx
    jz done               ; If all elements have been printed, we're done
    mov eax, vector[esi * TYPE vector] ; Load the current value into EAX
    call WriteInt         ; Print the value
    mov al, ' '           ; Load space character into AL
    call WriteChar        ; Print a space
    add esi, 1            ; Move to the next index
    loop printVectorLoop

done:
    call Crlf             ; Print a new line at the end

    exit
main ENDP

END main
