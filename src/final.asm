INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
         Vector        SDWORD -1, 3, 17, 0, -100, -30, 2, -30, -100, 0, 17, 3, -1
         VectorSize    DWORD LENGTHOF Vector
         PositiveCount DWORD 0
         NegativeSum   SDWORD 0

.code
main PROC
    ; taking the vector/arr address
    ;assigning it to eax reg
                 mov  esi, OFFSET vector

    ;taking the arr size
    ; n assigning it to ecx counter reg
                 mov  ecx, VectorSize

    ; eax initialixed to 0
                 mov  eax, 0
    ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ; vector vals initialized

    ; <<<<<<<<<<<<action starts
    ; vector
    ; -------------------------
    ; start a loop
    check_loop:  
                 mov  eax, [esi]            ;mov the curr elem in eax
                 cmp  eax, 0                ;compare val w/ 0
                 jle  not_pos               ; jump low
                 inc  PositiveCount

    not_pos:     
                 add  esi, TYPE Vector
                 loop check_loop

    ; Move ESI to the next element (SDWORD is 4 bytes)
                 mov  eax, PositiveCount
                 call WriteInt
                 call Crlf

    ; >>>>>>>>>>>>>>>>>>>>>>>>>>>
                 mov  eax, 0
                 mov  esi, OFFSET Vector    ; ESI points to the start of the Vector
                 mov  ecx, VectorSize
    ;eax reg assigned w/ 0
    ; >>>>>>>>>>>>>>>>>>>>>>
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
