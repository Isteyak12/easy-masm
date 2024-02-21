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
                 mov     esi, OFFSET vector

    ;taking the arr size
    ; n assigning it to ecx counter reg
                 mov     ecx, VectorSize

    ; eax initialixed to 0
                 mov     eax, 0
    ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ; vector vals initialized

    ; <<<<<<<<<<<<action starts
    ; vector
    ; -------------------------
    ; start a loop
    check_loop:  
                 mov     eax, [esi]            ;mov the curr elem in eax
                 cmp     eax, 0                ;compare val w/ 0
                 jle     not_pos               ; jump low
                 inc     PositiveCount

    not_pos:     
                 add     esi, TYPE Vector
                 loop    check_loop

    ; Move ESI to the next element (SDWORD is 4 bytes)
                 mov     eax, PositiveCount
                 call    WriteInt
                 call    Crlf

    ; >>>>>>>>>>>>>>>>>>>>>>>>>>>
                 mov     eax, 0
                 mov     esi, OFFSET Vector    ; ESI points to the start of the Vector
                 mov     ecx, VectorSize
    ;eax reg assigned w/ 0
    ; >>>>>>>>>>>>>>>>>>>>>>
    loop_start:  
    ; Check if the current value pointed by ESI is negative
                 mov     edx, [esi]            ; Move the current element into EDX
                 cmp     edx, 0                ; Compare the value with 0
                 jge     not_negative          ; If the value is greater than or equal to 0, jump to not_negative

    ; If the value is negative, add it to the sum
                 add     eax, edx              ; Add the negative value to EAX

    not_negative:
                 add     esi, 4                ; Move ESI to the next element (SDWORD is 4 bytes)
                 loop    loop_start            ; Decrease ECX and loop if not zero

    ; Store the sum of negative numbers
                 mov     NegativeSum, eax      ; Store the result in NegativeSum

    ; For demonstration, let's print the sum
                 mov     eax, NegativeSum
                 call    WriteInt              ; Irvine32 procedure to print the integer
                 call    Crlf                  ; New line
    ; no of positive values
    ; <<<<<<<<<<<<<<<<here we go again>>>>>>>>>>>>>>>>>>>>>>>>>
                 varI    DWORD 2 - 1           ; Adjusting for 0-based indexing
                 J       DWORD 7 - 1           ; Adjusting for 0-based indexing
                 Minimum SDWORD ?

                 mov     esi, OFFSET Vector    ; ESI points to the start of the array
                 mov     ecx, J                ; ECX is the loop counter, starting from J
                 sub     ecx, varI
                 mov     ebx, varI             ; Adjust loop counter for the range I to J
                 lea     esi, [esi + ebx*4]    ; Adjust ESI to point to the first element in the range
                 mov     eax, [esi]            ; Move the first element of the range into EAX
                 mov     Minimum, eax          ; Assume the first element is the minimum

    find_minimum:
                 add     esi, TYPE Vector      ; Move to the next element in the range
                 mov     edx, [esi]            ; Load the current element into EDX
                 cmp     eax, edx              ; Compare EAX (current minimum) with EDX (current element)
                 jle     next_element          ; If EAX <= EDX, move to the next element
                 mov     eax, edx              ; If EDX < EAX, EDX is the new minimum
                 mov     Minimum, eax          ; Store the new minimum

    next_element:
                 loop    find_minimum          ; Loop until ECX is 0

    ; Print the resultF
                 mov     eax, Minimum
                 call    WriteInt              ; Print the minimum value
                 call    Crlf                  ; New line

                 exit
main ENDP
END main
