#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define BUF_SIZE      512
#define DEFAULT_LINES  14

int main(int argc, char *argv[]) {
  int fd, i = 1, j, count = DEFAULT_LINES;  
  char buf[BUF_SIZE]; 

  printf("Head command is getting executed in user mode.\n"); 

  // check for default head vs numbered head
  if (!strcmp(argv[1], "-n")) {
    for (j = 0; argv[2][j] != '\0'; j++) {
      if (!isDigit(&argv[2][j])) {
        printf("head: invalid number of lines: '%s'\n", argv[2]); 
	exit(1); 
      }
    }
    count = atoi(argv[2]); 
    i = 3;    
  }
  else if (argv[1][0] == '-') {
    char *num = malloc(strlen(argv[1])); 
    for (j = 1; argv[1][j] != '\0'; j++) {
      if (!isDigit(&argv[1][j])) {
        printf("head: invalid option %s\n", argv[1]);
	exit(1);
      } 
      num[j-1] = argv[1][j];       
    } 
    if (strlen(num)) 
      count = atoi(num); 
    i = 2;   
  } 
 
  if (i >= argc) 
    head_k(0, (uint64)buf, count);
  else {
    for (j = i; j < argc; j++) {
      if ((fd = open(argv[j], 0)) < 0) { 
        printf("head: cannot open '%s' for reading: No such file or directory\n", argv[j]);
        exit(1); 	
      } 
      if (argc - i >= 2) 
        printf("\n==> %s <==\n", argv[j]); 
      head_k(fd, (uint64)buf, count);        
      close(fd); 
    }
  } 
  exit(0); 
}
