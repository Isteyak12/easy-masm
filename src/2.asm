INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
         promptMsg BYTE "Enter N: ", 0
         outputMsg BYTE "Fibonacci sequence with N = ", 0dh,0ah,0
         spaceChar BYTE " ",0
         fib0      DWORD 0
         fib1      DWORD 1
         temp      DWORD ?

.code
main PROC
    ; Prompt and read N
               mov  edx, OFFSET promptMsg
               call WriteString
               call ReadInt                  ; Read N into EAX
               mov  ebx, eax                 ; Move N into EBX for later use

    ; Print the initial part of the message
               mov  edx, OFFSET outputMsg
               call WriteString
               mov  eax, ebx                 ; Move N back into EAX to print it
               call WriteDec

    ; Check for N = 0 or 1 as special cases
               cmp  ebx, 0
               je   finish
               cmp  ebx, 1
               je   print_fib0

    ; Print the first two Fibonacci numbers (0 and 1) if N > 1
               mov  eax, fib0
               call WriteDec
               mov  edx, OFFSET spaceChar
               call WriteString              ; Print a space
               mov  eax, fib1
               call WriteDec

    ; Main loop to calculate and print Fibonacci numbers
               mov  ecx, ebx                 ; Counter set to N
               sub  ecx, 2                   ; Adjust for the loop, since we already printed the first 2 numbers

    fibLoop:   
    ; Calculate next Fibonacci number
               mov  eax, fib0
               add  eax, fib1
               mov  temp, eax                ; Store next Fibonacci number in temp

    ; Update Fibonacci numbers
               mov  eax, fib1
               mov  fib0, eax
               mov  eax, temp
               mov  fib1, eax

    ; Print next Fibonacci number
               mov  edx, OFFSET spaceChar
               call WriteString              ; Print a space
               mov  eax, temp
               call WriteDec

               loop fibLoop                  ; Repeat for next number

    finish:    
               call Crlf                     ; New line at the end
               exit

    print_fib0:                              ; Special case to print Fib(0) = 0 when N = 1
               mov  eax, fib0
               call WriteDec
               jmp  finish

main ENDP
END main
