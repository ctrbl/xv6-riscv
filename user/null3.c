#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main()
{
    // Unmapped page 3
    int *p = (int*)(0x2000);
    printf("Null pointer at page 3 (starting address 0x%x)\n", p);
    printf("*p: %x\n", *p);
    exit(0);
}