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
