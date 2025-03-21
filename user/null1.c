#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main()
{
    // Unmapped page 1
    int *p = (int*)(0);
    printf("Null pointer at page 1 (starting address 0x%x)\n", p);
    printf("*p: %x\n", *p);
    exit(0);
}