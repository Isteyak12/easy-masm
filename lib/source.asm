INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
          promptSizeMsg   BYTE "What is the size N of Vector? > ", 0
          promptValuesMsg BYTE "What are the ", 0
          valuesMsgEnd    BYTE " values in Vector? > ", 0
          vector          SDWORD 50 DUP(?)                                    ; Reserve space for 50 SDWORD integers
          vectorSize      DWORD ?

          WR1             BYTE "The sum of negative values: ", 0
          NegativeSum     DWORD 0
          WR2             BYTE "The count of pos values: ", 0
          PositiveCount   DWORD 0
         
     ;  range sum
          I               DWORD 2                                             ; Start index (2nd element, considering 1-based indexing)
          J               DWORD 7                                             ; End index (7th element)
          Minimum         SDWORD ?
    
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

     ; >>>>>>>>>>>>>>>>>>>>>>>>>>>
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
     ; no of positive values
     ; <<<<<<<<<<<<<<<<here we go again>>>>>>>>>>>>>>>>>>>>>>>>>
                           varI DWORD 2 - 1                        ; Adjusting for 0-based indexing
                           varJ DWORD 7 - 1                        ; Adjusting for 0-based indexing
                           M    SDWORD ?

                           mov  esi, OFFSET Vector                 ; ESI points to the start of the array
                           mov  ecx, varJ                          ; ECX is the loop counter, starting from J
                           sub  ecx, varI
                           mov  ebx, varI                          ; Adjust loop counter for the range I to J
                           lea  esi, [esi + ebx*4]                 ; Adjust ESI to point to the first element in the range
                           mov  eax, [esi]                         ; Move the first element of the range into EAX
                           mov  M, eax                             ; Assume the first element is the minimum

     find_min:             
                           add  esi, TYPE Vector                   ; Move to the next element in the range
                           mov  edx, [esi]                         ; Load the current element into EDX
                           cmp  eax, edx                           ; Compare EAX (current minimum) with EDX (current element)
                           jle  next_element                       ; If EAX <= EDX, move to the next element
                           mov  eax, edx                           ; If EDX < EAX, EDX is the new minimum
                           mov  M, eax                             ; Store the new minimum

     next_element:         
                           loop find_min                           ; Loop until ECX is 0

     ; Print the resultF
                           mov  eax, Minimum
                           call WriteInt                           ; Print the minimum value
                           call Crlf
     ;  exit


     ; Analysis Phase: Count positive numbers and sum negative numbers
                           mov  ecx, vectorSize                    ; Set loop counter to the size of the array
                           mov  esi, OFFSET vector                 ; Point ESI to the start of the vector
                           xor  eax, eax                           ; Clear EAX for use in loop
                           xor  ebx, ebx                           ; Clear EBX to accumulate negative sum
                           xor  edx, edx                           ; Clear EDX to count positives

     CountAndSumLoop:      
                           test ecx, ecx                           ; Test if loop counter is 0
                           jz   FinishedAnalysis                   ; If 0, all elements have been processed

                           mov  eax, [esi]                         ; Load current element into EAX
                           add  esi, TYPE vector                   ; Move to the next element in the array

                           cmp  eax, 0                             ; Compare current element with 0
                           jg   PositiveNumber                     ; If greater than 0, handle positive number
                           jl   NegativeNumber                     ; If less than 0, handle negative number
                           jmp  SkipElement                        ; If 0, neither positive nor negative, skip

     PositiveNumber:       
                           inc  edx                                ; Increment positive count
                           jmp  SkipElement

     NegativeNumber:       
                           add  ebx, eax                           ; Add current element to negative sum

     SkipElement:          
                           dec  ecx                                ; Decrement loop counter
                           jmp  CountAndSumLoop                    ; Loop back

     FinishedAnalysis:     
     ; New line
                           mov  eax, ebx                           ; Move negative sum to EAX
     ;  mov     edx, OFFSET WR1                          ; Move positive count to EAX
     ;  call    WriteString                       ; Print negative sum
                           call WriteInt                           ; Print negative sum
                           call Crlf

     ; Now EAX can be used to display results
                           mov  eax, edx
                           mov  edx, OFFSET WR2
                           call WriteString                        ; Print negative sum    ; Move positive count to EAX
                           call WriteInt                           ; Print positive count
                           call Crlf
     ; For finding the minimum value between I and J
     ; Assume I and J are given and valid, and Vector is already filled with values.
     ; ... [previous code] ...

     ; Find the minimum value between I and J
     ; Ensure I and J are within bounds and I is less than J
                           mov  ebx, I
                           dec  ebx                                ; Adjust for zero-based indexing
                           mov  ecx, J
                           dec  ecx                                ; Adjust for zero-based indexing
                           mov  esi, OFFSET vector                 ; ESI points to the start of the Vector
                           lea  esi, [esi + ebx*4]                 ; ESI now points to the Ith element
                           mov  eax, [esi]                         ; Load Ith element as the current minimum
                           mov  Minimum, eax                       ; Store as the current minimum

     ; Check remaining values from I+1 to J to find the minimum
                           inc  ebx                                ; Move to the next element after I
     while_loop:           
                           cmp  ebx, ecx                           ; Compare current index with J
                           ja   end_while                          ; If beyond J, exit loop
                           lea  esi, [vector + ebx*4]              ; Point ESI to the current element
                           mov  eax, [esi]                         ; Load current element
                           cmp  eax, Minimum                       ; Compare current element with the current minimum
                           jge  increment_index                    ; If greater or equal, skip
                           mov  Minimum, eax                       ; Update minimum
     increment_index:      
                           inc  ebx                                ; Increment index
                           jmp  while_loop                         ; Continue loop
     end_while:            

     ; Output the minimum value
                           mov  eax, Minimum
                           call WriteInt
                           call Crlf

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