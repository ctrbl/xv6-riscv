/* stack should grow automatically on a page fault */
#include "kernel/types.h"
#include "user/user.h"

#undef NULL
#define NULL ((void*)0)

#define assert(x) if (x) {} else { \
  printf("%s: %d ", __FILE__, __LINE__); \
  printf("assert failed (%s)\n", # x); \
  printf("TEST FAILED\n"); \
  exit(0); \
}

void
recurse(int n) 
{
  if(n > 0)
    recurse(n-1);
}

int
main(int argc, char *argv[])
{
  int pid = fork();
  if(pid == 0) {
    // the following command will hit the gap, you need to handle the fault and move the gap further down
    recurse(500); // if the fault is not handled, we will not reach the print
    printf("TEST PASSED\n");
    exit(0);
  } else {
    wait(0);
  }
  exit(0);
}