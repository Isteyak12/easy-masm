INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    Vector      SDWORD -1, 3, 17, 0, -100, -30, 2, -30, -100, 0, 17, 3, -1
    VectorSize  DWORD LENGTHOF Vector
    PositiveCount DWORD 0

.code
main PROC
    mov esi, OFFSET Vector       ; ESI points to the start of the array
    mov ecx, VectorSize          ; ECX is the loop counter
    mov eax, 0                   ; Clear EAX, will be used to store array values temporarily

check_loop:
    mov eax, [esi]               ; Move the current element into EAX
    cmp eax, 0                   ; Compare the value with 0
    jle not_positive             ; If the number is less than or equal to zero, jump to not_positive
    inc PositiveCount            ; Increment the count of positive numbers

not_positive:
    add esi, TYPE Vector         ; Move to the next element in the array
    loop check_loop              ; Decrement ECX, and continue the loop if ECX != 0

    ; After the loop, the count of positive numbers is in PositiveCount
    ; For example purposes, let's print it
    mov eax, PositiveCount
    call WriteInt                ; Call Irvine's library function to print the integer

    call Crlf                    ; New line

    exit
main ENDP
END main
