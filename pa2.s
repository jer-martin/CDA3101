.section .data

input_prompt	:	.asciz	"Please enter a number: "
input_spec	:	.asciz	"%d"
output_spec	:	.asciz	"x^y = %d\n"
parrotx          :    .asciz "x is: %d\n"
parroty          :    .asciz "y is: %d\n"
parrot8          :    .asciz "x8 is: %d\n"

.section .text

.global main

main:

# add code and other labels here
# print input prompt
  ldr x0, =input_prompt
  bl printf

# take input in for x
	sub sp, sp, #8
	ldr x0, =input_spec
	mov x1, sp
	bl scanf

# print input prompt
  ldr x0, =input_prompt
  bl printf

# take input in for y
	sub sp, sp, #8
	ldr x0, =input_spec
	mov x1, sp
	bl scanf

# put a copy of x on the stack

afterscan:
# y is zero conditional
    ldr x7, [sp, #0]
    CBZ x7, zeroy

# save value from stack
	//ldr x19, [sp, #8] // x
    //ldr x20, [sp, #0] // y
# restore stack
	//add sp, sp, #16
# parrot the two values    
    //ldr x0, =parrotx
    //ldr x6, [sp, #8] // x
    //mov x1, x6
    //bl printf
    //ldr x7, [sp, #0] // y
    ////sub x7, x7, #1
    //ldr x0, =parroty
    //mov x1, x7
    //bl printf

# make copy of x at stack position 16
    ldr x6, [sp, #8]
    str x6, [sp, #16]

# print debug
    //ldr x0, =parrotx
    //ldr x6, [sp, #16] // this should print x at this point
    //mov x1, x6
    //bl printf

# correct for 0 based indexing
    ldr x7, [sp, #0] // y
    sub x7, x7, #1
    str x7, [sp, #0]
    

// yay its time for the hard part
pow:

# print debug for x8
    //ldr x8, [sp, #16] // this will print x8 at this point
    //ldr x0, =parrot8
    //mov x1, x8
    //bl printf

# actual pow code
    ldr x6, [sp, #8] // x
    ldr x8, [sp, #16]
    mul x6, x6, x8
    str x6, [sp, #8]
 # print debug but again lol   
    //ldr x0, =parrotx
    //mov x1, x6
    //bl printf
    //str x6, [sp, #8]

# print debug for x
    //ldr x0, =parrotx
    //ldr x6, [sp, #8] // x
    //mov x1, x6
    //bl printf

powcheck:
    ldr x7, [sp, #0] // y
    sub x7, x7, #1
    str x7, [sp, #0]
    CBNZ x7, pow

# print debug
    //ldr x7, [sp, #0] // y
    //ldr x0, =parroty
    //mov x1, x7
    //bl printf

# loop debug
    //CBZ x7, exit
    //CBNZ x7, powcheck

# output
    ldr x0, =output_spec
    ldr x6, [sp, #8] // x
    mov x1, x6
    bl printf
    b exit
zeroy:
    ldr x0, =output_spec
    mov x1, #1
    bl printf
exit:
	mov x0, 0
	mov x8, 93
	svc 0
	ret
