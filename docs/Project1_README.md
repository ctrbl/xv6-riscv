# OS6611 Project 1 - Chau Nguyen

Project 1 includes the implementation of 2 Uniq commands, uniq and head, as both user programs and system calls. The xv6-riscv system has subdirectories, kernel and user, to separate the kernel space and user space. 

## Logic for uniq command
- Test file: xv6-riscv/uniqtest.txt

The uniq command in Linux reports or filters out the repeated lines in a file by detecting the adjacent duplicate lines. Instead of printing the filtered data to the output file, our uniq command writes these data to the console. 

To implement the uniq command, the program first processes all flags, such as "-c", "-i", "-d", and any combination of these three flags (i.e., "-ci", "-i -d"). If the program counters the first argument that does not start with '-', then it attempts to read the text file with that filename. If the program is not able to read the file (i.e., the file does not exist), then the program prints out an error message and exit. Else, the user program calls the system call uniq with the input file, buffer address in the user space, and the flags. 

In the kernel space, the program attempts to read the input file by storing the file in the user-space buffer (with a buffer size of 512 bytes). To be able to access what is read in the input file, the kernel copies the string in the user virtual address to the kernel buffer (with the same buffer size) using the function copyinstr(). As the program iterates through every character in the buffer, it stores each character in the string called "line". Once it counters a newline character, the string "line" is compared against another string called "prev_line" (we will initialize "prev_line" to be an empty string). If the "-i" flag is on, then we compare these strings with insensitve case using the helper function my_strcasecmp(). We initialize an integer variable called "repeated" to 0. If the current string "line" is the same as the previous string "prev_line", we increment the value of "repeated".

Else, we call a helper function, called print_str(), to process the "-c" and "-d" flags and print the previous string stored in "prev_line". To make sure the program does not print the empty string "prev_line" when it just finishes reading the first line in the file, we have to initialize another flag called "printed" to 1. In all other cases, printed is set to 0 to activate the print_str() function. If the "-d" flag is on and repeated is 0, then we do not need to print the previous string since it is a non-duplicate line. Thus, only print the previous string when the "-d" flag is off or the value of "repeated" is greater than 0. In case the "-c" flag is on, then print the number of times the previous sring is repeated followed by a space before printing the previous string.

For the flag options:
- pipe: If the number of command-line arguments is <= 1, then let the program read from standard input 
- "-c": Print the number of times the previous string is repeated
- "-i": Use the helper function my_strcasecmp() to compare strings with insensitive case, instead of the regular strncmp()
- "-d": Only print the previous string if the number of times it repeats is greater than 0

Note: this uniq implementation only processes one single file. The use of multiple flags (i.e., "-c -i" or "-ci") is permitted. 

## Logic for head command
- Test file: xv6-riscv/headtest.txt

The head command in Linux prints the top N number lines of data from the given input file(s). 

To implement the head command, the program check if the command line indicates the number of lines to be printed, else it keeps the default number (N) as 14. In my head implementation, I allow 2 ways for the user to specify N, using -"number" and -n "number". If the "number" contains any non-digit character, the program prints "invalid option" or "invalid number of lines", correspondingly, and exit. Else, it stores the number of lines in variable "count" (which is default to 14).

If "count" is kept as default, we initialize the index i to be 1. Else, we modify index i to the first index where the first text file should be. The user program attempts to read the file and call the system call head if the file is readable. This step is similar to the uniq implementation above.

Once inside the kernel space, initialize a variable "line" to 0 to keep track of the number of lines read. The program reads the file and stores in a user buffer of size 512. If file is not readable, print a read error message and exit. Else, the kernel copies the string from the user buffer to the kernel buffer. As it iterates through each character in the kernel buffer, increment "line" if it encounters a new line character. At anytime when "line" is greater than "count", exit the program. Else, attempt to print the character to the console. If there is an error, print a write error message and exit.

Note: this head implementation allows 2 ways to modify the number of lines to be printed (-"number and -n "number)

## Run the program

First change directory to ./xv6-riscv/
To run the program in the xv6-riscv folder, do the following:

```bash
$ make clean
$ make
$ make qemu
```

Once inside of xv6:
- Run uniq
```bash
$ uniq filename.extension
$ uniq -flag filename.extension               // Run uniq with flags as specified above
$ uniq [-c | -i | -d] filename.extension // Allow to have 1 input file with multiple flags 
$ cat filename.extension | uniq               // Pipeline filename 
```

- Run head 
```bash
// Run head with standard input
$ head

// Run head with modified N and standard input
$ head -"some number" 
$ head -n "some number"

// Run head with one or multiple files
$ head filename1.extension filename2.extension ... 

// Run head with modified N for multiple files         
$ head -"some number" filename1.extension filename2.extension ... 
$ head -n "some number" filename1.extension filename2.extension ...
```

## Resources
- Online resources: 
  - How to add a system call in xv6: https://hackmd.io/@MarconiJiang/xv6_analysis?utm_source=preview-mode&utm_medium=rec
  - How to pass a value to a system call in xv6: https://stackoverflow.com/questions/46870509/how-to-pass-a-value-into-system-call-xv6
  - Understanding flags of uniq: https://www.geeksforgeeks.org/uniq-command-in-linux-with-examples/
  - Logic for multi-flag uniq (using Apple's source code): https://opensource.apple.com/source/text_cmds/text_cmds-71/uniq/uniq.c.auto.html
  - Logic for tail command (used to help with implementing head): https://github.com/garagakteja/Custom-Unix-Commands/blob/master/tail.c
