TITLE   Program Template

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib
; INCLUDE Irvine32.inc

; INCLUDE Irvine32.inc
; INCLUDELIB Irvine32.lib

.data
inputLittleEndian DWORD 1234ABCDh    ; Input value in little-endian format
outputBigEndian DWORD ?              ; Variable to store the value in big-endian format
inputLittleEndianMsg BYTE "Input (Little-Endian): ", 0
outputBigEndianMsg BYTE "Output (Big-Endian): ", 0

.code
main PROC
    ; Load the input value (treated as little-endian)
    mov eax, inputLittleEndian
    
    ; Extract and move each byte to reverse their order (convert to big-endian)
    mov ebx, eax          ; Copy eax to ebx
    and eax, 0FFh         ; Isolate lowest byte
    shl eax, 24           ; Shift to highest byte position
    mov outputBigEndian, eax  ; Move to outputBigEndian
    
    mov eax, ebx          ; Restore original value
    and eax, 0FF00h       ; Isolate second byte
    shl eax, 8            ; Shift to second highest byte position
    or outputBigEndian, eax   ; Combine with outputBigEndian
    
    mov eax, ebx          ; Restore original value
    and eax, 0FF0000h     ; Isolate third byte
    shr eax, 8            ; Shift to second lowest byte position
    or outputBigEndian, eax   ; Combine with outputBigEndian
    
    mov eax, ebx          ; Restore original value
    and eax, 0FF000000h   ; Isolate highest byte
    shr eax, 24           ; Shift to lowest byte position
    or outputBigEndian, eax   ; Combine with outputBigEndian
    
    ; Display the input (little-endian)
    mov edx, OFFSET inputLittleEndianMsg
    call WriteString
    mov eax, inputLittleEndian
    call WriteHex
    call Crlf
    
    ; Display the result (big-endian)
    mov edx, OFFSET outputBigEndianMsg
    call WriteString
    mov eax, outputBigEndian
    call WriteHex
    call Crlf
    
    exit
main ENDP
END main
