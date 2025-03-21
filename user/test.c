#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/spinlock.h"
#include "user/user.h"

// Allowed functions for test (add if necessary)
char *functions[] = {
  "uniq", 
  "uniq_k",
  "head",
  "head_k",
  "cat",
  "echo"
};

const int functions_length = sizeof(functions) / sizeof(functions[0]);

int findArgs(int argc, char *argv[], char *args[], int i) {
  int n, j; 
  for (j = i; j < argc; j++) {
    // Process args for current function call (up until the next function call)
    if (j == i) 
      args[j-i] = argv[j]; 
    else {
      for (n = 0; n < functions_length; n++) {
        if (!strcmp(argv[j], functions[n]))
          break; 
      }
      if (n == functions_length)
        args[j-i] = argv[j]; 
      else break; 
    }
  }
  args[j-i] = 0;		// null terminated args array
  return j; 
}

int isFunction(char *arg) {
  int n; 
  for (n = 0; n < functions_length; n++) {
    if (!strcmp(arg, functions[n]))  
      break; 
  }
  return (n != functions_length); 
}

void int_to_ascii(int num, char str[]) {
    int i = 0;

    // Extract digits in reverse order
    while (num > 0) {
        int digit = num % 10;
        str[i++] = '0' + digit;
        num /= 10;
    }

    // Reverse the string
    int start = 0;
    int end = i - 1;
    while (start < end) {
        char temp = str[start];
        str[start] = str[end];
        str[end] = temp;
        start++;
        end--;
    }

    // Null-terminate the string
    str[i] = '\0';
}

void separator() {
  char dashes[51]; 
  memset(dashes, '-', 50); 
  dashes[50] = '\0';
  printf("\n%s\n\n", dashes); 
}

// Function to convert ticks to seconds (for more readability)
void convertTicks(int ticks) {
  uint minutes = ticks / 60000; // 1 min = 60 * 1000 ticks
  ticks = ticks % 60000;
  uint seconds = ticks / 1000; // 1 sec = 1000 ticks
  ticks = ticks % 1000;

  printf("%d:%d.%d", minutes, seconds, ticks);
}

void printStats(const char *str, const char *str1, const char *str2, const int val1, const int val2) {
  printf("%s\t\t| Ticks\t\t| min:sec", str);  
  printf("\n%s\t\t| %d\t\t| ", str1, val1);  convertTicks(val1); 
  printf("\n%s \t| %d\t\t| ", str2, val2);   convertTicks(val2);  
  printf("\n");
}

int main (int argc, char *argv[]) {
  int pid, i = 1, j, n, proc_count = 0, total_wait = 0, total_turnaround = 0; 
  
  // PRIORITY BASED SCHEDULING
  if (!strcmp(argv[i], "PRIORITY")) {
    separator(); 
    set_scheduler(2);
    i++; 
    char *new_argv[32]; 
    int k = 0, x, size = 0; 

    for (; i < argc; i++) {
      // Check if arg is in functions, if not continue
      if (!isFunction(argv[i])) continue; 
    
      char *args[argc-i+1]; 
      j = findArgs(argc, argv, args, i); 
      // append to new_argv
      n = k; 
      for (x = 0; x < j-i; x++, n++) {
        new_argv[n] = args[x]; 
      }
      // if no custom priorities, use a priority counter 
      if (!isDigit(new_argv[n-1])) {
        x = strlen(argv[i]); 
        if ((argv[i][x-1] == 'k') && (argv[i][x-2] == '_')) {
          new_argv[n] = "1"; 
        }
        else {
          new_argv[n] = "2"; 
        }
      } else n--; 
      size = n+1; 
      // switch place 
      if (k > 0 && atoi(new_argv[n]) < atoi(new_argv[k-1])) {
        for (x = k-1; x >= 0; x--, n--) {
          char *temp = new_argv[x]; 
          new_argv[x] = new_argv[n]; 
          new_argv[n] = temp; 
          if (isFunction(new_argv[x])) break; 
        }
      }
      k = n+1; 
    }
    new_argv[size] = 0; 
    for (i = 0; i < size; i++) {
      // Check if arg is in functions, if not continue
      if (!isFunction(new_argv[i])) continue; 
      
      pid = fork();  
      if (pid < 0) {
        printf("test: fork failed\n");
        exit(1);
      }
      if (pid == 0) {
        char *args[size - i + 1]; 
        j = findArgs(size, new_argv, args, i); 
        set_priority(getpid(), atoi(args[j-i-1])); 
        args[j-i-1] = 0; // don't need priority for exec
        exec(new_argv[i], args); 
        printf("test: %s failed\n", new_argv[i]); 
        exit(0);
      } else {
        proc_count++; 
        int wait_time, turnaround_time;    
        if (waitx(0, &wait_time, &turnaround_time) >= 0) {
          total_wait += wait_time;
          total_turnaround += turnaround_time;
          proc_count++;
          printStats("\nTime\t", "Wait time", "Turnaround time", wait_time, turnaround_time);
          separator(); 
        }
      }
    }
  } else { // DEFAULT AND FCFS
    separator(); 
    // FCFS 
    if (!strcmp(argv[i], "FCFS")) {
      set_scheduler(1); 
      i++;
    }
    for (; i < argc; i++) {
      // Check if arg is in functions, if not continue
      if (!isFunction(argv[i])) continue; 
      
      pid = fork();  
      if (pid < 0) {
        printf("test: fork failed\n");
        exit(1);
      }
      if (pid == 0) {
        char *args[argc - i + 1]; 
        j = findArgs(argc, argv, args, i); 
        // sleep(100);  
        exec(argv[i], args); 
        printf("test: %s failed\n", argv[i]); 
        exit(0);
      } else {
        proc_count++; 
        int wait_time, turnaround_time;   
        if (waitx(0, &wait_time, &turnaround_time) >= 0) {
          total_wait += wait_time;
          total_turnaround += turnaround_time;
          proc_count++;
          printStats("\nTime\t", "Wait time", "Turnaround time", wait_time, turnaround_time);
          separator();    
        }
      }
    }
  }

  printStats("Avg Time", "Avg Wait time", "Avg Turnaround time", total_wait/proc_count, total_turnaround/proc_count);
  separator();

  exit(0); 
}

