INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
         Vector     SDWORD -1, 3, 17, 0, -100, -30, 2, -30, -100, 0, 17, 3, -1
         VectorSize DWORD LENGTHOF Vector
         I          DWORD 2                                                       ; Start index (2nd element, considering 1-based indexing)
         J          DWORD 7                                                       ; End index (7th element)
         Minimum    SDWORD ?

.code
main PROC
                 mov  esi, OFFSET Vector    ; ESI points to the start of the Vector array
                 mov  ecx, I                ; Load the start index I into ECX
                 dec  ecx                   ; Adjust because of 1-based indexing
                 mov  ebx, TYPE Vector      ; Load the size of each element in Vector into EBX
                 imul ebx, ecx              ; Multiply the index by the size of each element
                 add  esi, ebx              ; Add the result to ESI to point it to the Ith element

                 mov  ecx, J                ; Load the end index J into ECX
                 sub  ecx, I                ; Calculate the number of elements from I to J
                 inc  ecx                   ; Adjust the count to include the Jth element

                 mov  eax, [esi]            ; Load the Ith element into EAX
                 mov  Minimum, eax          ; Assume the first checked value is the minimum

    find_minimum:
                 add  esi, TYPE Vector      ; Move to the next element in the array
                 cmp  ecx, 1                ; Compare loop counter before it decrements
                 je   end_loop              ; If this is the last iteration, skip to end
                 mov  eax, [esi]            ; Load the current element into EAX
                 cmp  Minimum, eax          ; Compare current minimum with the new value
                 jle  skip                  ; If Minimum <= eax, skip to the next iteration
                 mov  Minimum, eax          ; New minimum found, update Minimum
    skip:        
                 loop find_minimum          ; Loop until ECX reaches 0

    end_loop:    
    ; Output the minimum value found
                 mov  eax, Minimum
                 call WriteInt              ; Display the minimum value
                 call Crlf

                 exit                       ; Exit the program
main ENDP
END main
