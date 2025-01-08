# xv6-riscv
Implementing system calls, process scheduling algorithms, and virtual memory for xv6 operating system in C. Source code: https://github.com/mit-pdos/xv6-riscv

## System and software: Mac M1, Ubuntu 22.04 on UTM, xv6-riscv

# OS6611 Project 1 

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
   
# OS6611 Project 2 - Chau Nguyen 

Project 2 includes two parts: getting the process statistics and modifying system calls and implementing the ps command. 

## Implementation
### Part 1: Getting process statistic and modifying system call

The first part includes adding the fields to struct proc, including the process' creation time, end time, and total processing time, modifying the existing system calls in kernel space to change the values of those fields, and creating a user space program to call uniq or head (or both) and display all the time fields of the process in the console. The steps are as follow:

1) Add the time fields to struct proc in /kernel/proc.h.
2) In /kernel/proc.c, set process creation time to current ticks in allocproc() system call. Set process' end time to current ticks and total time to the difference of the two in exit() system call. 
3) In /user/test.c, array functions hold all the allowed function calls that could be tested.
4) Iterate through each argument and check if it is in array functions. 
5) If it is, fork a new process and exit if fail. 
6) Create a new array of arguments for child process (include every argument before the next function call in a new array called args).
7) Call exec() to start child process with its arguments.
8) Wait for child process to terminate with new system call waitx().
9) Display the child process' time fields once waitx() returns.

Note: functions currently have 'uniq', 'head', 'cat', and 'echo' and can add more.

####Implementation of waitx():

Similar to the wait() system call, but it takes 3 additional arguments to modify: address of the creation time, end time, and total time of child process. Before freeing the exited child process, use copyout() to set the value at each address in user space.

Note: the arguments hold the address of the time variables in user space

####Conversion from ticks to seconds

In ./xv6-riscv/kernel/start.c, the timerinit() has a variable called interval, which states that an interval is about 1/10th second. So 1 second is about 10 ticks. I created a function in ./xv6-riscv/kernel/printf.c called convertTicks() to print out the equivalence of ticks in minutes and seconds (format min:sec.tenth).

### Part 2: Implementing ps command

The second part requires to create a ps command, which provides information about process(es). The information to be displayed includes PID, status, start time, total time, and name. The custom ps allows the user to specify if they want to search the process by PID, name, or to list all processes. The steps are as follow: 

1) Create a kernel space system call ps(), which takes in 3 arguments: option, value, and address.
2) Option 0: Find all processes. Option 1: Find by PID. Option 2: Find by name.
3) For option 1 & 2, iterate through each process in process table. If that process has either PID or name matches the input, then print out its information. If not found, print message and exit.
4) For option 0, iterate the process table and print information of every process.

Note 1: This implementation is similar to the existing procdump() system call and uses no lock to avoid wedging a stuck machine further.
Note 2: The start time, total time, and running time are displayed in format min:sec.tenth. 
Note 3: Running time is the time a process has spent executing on the CPU. Running time = current time - creation time.
Note 4: This custom ps does not print out completed processes (those that have been terminated). This is because when a process terminates, its memory is freed from the process table. 

## Run the program

First change directory to the ./xv6-riscv/ folder. To run the program, do the following:

```bash
$ make clean
$ make
$ make qemu
```

Once inside of xv6:
- Run test
```bash
// Run uniq separately
$ test uniq [-c|-i|-d] uniqtest.txt

// Run head separately
$ test head
$ test head [-<number> | -n <number>] headtest.txt
$ test head [-<number> | -n <number>] test1.txt test2.txt ...

// Run multiple programs together
$ test uniq [-c|-i|-d] uniqtest.txt head [-<number> | -n <number>] headtest.txt
$ test echo <message> uniq <file> cat <file>
```

- Run ps
```bash
// Get all processes
$ ps

// Get process by PID
$ ps -p <PID>

// Get process by name
$ ps -n <name>
```

## Resources:
- Online resources: 
  - How to create system call: https://hackmd.io/@MarconiJiang/xv6_analysis?utm_source=preview-mode&utm_medium=rec
  - Convert ticks to a readable format: https://github.com/dsa-shua/xv6-riscv-projects/blob/main/ps/kernel/sysproc.c
  - Linux ps manual: https://man7.org/linux/man-pages/man1/ps.1.html
  - Custom ps implementation (without flags): https://medium.com/@harshalshree03/xv6-implementing-ps-nice-system-calls-and-priority-scheduling-b12fa10494e4

# OS6611 Project 3 - Chau Nguyen 

Project 3 includes two parts: creating FCFS and priority based scheduling methods 

## Implementation
### Part 1: FCFS

The first part includes implementing the FCFS in the scheduler in proc.c. To differentiate between the different types of scheduler, I created a set_scheduler function in order to set the type (0 for default (ROUND ROBIN), 1 for FCFS, and 2 for PRIORITY). 

This is done by modifying the scheduler by comparing the process's creation time in the proctable and choosing the one with the earliest creation time. 

The wait time is calculated as the start time of the process - the creation time of the process.
The turnaround time is the end time of the process - the creation time of the process. 

Note, I'm not using the arrival time to the queue because of my implementation and structure of the test.c file. 

- Implementation in test.c:
    - For each argument in the command line, we check if it is one of our allowed functions ("uniq" for user space uniq, "uniq_k" for kernel space uniq, "head" for user space head, "head_k" for kernel space head, "echo", "cat")
    - If it't not, we keep iterating. Else, we fork a new process. 
    - For the new process, use function findArgs to find all the necessary arguments for the current function (similar to Project 2 implementation). For example: ["uniq_k", "-cid", "uniqtest.txt"] is our args.
    - Then, we only need to call exec for this program with its args.
    - Then, we wait for the child process to finish and print the wait and turnaround times for it. 
    - Note, for the statistics for each process, we will not use or modify the ps command. This is because when the process finishes executing, its state will become ZOMBIE and its entry will be removed from the proctable. So, instead, we will just print these stats in the waitx() system call already implemented in the proc.c file. 
    - We also need to modify the waitx() system call to modify the user space's wait time and turnaround time of the process, rather than the times recorded in Project 2. 
    - To get the average times, we need 2 variables for the total wait and turnaround times. We will increment the number of processes variable (proc_count) for each program getting executed from the command line args. For each time a child process finishes executing, we add its wait and turnaround time to the total times for each. 
    - When every process finishes executing (when we are done iterating argv), just calculate and display the average times by dividing each by  proc_count. 

### Part 2: Priority 

The second part includees the implementation of the Priority based scheduling method. This is done by modifying the scheduler (in the case that the scheduler type is 2). We can do this by adding another field to the proc.h, called priority. The default priority is set to 10 in the param.h file. While looping through the proctable, find the highest priority (the priority value with the lowest value) and select this process. 

Note: Due to short quantum time in the default Round Robin scheduler, I was having trouble printing out the outputs for the processes with priority. They were gettting mixed up. 
- Thus for the test.c, I have to pre-schedule the command-line arguments. 
- Implementation of pre-scheduling for PBS in test.c:
    - Create another array to store the new ordered arguments.
    - Similar to my project 2 implementation, find all the arguments necessary for the current function (e.g. "uniq -cid uniqtest.txt") using the function findArgs. Let's call this args. 
    - Append this to the new array (new_argv).
    - If it is default priority (meaning kernel space programs get executed first before user space program), then we let priority of kernel process to be 1 and user process to be 2.
    - Else if there is a custom priority in the command line, we have already added it in new_argv.
    - Now, compare the current args with the args right before it. If it has a higher priority (lower value), then we switch the place of these args. If they are equal, don't make any changes (this is basically FCFS). Else, don't make any changes since it has a lower priority. 
- With this new_argv, we structure it similar to the default and FCFS scheduling type in test.c. However, we only need to set the priority field for each child process getting executed (exec()) and remove that value from the args to make sure that exec doesn't try to execute the priority value. 

- Note: for the default PRIORITY to work, please run other test cases first before this. This is a minor bug that I couldn't figure out how to fix on time. 

## Run the program

First change directory to the ./xv6-riscv/ folder. To run the program, do the following:

```bash
$ make clean
$ make
$ make qemu
```

Once inside of xv6:
- Run test examples:
```bash
// DEFAULT scheduler 
$ test uniq -c uniqtest.txt uniq_k -i uniqtest.txt
$ test head_k -3 headtest.txt head -3 headtest.txt

// FCFS scheduler 
$ test FCFS uniq uniqtest.txt uniq_k uniqtest.txt
$ test FCFS head_k -5 headtest.txt head -5 headtest.txt

// Custom PRIORITY 
$ test PRIORITY uniq_k uniqtest.txt 2 uniq uniqtest.txt 1
$ test PRIORITY head_k headtest.txt 2 head headtest.txt 1

// Default PRIORITY - please run this last after running the others 
$ test PRIORITY uniq uniqtest.txt uniq_k uniqtest.txt
$ test PRIORITY head headtest.txt head_k headtest.txt
```

## Resources:

- Online resources: 
  - How to create system call: https://hackmd.io/@MarconiJiang/xv6_analysis?utm_source=preview-mode&utm_medium=rec
  - Convert ticks to a readable format: https://github.com/dsa-shua/xv6-riscv-projects/blob/main/ps/kernel/sysproc.c
    - Note: I also change the interval in start.c, which makes it more readable. Decreasing that interval basically makes the unit of seconds smaller (before interval was 1,000,000 which is ~1/10th of a second, after interval is 1,000 which is ~1/10000th of a second)
  - Priority scheduler implementation: https://medium.com/@harshalshree03/xv6-implementing-ps-nice-system-calls-and-priority-scheduling-b12fa10494e4
    - Note: This is in xv6-public and my implementation differs a bit due to the lock implementation in riscv.
    
# OS6611 Project 4 - Chau Nguyen

## Project 4 
- This project includes understanding the VM layout of xv6 in order to unmap the first 3 pages in part 1 and rearrange the user address space from code-stack-heap to code-heap-stack with a gap between the heap and stack. 

## Part A: Null Pointer Dereference
- Test files: These test files each sets a pointer at address 0x0, 0x1000, and 0x2000, respectively, and tries to access the value at that pointer. 
    - user/null1.c
    - user/null2.c
    - user/null3.c

- Before any implementation, if we dereference a null pointer, instead of seeing an exception, we will see whatever code is in the first bit of code in the program that is running. This is because the user first program (initcode.S) is loaded into the very first part of the user address space (address 0x0) in xv6. 

  ![Alt text](</images/null_before_xv6.png>)

- In Linux, if we implement the same files using C libraries, compile, and run them, we will get segmentation fault trying to access these pointers. Note, I compile and run these files in Ubuntu. 
  ![Alt text](</images/null_before_linux.png>)
  - Accessing memory at address 0x0 (null1.c) is not allowed for regular user-space processes because the operating system uses that address to represent a null pointer. Attempting to read or write to address 0 is considered a violation of memory protection, and Linux responds by sending a segmentation fault signal to the process. This signal typically terminates the program to prevent it from causing further issues.
  - Dereferencing arbitray memory addresses (like 0x1000 and 0x2000 in null2.c and null3.c), that are not allocated or not a part of the current program, will also cause Linux to send a segmentation fault to terminate the process. 

### Part A Implementation: 
1. Change exec.c line 27: 
```bash 
  // from
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase; 

  // to
  uint64 argc, sz = PGSIZE*3, sp, ustack[MAXARG], stackbase;
```
  - This allows the pagetable to be allocated from virtual address 0x3000 (since PGSIZE = 4096 bytes = 0x1000). This basically unmaps the first 3 pages of the pagetable by starting allocating from the 3rd page. 

2. In proc.c:userinit, change program counter and stack pointer of the first user program
```bash 
  // from
  p->trapframe->epc = 0;                 // user program counter
  p->trapframe->sp = PGSIZE;             // user stack pointer 

  // to
  p->trapframe->epc = PGSIZE*3;          // user program counter
  p->trapframe->sp = PGSIZE*3 + PGSIZE;  // user stack pointer
```
- This loads the first user program (init in initcode.S) to the starting address at 0x3000 instead of 0x, skipping the first 3 pages. The stack pointer will also incremented by the same offset. 

3. In vm.c:uvmfirst, change:
```bash
  // from
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);

  // to
  mappages(pagetable, PGSIZE*3, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
```
- This is because proc.c:userinit calls uvmfirst to allocate a user page and load in it the first user program in initcode. To change the starting location of this first allocated user page, we need to change the virtual address argument from 0 to PGSIZE*3. 

4. In vm.c:uvmcopy, change:
```bash
  // from
  for(i = 0; i < sz; i += PGSIZE) { }

  // to 
  for(i = PGSIZE*3; i < sz; i += PGSIZE) { } 
```
- This is because proc.c:fork copies the user memory from the parent process to the child process using uvmcopy. Since the starting address of our user page table has been changed to 0x3000, instead of 0x0, we need to change the starting i value accordingly. This loop loops through each user page in the parent's process and copies it to the child process's. 

5. In vm.c:uvmfree, change:
```bash
  // from
  if(sz > 0) {
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  }

  // to 
  if(sz > PGSIZE*3) {
    struct proc *p = myproc(); 
    uvmunmap(pagetable, PGSIZE*3, PGROUNDUP(sz - PGSIZE*3)/PGSIZE, 1);
  }
  else if(sz > 0) {
    uvmunmap(pagetable, PGSIZE*3, PGROUNDUP(sz)/PGSIZE, 1);
  }
```
- Since we are freeing user memory pages with a certain size, the calculation of the number of pages (npages) for uvmunmap differs for when the size is > 0x3000 and when the size is > 0 and <= 0x3000. 

6. In vm.c:uvmcopy, for err case still need to change: 
```bash
  // from 
  uvmunmap(new, 0, i / PGSIZE, 1);

  // to
  uvmunmap(new, PGSIZE*3, i / PGSIZE, 1);
```
- Just to be safe, since the first 3 pages are unmapped, should start unmapping from 0x3000, instead of 0x0. 

7. In syscall.c:fetchaddr, change:
```bash
  // from
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) { }

  // to
  if(addr >= p->sz + PGSIZE*3 || addr+sizeof(uint64) > p->sz + PGSIZE*3) { }
```
- This checks if the input address is within the new user address space starting from address 0x3000, instead of 0. Without this change, the first condition will fail and return -1, causing a "panic: init exiting" error because init will try to exit. 

8. In syscall.c:fetchstr, add:
```bash
  // add
  if (addr < PGSIZE*3) addr += PGSIZE*3; 
  // before 
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    return -1;
```
- Just in case some unchanged functions did not consider the new starting address and calls fetchstr with an unmapped virtual address. Without this change, a "panic: init exiting" error will occur because copyinstr will call walk, which calls walkaddr to look up an unmapped virtual address. Walkaddr will return 0 because that virtual address is not mapped. 

9. In Makefile, add/modify the following changes:
```bash
  // add -Ttext 0x3000
  _%: %.o $(ULIB)
    $(LD) $(LDFLAGS) -T $U/user.ld -o $@ $^ -Ttext 0x3000 

  // change -Ttext 0 to 0x3000
  $U/_forktest: $U/forktest.o $(ULIB)
    $(LD) $(LDFLAGS) -N -e main -Ttext 0x3000 -o $U/_forktest $U/forktest.o $U/ulib.o $U/usys.o
```
- We have to change the entry point of code segment if the first 3 pages are unmapped. 

### Null Pointer Deference:
- After unmapping the first 3 pages, deferencing any pointer from (0x0 to 0x2fff) will cause user trap, which kills the process due to protection fault. This is because the program tries to access protected memory. 
  ![Alt text](</images/null_after.png>)

### Changes to older user programs:
- uniq: 
```bash
  $ uniq -cid uniqtest.txt
```
  ![Alt text](</images/p1_uniq.png>)

- head: 
```bash
  $ head -5 headtest.txt
```
  ![Alt text](</images/p1_head.png>)

- ps:
```bash
  $ ps
```
  ![Alt text](</images/p1_ps.png>)

- test:
```bash
  // default scheduler
  $ test head -3 headtest.txt uniq -d uniqtest.txt 
```
  ![Alt text](</images/p1_test.png>)

```bash
  // FCFS scheduler
  $ test FCFS uniq -i uniqtest.txt uniq_k -c uniqtest.txt
```
  ![Alt text](</images/p1_test_FCFS.png>)

```bash
  // PRIORITY scheduler (default)
  $ test PRIORITY head -3 headtest.txt head_k -3 headtest.txt
```
  ![Alt text](</images/p1_test_PRIORITY.png>)

- These screenshots show that even when we unmap the first 3 pages in the pagetable, every user program (and kernel program like uniq_k, head_k, etc.) still behaves the same way. **There are no changes.**

## Part B: Stack Rearrangement
- The goal of part B is to rearrange the user address space from code-stack-heap to code-heap-stack (or move the user stack to the high end of the xv6 user address space). There should also be at least a 5-page gap between the heap and user stack. The stack pointer of the first user stack should be at USERTOP, or address 0xA0000. When it is needed, the stack should be able grow downwards when there is a page fault occurs at the page above the user stack. 

### Part B Implementation: 
- We need to make the following modifications to the kernel code to rearrange the user address space:

1. In memlayout.h, add:
```bash
  #define USERTOP 0xA0000 
```
- The high end of the xv6 user address space is 640KB, or at 0xA0000.

2. In proc.h, add:
```bash
  uint64 stack_sz;             // Size of user stack
```
- In the original struct proc, field sz tracks the size of the process (in bytes). We will still keep this field to track the size of the code and heap. But we will use the new field stack_sz to track the size of the user stack, or more like the starting address of the user stack. 

3. In exec.c:exec, we will comment out this code segment and add:
```bash
  /* ORIGINAL CODE */
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible as a stack guard.
  // Use the second as the user stack.
  // sz = PGROUNDUP(sz);
  // uint64 sz1;
  // if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
  //   goto bad;
  // sz = sz1;
  // uvmclear(pagetable, sz-2*PGSIZE);

  sz = PGROUNDUP(sz); 
  uint64 sz1, stack_sz = USERTOP - PGSIZE;
  if((sz1 = uvmalloc(pagetable, stack_sz, USERTOP, PTE_W)) == 0) 
    goto bad; 

  sp = sz1; 
  stackbase = sp - PGSIZE;
```
- In the original code, we allocate 2 pages following the user loaded code. The first page is inaccessible and acts as a stack guard. The second page is the user stack. However, we do not need this 1-page stackguard as we will have 5 or more pages as a gap between the heap and the user stack on top. 
- This uvmalloc allocates the first user stack page starting at address USERTOP - PGSIZE and ending at address USERTOP. This stack is only allocated 1 fixed page size. 

- We also need to save the stack_sz field of the current process by adding to this segment:
```bash
  // Commit to the user image.
  oldpagetable = p->pagetable;
  p->pagetable = pagetable;
  p->sz = sz;
  p->trapframe->epc = elf.entry;  // initial program counter = main
  p->trapframe->sp = sp; // initial stack pointer

  // Add this
  p->stack_sz = stack_sz;   // update this as the stack grows
```

4. In proc.c:userinit, change: 
```bash
  // from in part A
  p->trapframe->sp = PGSIZE*3 + PGSIZE;  // user stack pointer

  // to
  p->trapframe->sp = USERTOP;               // user stack pointer
```
- This sets the stack pointer at the highest address of the user address space, USERTOP (or 0xA0000).

5. In proc.c:fork, add:
```bash
  np->stack_sz = p->stack_sz;
```
- This copies the parent process's stack size to the child process's when fork is called. In this function, other fields of the parent process's pagetable is also copied to the child process's pagetable. 

6. In proc.c:growproc, add:
```bash
  // prevent allocation to ensure 5 pages gap between stack and growing heap
  sz = p->sz;
  if((sz + n + 5*PGSIZE) > (proc->stack_sz))
      return -1;
```
- This prevents the heap from growing into the stack by making sure that there is at least 5 pages between the end of heap (current process's size + n allocating bytes) and the user stack's starting address (or proc->stack_sz). 

7. In vm.c:uvmalloc, add:
```bash
  if(newsz > USERTOP)   // cannot alloc
    return 0;   
```
- This makes sure to not grow the process by allocating more pages to it if the new size exceeds the USERTOP. 

8. In vm.c:uvmcopy, add this segment below the first for loop:
```bash
  struct proc *p = myproc(); 
  for(i = p->stack_sz; i < USERTOP; i += PGSIZE){
    // Copy the last page which is the new stack
    if((pte = walk(old, i, 0)) == 0)
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0) 
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);      // what pa are they getting from pte
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE); // copying some stuff.. figure out what 1 page is and copying it
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0) // mapping into new address space and making it valid
      goto err;
  }
```
- This copies the user stack's pages from the parent process's pagetable to the child process's. This is done by looping through all the user stack's pages, starting from the lowest address (this actually holds the newest user stack since the user stack grows downwards) up until USERTOP. The increment size is PGSIZE, since each stack page has a page size of 4096 bytes. 

9. In vm.c:uvmfree, add:
```bash
  if(sz > PGSIZE*3) {
    struct proc *p = myproc(); 
    uvmunmap(pagetable, PGSIZE*3, PGROUNDUP(sz - PGSIZE*3)/PGSIZE, 1);

    // add this
    uvmunmap(pagetable, p->stack_sz, (USERTOP - p->stack_sz)/PGSIZE, 1); 
  }
```
- The line uvmunmap(pagetable, p->stack_sz, (USERTOP - p->stack_sz)/PGSIZE, 1) actually unmaps all the allocated pages in the userstack. In part A, we count the stack guard and the 1-page user stack as part of the sz field in struct proc. However, in this part, the field sz only holds the size of the user code and heap. So without adding anything to the code in part A, we have only unmapped the user code and heap pages. This will cause "panic: freewalk: leaf" since the user stack pages are unmapped. 
- Thus, the added line will help unmap the user stack pages, starting from the lowest address of the user stack (which holds the latest user stack page). The number of user stack pages is calculated as (USERTOP - p->stack_sz)/PGSIZE. 

10. In syscall.c:fetchaddr, modify:
```bash
  // from
  if(addr >= p->sz + PGSIZE*3 || addr+sizeof(uint64) > p->sz + PGSIZE*3) // both tests needed, in case of overflow 
    return -1;

  // to
  if (p->pid == 1 && p->stack_sz == 0) {
    if(addr >= p->sz + PGSIZE*3 || addr+sizeof(uint64) > p->sz + PGSIZE*3) // both tests needed, in case of overflow 
      return -1;
  } else {
    if((addr >= p->sz + PGSIZE*3 && addr < p->stack_sz) ||
        (addr+4 > p->sz + PGSIZE*3 && addr+4 < p->stack_sz) ||
        addr < PGSIZE*3 || addr+4 > USERTOP) 
          return -1;
  }
```
- When it is the first user process (init), where the user stack has not been allocated, we will use the old condition in part A to check if the virtual address is within the current process's page. 
- Else, the second if condition also checks if the virtual address is valid within the new user address space:
  - (addr >= p->sz + PGSIZE*3 && addr < p->stack_sz): checks that the address does not exceed the end of the process's allocated memory or has to be in the user's stack. 
  - (addr+4 > p->sz + PGSIZE*3 && addr+4 < p->stack_sz): similar to the first condition, but check the next instruction's address. 
  - (addr < PGSIZE*3 || addr+4 > USERTOP): check that address does not access the first 3 unmapped pages or exceeds the USERTOP.
- **Note:** that we do not need to modify syscall.c:fetchstr, since copyinstr will call walkaddr, which already validates if the virtual address is valid. This is similar to how we do not need to validate the virtual address for syscall.c:argaddr for both parts A and B, since copyin/copyout will help us validate. 

11. In trap.c, add:
```bash
  if(r_scause() == 8) { } 
  else if (r_scause() == 14 || r_scause() == 15) {
    // Page fault
    if(p->trapframe->sp < p->stack_sz){
      uint64 stack_addr = r_stval(); 
      if (stack_addr <= p->stack_sz && stack_addr >= p->stack_sz-PGSIZE && p->stack_sz-PGSIZE*6 >= p->sz) {
        if((uvmalloc(p->pagetable, p->stack_sz-PGSIZE, p->stack_sz, PTE_W)) != 0) {
          p->stack_sz -= PGSIZE; 
          p->parent->stack_sz -= PGSIZE;
        } 
      } else {
        // Segmentation fault. Kill process.
        printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
        printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
        setkilled(p);
      }
    } else {
      printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
      printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
      setkilled(p);
    }
  }
```
- If there's a page fault (i.e., stack wants to grow beyond USERTOP), then this code segment makes sure to grow the stack in a downward direction. The r_scause() values we need to consider are 14 and 15. 
  - (stack_addr <= p->stack_sz && stack_addr >= p->stack_sz-PGSIZE && p->stack_sz-PGSIZE*6 >= p->sz): makes sure to keep at least 5 pages as a gap between the end of the heap and the starting address of the latest user stack. 
  - If a new page is allocated successfully, then update the starting address of the user stack for that process. 
  - However, since the child process's stack size is not copied to the parent process's when the child process exits, we have to add this line p->parent->stack_sz -= PGSIZE. Without this, it will cause a leaf page (or more) to not be freed correctly, causing "panic: freewalk: leaf" error when testing user/stack3.c. This is because xv6's way of freeing the pagetable recursively requires us to keep track of the stack size to calculate the correct number of pages for the current process's stack. 

### Running testfiles:
- user/stack2.c: stack grows downwards on page fault
- user/stack3.c: a recursive program that forces the first user stack to be full, causing a page fault; test to see that stack is able to grow downwards on page fault.
- user/bounds2.c: checks that the user stack is at the top of user address space; check order of code-heap-stack
- user/heap.c: checks that heap can grow up to 5 pages below stack 
- user/heap2.c: checks that heap cannot grow into the user stack (since there exists at least 5-page gap between them)
  ![Alt text](</images/p2_tests.png>)

### Changes to older user programs:

- uniq: 
```bash
  $ uniq -cid uniqtest.txt
```
  ![Alt text](</images/p2_uniq.png>)

- head:
```bash
  $ head -5 headtest.txt
```
  ![Alt text](</images/p2_head.png>)

- ps:
```bash
  $ ps
```
  ![Alt text](</images/p2_ps.png>)

- test:
```bash
  // default scheduler
  $ test uniq_k uniqtest.txt head_k -5 headtest.txt uniq -cid uniqtest.txt head -1 headtest.txt
```
  ![Alt text](</images/p2_test.png>)

```bash
  // FCFS scheduler
  $ test FCFS uniq -c uniqtest.txt head_k -2 headtest.txt uniq_k -d uniqtest.txt
```
  ![Alt text](</images/p2_test_FCFS.png>)

```bash
  // PRIORITY scheduler (custom)
  $ test PRIORITY head -3 headtest.txt 1 head_k -3 headtest.txt 5
```
  ![Alt text](</images/p2_test_PRIORITY.png>)

```bash
  // PRIORITY scheduler (default)
  $ test PRIORITY uniq -cid uniqtest.txt head_k -1 headtest.txt
```
  ![Alt text](</images/p2_test_PRIORITY_def.png>)

- These show that there are no changes in the user programs, as well as kernel programs, after we have rearranged the user address space by moving the user stack on top, keeping at least 5 pages as a gap between the end of the heap and the user stack. We also keep the first 3 pages unmapped like part A. All the schedulers, including DEFAULT, FCFS, and PRIORITY (both custom and default PRIORITY) still behave the same as Project 3. Note that I have fixed the bugs in Project 3 where if uniq_k runs right after boot time caused a kernel trap. See the Debugging section below for more information. Therefore, the memory layout modifications we did in this project did not change the way our old user and kernel programs work. 

## Run the program

- First change directory to ./xv6-riscv/
- To run the program in the xv6-riscv folder, do the following:

```bash
  $ make clean
  $ make
  $ make qemu
```
- make clean:
  ![Alt text](</images/make_clean.png>)
- make:
  ![Alt text](</images/make.png>)
- make qemu:
  ![Alt text](</images/make_qemu.png>)


## Debugging & Changes to Previous Code:
- Increase number of args allowed in user/sh.c from 10 to 20:
```bash
#define MAXARGS 20
```
- In Project 3, I increased the buffer size in proc.c from 512 to 1024 to get rid of the bugs in Project 1. But this actually creates a bug where if you first boot the kernel and run "uniq_k uniqtest.txt", it will generate a kernel trap. This is because we have to create 3 char buffers, each of size 1024 bytes. I think due to the size of each buffer, it has caused the kernel trap. Therefore, I keep all the buffer size across proc.c, uniq.c, head.c, uniq_k.c, and head_k.c to 512. Keeping the buffer size as 512 bytes helps removing the bug in the submitted Projects 1 & 3 where it exec fails or it gets a kernel trap. 
  - In Project 3, I note that running "test PRIORITY uniq uniqtest.txt uniq_k uniqtest.txt" right after the kernel boots will cause a kernel trap. But keeping a consistent and small buffer size of 512 helps removing the problem. 

## Resources
- Online resources: 
  - First user process: https://pekopeko11.sakura.ne.jp/unix_v6/xv6-book/en/The_first_process.html
  - How to use gdb in Docker for xv6-riscv: https://www.youtube.com/watch?v=mkTIOiGpykg
  - Test programs for part B: https://github.com/clarkzinzow/xv6-extensions/tree/0c6322001e54e4cbdc71c29a0d02e31104161230/src/xv6-vm-features/user
  - Part B implementation for xv6-public: https://github.com/abhinav4192/Operating-System-Projects/tree/master/P3
  - Part A implementation for xv6-public: https://github.com/mwfj/Operating_System-xv6/tree/master/project_2

- Note: Due to the complexity of the project, I had to follow the implementation from xv6-public. However, there are many differences in the functions used to implement the memory between xv6-public and xv6-riscv. So, I still needed to debug and make many additional changes for it to work for the xv6-riscv version. 

   




