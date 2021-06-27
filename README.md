# programming in emu8086 (with brief theory)

Hopefully, we all know the basic architecture of 8086. We will also briefly discuss it along with the sample code. Let's start ☺ <br>
👉This is not case sensitive language. So int and INT seems equivalent to it. <br>
👉To comment in code we have to put ( ; ) <br>

# Let's take a single input💦 <br>

⚠️Do you know?:
👉We have 4 types of data resister- `AX`, `BX`, `CX`, `DX`. In 8086 each of them is `16-bit`. Again we divide 16-bit into two 8 bit. Like `AX = AL+ AH` ( 16 = 8 + 8). 

## Steps to take single input - 
   💣Set the value of `ah(AH)` to 1. For this, we have to write- 
  `mov ah,1`  <br>
  💣Give the command to execute. When we have 1 in `ah` and instruct to execute then it will take input and the default input location is `al`.
   For this we have to write- 
   `int 21h`    ; command to execute <br>
   
   ## code-

   
      .model small
      .stack 100h

      .data
      .code
          main proc

              mov ah,1; Just focus on these two lines, else are just a structure, 
              int 21h ; else are like #include and main() in C you can think off now

          main endp
      end main

# Let's give output💦
⚠️Do you know? How physical memory address is calculated? <br>
👉In 8086 physical address is `20` bit. From the logical address of segment address and offset address we calculate the physical address. If, 
`segment address = 213A`  &   `offset address = 31B1`, then `physical address = 213A0 + 31B1`. <br>
What will happen if we get more than 20 number after addition? (https://stackoverflow.com/questions/6718783/calculation-of-physical-address-in-8086) <br>

## Steps to print output - 
  💣Set the value of `ah(AH)` to `2`. For this, we have to write- `mov ah,2`  
  💣What we want to print, move that value in `dl`. dl is the default location to print output.
  💣Give the command to execute. When we have 2 in ah and instruct to execute then it will give output and the default location from which output will come in dl. 
   For this, we have to write- `int 21h`    ; command to execute
   
## code-
         .model small
         .stack 100h

         .data
         .code
             main proc

                 mov ah,1 ;prepqring ah to take input in al 
                 int 21h ;execute command. By this command code will take input
                         ; and will store that in al,as ah is now 1 
                 mov ah,2 ;preparing ah to print from dl
                 mov dl,al ;assaigning value of al in dl
                 int 21h ;exexute command. By this command output will be 
                         ;printed from dl, as ah is now 2    

             main endp
         end main
         
## In the above code, input and Output is printed in the same line. Let's print output in a new line-
         .model small
         .stack 100h

         .data
         .code
             main proc

                 mov ah,1 ;prepqring ah to take input in al 
                 int 21h ;execute command. By this command code will take input
                         ; and will store that in al,as ah is now 1 
                 mov bl,al ;moving the input value in bl. 



                 mov ah,2 ;preparing ah to print from dl
                 mov dl,0dh ;0dh is carriage return
                 int 21h ;as al=2, execute command will print from dl
                         ;as dl=0dh, it will move the cursor to left


                 mov ah,2 ;preparing ah to print from dl
                 mov dl,0ah ;0ah is carriage return.       
                 int 21h ;as al=2, execute command will print from dl
                         ;as dl=0ah, it will move the cursor to new line 


                 mov ah,2 ;preparing ah to print from dl
                 mov dl,bl ;assaigning value of bl in dl
                 int 21h ;exexute command. By this command output will be 
                         ;printed from dl, as ah is now 2    

             main endp
         end main
         
In line 15 we have set the value of ah to 2, so until we again set it to 1 it will continue to take input. That means line 21 & 27 is not needed.

# Let's print the string💦(coming ....)
Do you know? The types of data resister? ............ (comming) <br>


# Let's learn aboutcondition and jump💦
👉First, we will see the unconditional jump <br>
👉Then different types of conditional jump

## unconditional jump -
   💣If you are familiar with C, then you can compare `jump` with `goto` <br>
   💣jmp keyword is used to make a jump <br>
   💣the syntax is `jmp label_name` <br>
   💣after seeing jmp program will jump to the label where we defined it <br>

In the below code we will take 2 input, and will write code to print both inputs. But before that, we will write an unconditional jump statement which will jump to a label without printing one input and print the next one. So, the code will show one output. <br>

## code-
         .model small
         .stack 100h
         .data

         .code
             main proc
                 ;first input
                 mov ah, 1 ; preparing ah to take input in al
                 int 21h
                 mov bl, al

                 ;going to new line
                 mov ah, 2 ; preparing ah to print from dl
                 mov dl, 0dh ;0dh is carriage return
                 int 21h
                 mov dl, 0ah ; 0ah is line feed
                 int 21h


                 ;second input
                 mov ah, 1 ; preparing ah to take input in al
                 int 21h
                 mov bh, al


                 jmp label_x  ; instruction to jump to label_x

                 ;going to new line
                 mov ah, 2 ; preparing ah to print from dl
                 mov dl, 0dh ;0dh is carriage return
                 int 21h
                 mov dl, 0ah ; 0ah is line feed
                 int 21h

                 mov ah, 2 ; preparing ah to print from dl
                 mov dl, bh
                 int 21h



             label_x:
                 ;going to new line
                 mov ah, 2 ; preparing ah to print from dl
                 mov dl, 0dh ;0dh is carriage return
                 int 21h
                 mov dl, 0ah ; 0ah is line feed
                 int 21h

                 mov ah, 2 ; preparing ah to print from dl
                 mov dl, bl
                 int 21h       

             main endp
         end main
         
If we give 2 & 5 input to the program, the program will print 2. But without using jump the output would be 5 & 2.
This is an `unconditional` jump. No condition will be checked, as soon as the line 'jump label_x' is executed program makes a jump. <br>





