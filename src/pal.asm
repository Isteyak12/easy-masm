INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    Vector        SDWORD -1, 3, 17, 0, -100, -30, 1, -31, -100, 0, 17, 3, -1
    VectorSize    DWORD LENGTHOF Vector
    IsPalindrome  BYTE "The array is a palindrome.",0dh,0ah,0
    IsNotPalindrome BYTE "The array is not a palindrome.",0dh,0ah,0

.code
main PROC
    mov esi, OFFSET Vector       ; Point ESI to the start of the Vector
    mov edi, OFFSET Vector       ; Point EDI to the start of the Vector

    mov ecx, VectorSize          ; Load the length of the vector into ECX
    dec ecx                      ; Decrement ECX to get VectorSize - 1
    imul ecx, ecx, 4            ; Multiply ECX by the size of each element (4 for SDWORD)
    lea edi, [edi + ecx]        ; Efficiently add ECX to EDI to point to the last element

    mov ecx, VectorSize
    shr ecx, 1                   ; Only need to compare the first half with the second half

palindrome_check:
    mov eax, [esi]               ; Move the start element into EAX
    mov ebx, [edi]               ; Move the end element into EBX
    cmp eax, ebx                 ; Compare the elements
    jne not_a_palindrome         ; If they are not equal, it's not a palindrome
    add esi, 4                   ; Move to the next element from the start
    sub edi, 4                   ; Move to the next element from the end
    loop palindrome_check        ; Loop until we have checked half of the array

    ; If all matched, the array is a palindrome
    mov edx, OFFSET IsPalindrome
    call WriteString             ; Write "The array is a palindrome."
    jmp done_checking

not_a_palindrome:
    mov edx, OFFSET IsNotPalindrome
    call WriteString             ; Write "The array is not a palindrome."

done_checking:
    call Crlf                    ; New line
    exit                         ; Exit the process
main ENDP

END main
