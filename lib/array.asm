TITLE
 
INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
 
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib
 
.data
vector SDWORD -10,1,3,2,-20,31,69,-15
ourString BYTE "The program is over"
 
sum DWORD 0
cntrV DWORD 0
 
 
.code
main PROC
 
    lea esi, vector ; Load Effective Address of vector array
    mov ecx, 8
 
lpng:            ; Label starting point    
    mov eax,[esi]  ;Stores the value of the array in EAX register
    add esi, 4
    cmp eax,0       ; Compares values
   
    jl getneg         ; Jumps to begining if it is greater than 0
 
    getneg:
        add sum, eax
 
    loop lpng
 
    mov eax,sum
    call WriteInt
   
 
main ENDP
END main