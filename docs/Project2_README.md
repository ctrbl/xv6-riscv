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
