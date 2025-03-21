/* stack should grow towards lower addresses as usual */
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
foo(void *mainlocal) 
{
  int local;
  // local should be allocated at a lower address since the stack grows down
  assert((uint64) &local < (uint64) mainlocal);
}

int
main(int argc, char *argv[])
{
  int local;
  assert((uint64)&local > 639*1024);
  foo((void*) &local);
  printf("TEST PASSED\n");
  exit(0);
}