.section .data
// for whatever reason it doesnt print prompt with no newline
input_prompt    :    .asciz "Input a string: \n"
input_spec      :    .asciz "%[^\n]"
length_spec     :    .asciz "String length: %d\n"
palindrome_spec :    .asciz "String is a palindrome (T/F): %c\n"
parrot          :    .asciz "%s\n"
output_spec:	.asciz	"'%c', '%c'\n"
T               :    .asciz "T"
F               :    .asciz "F"

// variable to hold user input
input: .space 7


.section .text

.global main
// program exec begins here
main:
    // code goes here
    // prints input prompt
    ldr x0, = input_prompt 
    // branch with link to printf, will come back here since its a bl
	bl printf 


    // this will be the beginning of user input code

    // load x0 with format specifier
    ldr x0, =input_spec
    // load x1 with variable we want to store the input in
    ldr x1, =input
    // branch with link to scanf
    bl scanf

   
    // parrot will spit back out the user input
    // ldr x0, =parrot
    // load the variable we want to print
    // ldr x1, =input
    // call printf
    // bl printf


    add x19, xzr, xzr // x19 is the counter from now on
    // length loop begins here
len:
    ldr x1, =input // loads input into x1
    ldrb w1, [x1, x19] // sets w1 to the char in input at index x19
    //ldr x0, =output_spec
   // bl printf
    cbz w1, endlen
    add x19, x19, #1 // iterates (x19 = x10 + x19)
    b len

    b exit
endlen:
    cbz x19, true
    ldr x0, =length_spec // sets x0 to lenspec for printing
    mov x1, x19 // moves the value of x19 (count) into x1 for printing
    bl printf
    mov x14, xzr // sets x14 to 0, this will be the beginning count value
    sub x15, x19, #1 // sets x15 to len-1 which will be the final count value
pali:
    ldr x16, =input // resets input to x1


    // gets char at counters
    ldrb w1, [x16, x14]
    ldrb w2, [x16, x15]    
    //ldr x0, =output_spec
    //bl printf

    sub w3, w1, w2 // comparison (w3 = w1 - w2)
    cbnz w3, false // if w3 is not zero, letters dont match, not a palindrome
    
    // iterate x14, deiterate x15
    sub x15, x15, #1
    add x14, x14, #1

    // compare x15 and x14, if they are the same value then it didnt fail, is a palindrome
    sub x17, x15, x14
    cbz x17, true
    b pali
false:
    ldr x0, =palindrome_spec
    mov x1, #70
    bl printf
    b exit
true:
    ldr x0, =palindrome_spec
    mov x1, #84
    bl printf
    b exit
    // branch to exit on code completion
exit:
    mov x0, 0
    mov x8, 93
    svc 0
    ret
