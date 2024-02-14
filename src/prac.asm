; Program Description: Generates and displays 5 random integers.
; Author: [Your Name]
; Creation Date: [Date]

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
         var1  int 5 DUP(?)      ; Define ceiling value for RandomRange
         array DWORD 5 DUP(0)    ; Array to store 5 random integers
         count DWORD 5           ; Number of integers to generate and print

.code
main PROC
    ; Initialize the random number generator
               call Randomize
    
    ; Fill the array with random numbers
               mov  ecx, count             ; Loop counter set to 5
               lea  esi, array             ; Load the address of the array into ESI
    fillArray: 
               call RandomRange, 1, 100    ; Generate random number between 1 and 100
               mov  [esi], eax             ; Store the random number in the array
               add  esi, 4                 ; Move to the next element in the array
               loop fillArray
    
    ; Print the array elements
               mov  ecx, count             ; Reset loop counter to 5 for printing
               lea  esi, array             ; Reset ESI to the start of the array
    printArray:
               mov  eax, [esi]             ; Move the current element into EAX
               call WriteInt               ; Print the integer
               call Crlf                   ; New line for each number
               add  esi, 4                 ; Move to the next element in the array
               loop printArray
    
               exit                        ; Exit the program
main ENDP

END main
