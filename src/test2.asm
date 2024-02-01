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

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
bigEndian BYTE 12h, 34h, 56h, 78h
littleEndian DWORD ?             ; littleEndian should be DWORD to hold 4 bytes
bigEndianMsg BYTE "bigEndian = ", 0
littleEndianMsg BYTE "littleEndian = ", 0
hexDigits BYTE "0123456789ABCDEF"

.code
main PROC
    ; Reverse the order of bytes from bigEndian to littleEndian
    xor eax, eax                  ; Clear eax
    mov al, [bigEndian+3]
    mov littleEndian, eax         ; Move byte to littleEndian (first byte)

    xor eax, eax                  ; Clear eax
    mov al, [bigEndian+2]
    shl eax, 8                    ; Move al to the second byte position
    or littleEndian, eax          ; Combine with littleEndian

    xor eax, eax                  ; Clear eax
    mov al, [bigEndian+1]
    shl eax, 16                   ; Move al to the third byte position
    or littleEndian, eax          ; Combine with littleEndian

    xor eax, eax                  ; Clear eax
    mov al, [bigEndian]
    shl eax, 24                   ; Move al to the fourth byte position
    or littleEndian, eax          ; Combine with littleEndian

    ; Display bigEndian
    mov edx, OFFSET bigEndianMsg
    call WriteString
    mov ecx, 4                      ; Counter for loop
    mov esi, OFFSET bigEndian       ; Point esi to bigEndian
printBigEndian:
    movzx eax, byte ptr [esi]       ; Move byte to eax with zero-extension
    shr eax, 4                      ; Shift right to get the high nibble
    and eax, 0Fh                    ; Mask out everything but the low nibble
    mov al, hexDigits[eax]          ; Convert to hex digit
    call WriteChar
    movzx eax, byte ptr [esi]       ; Move byte to eax with zero-extension
    and eax, 0Fh                    ; Mask out everything but the low nibble
    mov al, hexDigits[eax]          ; Convert to hex digit
    call WriteChar
    inc esi                         ; Move to the next byte
    loop printBigEndian
    call Crlf

    ; Display littleEndian
    mov edx, OFFSET littleEndianMsg
    call WriteString
    mov eax, littleEndian
    call WriteHex
    call Crlf

    INVOKE ExitProcess,0
main ENDP
END main
