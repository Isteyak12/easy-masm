INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib


.data
         Vector      SDWORD -1, 3, 17, 0, -100, -30, 2, -30, -100, 0, 17, 3, -1
         VectorSize  DWORD 13
         NegativeSum SDWORD 0

.code
main PROC
    ; Initialize registers
                 mov  esi, OFFSET Vector    ; ESI points to the start of the Vector
                 mov  ecx, VectorSize       ; ECX is the loop counter, set to the size of the Vector
                 mov  eax, 0                ; Clear EAX, will be used to sum negative values

    loop_start:  
    ; Check if the current value pointed by ESI is negative
                 mov  edx, [esi]            ; Move the current element into EDX
                 cmp  edx, 0                ; Compare the value with 0
                 jge  not_negative          ; If the value is greater than or equal to 0, jump to not_negative

    ; If the value is negative, add it to the sum
                 add  eax, edx              ; Add the negative value to EAX

    not_negative:
                 add  esi, 4                ; Move ESI to the next element (SDWORD is 4 bytes)
                 loop loop_start            ; Decrease ECX and loop if not zero

    ; Store the sum of negative numbers
                 mov  NegativeSum, eax      ; Store the result in NegativeSum

    ; For demonstration, let's print the sum
                 mov  eax, NegativeSum
                 call WriteInt              ; Irvine32 procedure to print the integer
                 call Crlf                  ; New line
    ; no of positive values
    
                 exit
main ENDP
END main
