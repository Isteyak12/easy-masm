INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
          promptSizeMsg   BYTE "What is the size N of Vector? > ", 0
          promptValuesMsg BYTE "What are the ", 0
          valuesMsgEnd    BYTE " values in Vector? > ", 0
          vector          SDWORD 50 DUP(?)                                                                              ; Reserve space for 50 SDWORD integers
          vectorSize      DWORD ?

          WR1             BYTE "The sum of negative values: ", 0
          NegativeSum     DWORD 0
          WR2             BYTE "The count of pos values: ", 0
          PositiveCount   DWORD 0
         
     ;  range sum
              promptI         BYTE "Enter the start index I (1-based): ", 0
         promptJ         BYTE "Enter the end index J (1-based): ", 0
          I               DWORD ?                                                                                       ; Start index (2nd element, considering 1-based indexing)
          J               DWORD ?                                                                                       ; End index (7th element)
          Minimum         SDWORD ?
          inputErrorMsg   BYTE "Invalid input. I must be <= J and both must be within the vector size.", 0dh,0ah, 0
    
     ;palinindrome check
          IsPalindrome    BYTE "The array is a palindrome.",0dh,0ah,0
          IsNotPalindrome BYTE "The array is not a palindrome.",0dh,0ah,0

.code
main PROC
     ; Prompt for the size of the vector
                           mov  edx, OFFSET promptSizeMsg
                           call WriteString
                           call ReadInt                            ; Read the size into EAX
                           mov  vectorSize, eax                    ; Store the size in vectorSize

     ; Ensure the size does not exceed the maximum allowed (50)
                           cmp  vectorSize, 50
                           jle  validSize

     validSize:            
     ; Print part of the prompt for values
                           mov  edx, OFFSET promptValuesMsg
                           call WriteString
     ; Convert vectorSize to string and print
                           mov  eax, vectorSize
                           call WriteDec
     ; Print the rest of the prompt for values
                           mov  edx, OFFSET valuesMsgEnd
                           call WriteString

     ; Loop to read vector values
                           mov  ecx, vectorSize                    ; ECX will serve as our loop counter
                           mov  esi, 0                             ; ESI will serve as the index for storing values in the vector

     readVectorLoop:       
                           test ecx, ecx                           ; Check if we've read all values
                           jz   finishedReading                    ; If yes, jump to the end of reading loop
                    
                           call ReadInt                            ; Read a value from the user
                           mov  vector[esi * TYPE vector], eax     ; Store the value in the vector
                    
                           add  esi, 1                             ; Increment the index for the next value
                           loop readVectorLoop

     ; Now, print the entire vector
     finishedReading:      
                           mov  ecx, vectorSize                    ; Set up the counter for printing loop
                           mov  esi, 0                             ; Reset the index for accessing vector values
     printVectorLoop:      
                           test ecx, ecx
                           jz   done                               ; If all elements have been printed, we're done
                   
                           mov  eax, vector[esi * TYPE vector]     ; Load the current value into EAX
                           call WriteInt                           ; Print the value
                           mov  al, ' '                            ; Load space character into AL
                           call WriteChar                          ; Print a space
                    
                           add  esi, 1                             ; Move to the next index
                           loop printVectorLoop

     done:                 

                           call Crlf                               ; Print a new line at the end

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
                           mov  eax, [esi]                         ;mov the curr elem in eax
                           cmp  eax, 0                             ;compare val w/ 0
                           jle  not_pos                            ; jump low
                           inc  PositiveCount

     not_pos:              
                           add  esi, TYPE Vector
                           loop check_loop

     ; Move ESI to the next element (SDWORD is 4 bytes)
                           mov  eax, PositiveCount
                           call WriteInt
                           call Crlf

     ; >>>>>>>>>>>>>>>>>>>>>>>>>neg sum>>>>>>>>>>>>>>>>>>>>>>>>>..
                           mov  eax, 0
                           mov  esi, OFFSET Vector                 ; ESI points to the start of the Vector
                           mov  ecx, VectorSize
     ;eax reg assigned w/ 0
     ; >>>>>>>>>>>>>>>>>>>>>>
     loop_start:           
     ; Check if the current value pointed by ESI is negative
                           mov  edx, [esi]                         ; Move the current element into EDX
                           cmp  edx, 0                             ; Compare the value with 0
                           jge  not_negative                       ; If the value is greater than or equal to 0, jump to not_negative

     ; If the value is negative, add it to the sum
                           add  eax, edx                           ; Add the negative value to EAX

     not_negative:         
                           add  esi, 4                             ; Move ESI to the next element (SDWORD is 4 bytes)
                           loop loop_start                         ; Decrease ECX and loop if not zero

     ; Store the sum of negative numbers
                           mov  NegativeSum, eax                   ; Store the result in NegativeSum

     ; For demonstration, let's print the sum
                           mov  eax, NegativeSum
                           call WriteInt                           ; Irvine32 procedure to print the integer
                           call Crlf                               ; New line
     
     ; <<<<<<<<<<<<<<<<here we go again>>>>>>>>>>>>>>>>>>>>>>>>>
     ; <<<<<<<<<<<<<<<<range sum>>>>>>>>>>>>>>>>>>>>>>>>>
     ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
     ; Palindrome check
                           mov  esi, OFFSET vector                 ; ESI points to the start of the Vector
                           mov  edi, OFFSET vector                 ; EDI also points to the start of the Vector
                           add  edi, vectorSize                    ; Add size to EDI
                           dec  edi                                ; Adjust EDI to point to the last valid index
                           dec  edi                                ; Adjust by one more due to SDWORD size
                           dec  edi
                           dec  edi
                           mov  ecx, vectorSize
                           shr  ecx, 1                             ; Only need to compare half the elements

     palindrome_check:     
                           cmp  ecx, 0
                           je   is_palindrome                      ; If ECX is 0, all comparisons were successful
                           mov  eax, [esi]                         ; Load start element
                           mov  edx, [edi]                         ; Load end element
                           cmp  eax, edx
                           jne  not_a_palindrome                   ; If not equal, it's not a palindrome
                           add  esi, 4                             ; Move to the next element from the start
                           sub  edi, 4                             ; Move to the previous element from the end
                           dec  ecx                                ; Decrement loop counter
                           jmp  palindrome_check                   ; Continue loop

     is_palindrome:        
                           mov  edx, OFFSET IsPalindrome
                           call WriteString
                           jmp  done_palindrome_check

     not_a_palindrome:     
                           mov  edx, OFFSET IsNotPalindrome
                           call WriteString

     done_palindrome_check:
                           call Crlf
     ; ... [continue with the rest of the program] ...

     ; ... [rest of the code] ...
                           exit
main ENDP
END main