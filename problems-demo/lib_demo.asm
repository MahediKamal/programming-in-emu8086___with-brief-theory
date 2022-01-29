include 'emu8086.inc'
   ORG 100h
   MOV AL, 1
   MOV BL, 2
   PRINTN 'Hello World!'   ; macro.
   MOV CL, 3
   PRINTN 'Welcome!'       ; macro.
   RET