TITLE Program Template

; Program Description
; Author 
; Creation Date

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

; Description:  Copy value from bigEndian to littleEndian, reversing order of bytes
; Assignment: A06B 4.10 Programming Exercise
; Date: 3/17/2016

.data
bigEndian DWORD 1234ABCDh       ; Big endian format
littleEndian DWORD ?            ; Variable to store the little endian format
bigEndianMsg BYTE "bigEndian: ", 0
littleEndianMsg BYTE "littleEndian: ", 0

.code
main PROC
    ; Load the big-endian value
    mov eax, bigEndian
    
    ; Extract and move each byte to correct position
    mov ebx, eax          ; Copy eax to ebx
    and eax, 0FFh         ; Isolate lowest byte
    shl eax, 24           ; Shift to highest byte position
    mov littleEndian, eax ; Move to littleEndian
    
    mov eax, ebx          ; Restore original value
    and eax, 0FF00h       ; Isolate second byte
    shl eax, 8            ; Shift to second highest byte position
    or littleEndian, eax  ; Combine with littleEndian
    
    mov eax, ebx          ; Restore original value
    and eax, 0FF0000h     ; Isolate third byte
    shr eax, 8            ; Shift to second lowest byte position
    or littleEndian, eax  ; Combine with littleEndian
    
    mov eax, ebx          ; Restore original value
    and eax, 0FF000000h   ; Isolate highest byte
    shr eax, 24           ; Shift to lowest byte position
    or littleEndian, eax  ; Combine with littleEndian
    
    ; Display bigEndian
    mov edx, OFFSET bigEndianMsg
    call WriteString
    mov eax, bigEndian
    call WriteHex
    call Crlf
    
    ; Display littleEndian
    mov edx, OFFSET littleEndianMsg
    call WriteString
    mov eax, littleEndian
    call WriteHex
    call Crlf
    
    exit
main ENDP
END main
