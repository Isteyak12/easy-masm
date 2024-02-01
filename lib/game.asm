INCLUDE Irvine32.inc

.data
randomNumber DWORD ?
guess DWORD ?
message BYTE "Guess a number between 1 and 100: ", 0
successMsg BYTE "Congratulations! You guessed the right number!", 0
lowMsg BYTE "Too low. Try again.", 0
highMsg BYTE "Too high. Try again.", 0

.code
main PROC
    ; Initialize random number generator
    call Randomize

    ; Generate a random number between 1 and 100
    mov eax, 100
    call RandomRange
    inc eax ; RandomRange returns 0 to 99, so we add 1
    mov randomNumber, eax

    ; Game loop
    gameLoop:
        ; Ask for player's guess
        mov edx, OFFSET message
        call WriteString
        call ReadDec
        mov guess, eax

        ; Compare guess with the random number
        mov eax, guess
        cmp eax, randomNumber
        je correctGuess
        jl tooLow
        jg tooHigh

    tooLow:
        mov edx, OFFSET lowMsg
        jmp continueGame

    tooHigh:
        mov edx, OFFSET highMsg
        jmp continueGame

    correctGuess:
        mov edx, OFFSET successMsg
        call WriteString
        jmp endGame

    continueGame:
        call WriteString
        call Crlf
        jmp gameLoop

    endGame:
        call Crlf
        exit
main ENDP

END main
