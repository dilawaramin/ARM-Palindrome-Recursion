/*
-------------------------------------------------------------------------
Recursive Palindrome Checking Algorithm
-------------------------------------------------------------------------
Author:	Dilawar Amin
-------------------------------------------------------------------------
Subroutines for determining if a string is a palindrome.

This program reads a string from memory and recursively checks if it is a
palindrome, and outputs T for true and F for false.


-------------------------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

// MAIN PROGRAM
// Test a string to see if it is a palindrome
ldr    r4, =Test1
ldr    r5, =_Test1 - 2
bl     PrintString
bl     PrintEnter
bl     Palindrome
bl     PrintTrueFalse
bl     PrintEnter

ldr    r4, =Test2
ldr    r5, =_Test2 - 2
bl     PrintString
bl     PrintEnter
bl     Palindrome
bl     PrintTrueFalse
bl     PrintEnter

ldr    r4, =Test3
ldr    r5, =_Test3 - 2
bl     PrintString
bl     PrintEnter
bl     Palindrome
bl     PrintTrueFalse
bl     PrintEnter

ldr    r4, =Test4
ldr    r5, =_Test4 - 2
bl     PrintString
bl     PrintEnter
bl     Palindrome
bl     PrintTrueFalse
bl     PrintEnter

_stop:
b    _stop

//-------------------------------------------------------

// Constants
.equ UART_BASE, 0xff201000      // UART base address
.equ ENTER, 0x0a     			// enter character
.equ VALID, 0x8000   			// Valid data in UART mask
.equ DIFF, 'a' - 'A' 	// Difference between upper and lower case letters

//-------------------------------------------------------
PrintChar:
/*
-------------------------------------------------------
Prints single character to UART.
-------------------------------------------------------
Parameters:
  r2 - address of character to print
Uses:
  r1 - address of UART
-------------------------------------------------------
*/
stmfd   sp!, {r1, lr}
ldr     r1, =UART_BASE  // Load UART base address
strb    r2, [r1]        // store character to UART
ldmfd   sp!, {r1, lr}
bx      lr

//-------------------------------------------------------
PrintString:
/*
-------------------------------------------------------
Prints a null terminated string to the UART.
-------------------------------------------------------
Parameters:
  r4 - address of string
Uses:
  r1 - address of UART
  r2 - current character to print
-------------------------------------------------------
*/
stmfd   sp!, {r1-r2, r4, lr}
ldr     r1, =UART_BASE
PrintLoop:
ldrb    r2, [r4], #1     // load a single byte from the string
cmp     r2, #0           // compare to null character
beq     _PrintString     // stop when the null character is found
strb    r2, [r1]         // else copy the character to the UART DATA field
b       PrintLoop
_PrintString:
ldmfd   sp!, {r1-r2, r4, lr}
bx      lr

//-------------------------------------------------------
PrintEnter:
/*
-------------------------------------------------------
Prints the ENTER character to the UART.
-------------------------------------------------------
Uses:
  r2 - holds ENTER character
-------------------------------------------------------
*/
stmfd   sp!, {r2, lr}
mov     r2, #ENTER       // Load ENTER character
bl      PrintChar
ldmfd   sp!, {r2, lr}
bx      lr

//-------------------------------------------------------
PrintTrueFalse:
/*
-------------------------------------------------------
Prints "T" or "F" as appropriate
-------------------------------------------------------
Parameter
  r0 - input parameter of 0 (false) or 1 (true)
Uses:
  r2 - 'T' or 'F' character to print
-------------------------------------------------------
*/
stmfd   sp!, {r2, lr}
cmp     r0, #0           // Is r0 False?
moveq   r2, #'F'         // load "False" message
movne   r2, #'T'         // load "True" message
bl      PrintChar
ldmfd   sp!, {r2, lr}
bx      lr

//-------------------------------------------------------
isLowerCase:
/*
-------------------------------------------------------
Determines if a character is a lower case letter.
-------------------------------------------------------
Parameters
  r2 - character to test
Returns:
  r0 - returns True (1) if lower case, False (0) otherwise
-------------------------------------------------------
*/
stmfd sp!, {lr}
mov    r0, #0           // default False
cmp    r2, #'a'
blt    _isLowerCase     // less than 'a', return False
cmp    r2, #'z'
movle  r0, #1           // less than or equal to 'z', return True
_isLowerCase:
ldmfd sp!, {pc}

//-------------------------------------------------------
isUpperCase:
/*
-------------------------------------------------------
Determines if a character is an upper case letter.
-------------------------------------------------------
Parameters
  r2 - character to test
Returns:
  r0 - returns True (1) if upper case, False (0) otherwise
-------------------------------------------------------
*/
stmfd sp!, {lr}
mov    r0, #0           // default False
cmp    r2, #'A'
blt    _isUpperCase     // less than 'A', return False
cmp    r2, #'Z'
movle  r0, #1           // less than or equal to 'Z', return True
_isUpperCase:
ldmfd sp!, {pc}

//-------------------------------------------------------
isLetter:
/*
-------------------------------------------------------
Determines if a character is a letter.
-------------------------------------------------------
Parameters
  r2 - character to test
Returns:
  r0 - returns True (1) if letter, False (0) otherwise
-------------------------------------------------------
*/
stmfd sp!, {lr}
bl      isLowerCase     // test for lowercase

cmp     r0, #0

bleq    isUpperCase     // not lowercase? Test for uppercase.
ldmfd sp!, {pc}


//-------------------------------------------------------
toLower:
/*
-------------------------------------------------------
Converts a character to lower case.
-------------------------------------------------------
Parameters
  r2 - character to convert
Returns:
  r2 - lowercase version of character
-------------------------------------------------------
*/
stmfd   sp!, {lr}
bl      isUpperCase      // test for upper case
cmp     r0, #0
addne   r2, #DIFF        // Convert to lower case
ldmfd   sp!, {lr}
bx      lr

//-------------------------------------------------------
Palindrome:
/*
-------------------------------------------------------
Determines if a string is a palindrome.
-------------------------------------------------------
Parameters
  r4 - address of first character of string to test
  r5 - address of last character of string to test
Uses:
  r6 - first character
  r7 - second character
  r8 - variable calculations register
Returns:
  r0 - returns True (1) if palindrome, False (0) otherwise
-------------------------------------------------------
*/

//=======================================================
stmfd sp!, {r1-r9, LR}	// preserve registers and LR

//mov r0, #1	// Assume true until proven false

ldrb r6, [r4]	// load first character into r2
ldrb r7, [r5]	// load last character into r3

// base case
sub r8, r5, r4	// check length of string remaining
cmp r8, #1
ble _paltrue		// return true if base case reached

// skip non character first letter
mov r2, r6		// setup parameter for test
bl isLetter
cmp r0, #0
addeq r4, r4, #1	// skip current character if not letter
bleq Palindrome
beq _palindrome

// skip non character last letter
mov r2, r7
bl isLetter
cmp r0, #0
subeq r5, r5, #1	// skip current character if not letter
bleq Palindrome
beq _palindrome

// check if not palindrome
mov r2, r6
bl toLower		// make sure first character is lowercase
mov r6, r2

mov r2, r7
bl toLower		// make sure last character is lowercase
mov r7, r2

sub r8, r6, r7	
cmp r8, #0		// check if same character
bne	_palfalse	// return false if not the same

// increment start and end and call palindrome again
add r4, r4, #1
sub r5, r5, #1

// debugging prints
//ldr     r1, =UART_BASE  // Load UART base address
//mov r2, r6
//bl PrintChar
//mov r2, r6
//bl PrintChar


bl Palindrome

b _palindrome	// for whatever reason if no case met end the function as is

_paltrue:
mov r0, #1	
b _palindrome	// if base case reached

_palfalse:
mov r0, #0
b _palindrome	// if not a palindrome

_palindrome:	
ldmfd sp!, {r1-r9, PC}	// function return

//=======================================================

//-------------------------------------------------------
.data
Test1:
.asciz "otto"
_Test1:
Test2:
.asciz "RaceCar"
_Test2:
Test3:
.asciz "A man, a plan, a canal, Panama!"
_Test3:
Test4:
.asciz "David"
_Test4:

.end