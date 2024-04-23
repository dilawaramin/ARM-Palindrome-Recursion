# Recursive Palindrome Checker in ARM Assembly
Welcome to my recursive palindrome checker project! This project uses ARM assembly to checks if a string is a palindrome, recursively. It is designed to handle various inputs, including those with non-alphabetic characters, and determine if they are palindromes. 

This program showcases my ability to implement complex low-level programming tasks efficiently and effectively. It also shows me ability to work directly with memory and registers, as well as with the stack and stack pointer. 

Reminder: A palindrome is a word or a sentence that reads the same backwards or forwards.

## Features
- **Palindrome Checking:** Uses recursive calls to verify if a string is a palindrome, ignoring non-alphabetic characters and case differences.
- **Efficient Character Handling:** Includes functions to identify letters, convert uppercase to lowercase, and handle non-letter characters.
- **UART Functionality:** Implements output to the JTAG UART, allowing the program to run on ARM-based microcontrollers or simulators with UART support.

## Planned Enhancements

### Feature Expansion
- **Unicode Support:** Expand the program to handle Unicode characters, making it usable with a wider range of alphabets.
- **Flexibility:** Develop a user interface for real-time palindrome checking on supported devices.

## Setup
This project is optimized for use with [CPUlater](https://cpulator.01xz.net/?sys=arm-de1soc), a free and open-source ARMv7 emulator. To run the program, simply copy and paste the code into the emulator, click compile, and run from the buttons along the top. To enter custom strings, scroll down to the .data section and enter your own string into any of the test strings.

## Technologies Used
- **ARMv7 Assembly:** The entire program is based on ARMv7 Assembly language.
- **UART for Output:** Uses the JTAG UART for outputting results and debugging information.

## Screenshot

Below is a screenshot from the CPUlator emulator, showing the program after running through all test cases.
![image](https://github.com/dilawaramin/ARM-Palindrome-Recursion/assets/79779873/d3388ab9-ff5d-45c8-8329-c007235c5fd2)

## Acknowledgments

Special thanks to the developers of [CPUlater](https://cpulator.01xz.net/?sys=arm-de1soc) for providing an excellent development environment for ARM programs, and to Dr. David Brown for providing excellent templates for some of the helper functions used. 

## Author

**Dilawar Amin** - Aspiring Full Stack Developer | Computer Science Student

Add me on [LinkedIn](https://www.linkedin.com/in/dilawar-amin-70a39719b/)!

## License

This project is licensed under the MIT License - see the LICENSE file for details.
