# programming in emu8086 (with brief theory)

Hopefully, we all know the basic architecture of 8086. We will also briefly discuss it along with the sample code. Let's start ☺ <br>
👉This is not case sensitive language. So int and INT seems equivalent to it. <br>
👉To comment in code we have to put ( ; ) <br>

# Let's take a single input💦 <br>

⚠️Do you know?: <br>
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


## conditional jump -
We can classify jump condition on the basis of the signed number and unsigned number.
For signed number, we use    : `jl`     `jg`     `jle`     `jge`     `je`     `jnl`     `jng`     `jnle`     `jnge`
For unsigned number, we use: `ja`    `jb`     `jbe`    `jae`     `je`     `jnb`    `jna`     `jnbe`    `jnae`
`je` is common for both signed and unsigned number.

Meanings of these key-words- <br>
- jl      => jump if less <br>
- jg     => jump if greater <br>
- jle    => jump if less or equal <br>
- jge   => jmp if greater or equal <br>
- jnl    => jump if not equal <br>
- je     => jump if equal <br>
- ja     => jump if above <br>
- jb     => jump if below <br>
- jbe   => jump if below or equal <br>
- jnbe => jump if nor=t below or equal <br>
- jnae => jump if not avobe or equal <br>
etc.... <br>


## Difference between signed jump condition and unsigned jump condition:
 We know in emu8086 we can have `8` bit or `16-bit` number. For simplicity let's consider we have only 8-bit number. Then if we want to consider the `signed` number then the `8th` bit will represent the `sign(1=negative, 0=positive)`. If we consider the `unsigned` number then the `8th` bit will be considered as a part of the `value`. <br>

⚠️Let's take a question: a = 71 h  and b = 81 h ( h for hexadecimal), now which one is greater, a or b? <br>
👉The answer is, we can't say which one is greater until we know if we have to consider it as a signed or unsigned number. But why? <br>
👉lets represent the hexadecimal number in binary : <br>

                          a = 71 h =  0111 0001 b (we considered as 8-bit resister)
                          b = 81 h = 1000 0001 b 
                                            
👉If we consider a and b as a signed number then, b is a negative number, as the 8-th bit is 1, so obviously `b < a`. <br>
👉again, if we consider the unsigned number, then both of them are positive, and 8-th bit will contribute to the value.  so `b > a` <br>

👉If we consider the signed number then we must use the signed jump condition, if we just consider the value then we must use the unsigned jump condition <br>



**Note: for comparing to resister, the size of resister should be the same `(we can't compare bx with cl)`**

# Let's check Loop operation💦
## Steps for using loop instruction - 
   💣loop instruction is directly related to `cx` resister.  looping process will continue until the value of cx resister become `0`. <br>
   💣First, we will set the value of cx resister to the number(say n) we want to loop. <br>
   💣Then we will declear a label and do some work under the label and then write the loop instruction. the work under the label will be perform  n times. <br>

**Note: Loop will always integrate on the value of cx. If we put ch =0 and cl = any_8_bit_number, then the value is also equal to the value of `cl`.**


# Let's Learn about the flag register💦

![...](images/flag_res.png)</br>

In emu8086, the flag register is of `16-bits`, and it has `9 flags`, other bits are `undefined`. <br>
We can divide the 9 flags into 2 groups.  <br>
- Control flags (`TF, IF, DF`)  <br>
- Status flags (`CF, PF, AF, ZF, SF, OF`)  <br>

## Let's first talk about the status flags- 
### Status flags are -         
  👉 `CF` = `Carry Flag` (If there is a carry from MSB or a borrow in MSB then CF will be 1. If we are doing arithmetic, then we will consider CF.) <br>
  👉 `PF` = `Parity Flag` (We will make odd parity. If in the lower 8-bit , number of 1 is even then Pf = 1)  <br>
  👉 `AF` = `Auxiliary Carry Flag` (if there is a carry out from bit 3(4th bit from right) on addition, or there is a borrow into the bit 3 on subtraction, then AF = 1)  <br>
  👉 `ZF` = `Zero Flag` (After operation if result is 0 then ZF  = 1)  <br>
  👉 `SF` = `Sign Flag` (If resultant MSB is 1 then SF =1 )  <br>
  👉 `OF` = `Overflow Flag`  (If signed overflow occur then OF = 1)  
### The most confusing flag if `OF`. Let's simplify the condition for OF  to be 1. We can think of `two points`. OF will be 1, if both the two points hold - (for addition) 
- The MSB of both operand must be the same.
- MSB of the result will be the opposite of the operands.

### Why these two points? 
=> MSB is different means, one operand is positive and another is negative. By adding one positive with a negative, overflow can't occur. Now if point 1 is fulfilled, then result MSB is different means that - adding two negative we have got positive or vice-versa, so then OF will be 1. <br>

### Let's do some exercise-
***Ex-1:*** <br>
***`ax = FFFF h`    and     `bx  = 0001 h`, now add `ax` and `bx` and say which types of overflow occurs. signed or unsigned?*** <br>
***=>*** <br>

       FFFF h =    1111 1111 1111 1111 b
       0001 h =    0000 0000 0000 0001 b 
      ax + bx  = 1 0000 0000 0000 0000 b. 

if we consider the two points mentioned above, then we can easily say that no signed overflow has occurred. So OF = 0. But the is a carry out from the  MSB, so CF = 1, which means `unsigned overflow occurred`. <br>
Let's think logically, why it is not signed overflow.  <br>
let, ax and bx are signed numbers, then MSB represents sign. MSB of ax is 1, so ax contains a negative number, on the other hand, MSB of bx is 0, so bx is a positive number. by adding a positive+negative no overflow can't occur. So OF = 0; <br>
Let, ax and bx are the unsigned numbers. SO MSB will also add to the value. And after adding the values there is a carry out, so unsigned overflow occurred. CF =1 . <br>

***Note: if we consider numbers as unsigned, then negative numbers are in the 2's complement form.*** <br>

***EX-2:*** <br>
***ax  = 7FFF h   and bx = 7FFF h. add ax and bx and find the value of CF and OF.*** <br>
***=>*** <br>

      7FFF    = 0111 1111 1111 1111 
      7FFF    = 0111 1111 1111 1111 
      ax+bx =  1111 1111 1111 1110 

considering the above two points, OF  = 1 <br>
no carry out fro MSB  so,   CF = 0 <br>

***EX-3:*** <br>
***ax  =  FFFF h and bx = FFFF h. add ax and bx and find the value of CF, OF, PF, AF, SF, ZF.*** <br>
***=>*** <br>

      ax =         1111 1111 1111 1111 
      bx =         1111 1111 1111 1111 
      ax+bx =    1 1111 1111 1111 1110 
      
      so,
      CF = 1 
      OF = 0 
      PF = 0 
      AF = 1 
      SZ = 1 
      ZF = 0 

***EX-3:*** <br>
***ax = 8000 h. what will be the value of status resisters after doing the operation -  neg ax ?*** <br>
***=>*** <br>
***Note: For negation operation, Thye value of CF is always 1 unless the result is 0.*** <br>

             ax = 80000 h = 10000 0000 0000 0000 b 
             
            negative numbers are stored i 2's complement form. 2's complement of ax is
             ax              =   1000 0000 0000 0000 
             1's complement  =   0111 1111 1111 1111
                                 0000 0000 0000 0001
             2's complement  =   1000 0000 0000 0000

            So, 
            SF = 1  (MSB =1)
            PF = 1 (number of 1 in last 8 bit is 0)
            ZF = 0 (result is non zero)
            CF = 1
            OF = 1 (1's complement and 1 are positive(MSB 0),  2's complement is negative(MSB 1)  )




