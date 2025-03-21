/* heap can grow to 5 pages below stack */
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

int
main(int argc, char *argv[])
{
  uint64 sz = (uint64) sbrk(0); // end of heap
  uint64 stackpage = (160 - 1) * 4096; // start of stack
  uint64 heap = stackpage - (4096*5); // start of heap

  // ensure they actually placed stack high...
  assert((uint64) &sz > stackpage);

  // full use of heap possible
  assert((uint64) sbrk(heap - sz) != -1);
  printf("TEST PASSED\n");
  exit(0);
}