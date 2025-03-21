/* heap must not grow into < 5 pages below stack */
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
  uint64 sz = (uint64) sbrk(0); // end opf heap
  uint64 stackpage = (160 - 1) * 4096; // address where stack starts
  uint64 heap = stackpage - 4096*5; // address where guardpage starts

  assert((uint64) sbrk(heap - sz) != -1); // should allocate dynamic memory from the end of heap till the guardpage
  assert((uint64) sbrk(-1*(heap - sz)) != -1); // equivalent to sbrk(0) since sz should be equal to guardpage
  assert((uint64) sbrk(heap - sz + 1) == -1); // cannot allocate inside the guardpage
  printf("TEST PASSED\n");
  exit(0);
}