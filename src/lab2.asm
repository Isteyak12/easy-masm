TITLE
INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
 
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data

  val1 dword 4040h

  val2 word 1555h

  val3 byte "Hello World", 0

 

.code

  main PROC

      mov EDX, offset val3

     call WriteString

     call crlf

 

    ;   mov eax,val1

    ;   add ax,val2      ; error: should use ax

    ;   mov cx, val2     ; error: should use cx

    ;   sub ecx, 500h

    ;   mov ebx, 3000h

    ;   add eax,ebx        ; error: should use ebx

    ;   sub ax,cx

    ;   add val2, cx

 

    ;   mov eax, 1111h

    ;   add val1, eax

 

      call DumpRegs

 

      exit

  main ENDP

END main  