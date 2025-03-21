#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"


// Get information about a process (using flag -p or -n) or all processes
int main(int argc, char *argv[]) {  
  if (argc <= 1) {
    ps(0, 0, 0); 
    exit(0);  
  } else if (!strcmp(argv[1], "-p")) {
    ps(1, atoi(argv[2]), 0); 
  } else if (!strcmp(argv[1], "-n")) {
    ps(2, strlen(argv[2]), (uint64)argv[2]); 
  } else {
    printf("ps: use option -p for pid and -n for name\n");  
  }
  exit(0); 
}
