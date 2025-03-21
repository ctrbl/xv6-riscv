#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define BUF_SIZE      512
#define DEFAULT_LINES  14

void head(int fd, const int count) {
  int n, i, line = 1;
  char buf[BUF_SIZE]; 

  if (line > count) 
    exit(0); 
  while ((n = read(fd, buf, BUF_SIZE)) > 0) {
    for (i = 0; i < n; i++) {
      if (line > count)
        break;  
      if (write(1, &buf[i], 1) != 1) {
        printf("head: write error\n");
        exit(1);
      }
      if (buf[i] == '\n')
        line++;
    }
    if (line > count)
      break;
  }
  if (n < 0) {
    printf("head: read error\n");
    exit(1);
  }
}

int main(int argc, char *argv[]) {
  int fd, i = 1, j, count = DEFAULT_LINES;  

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
    head(0, count);
  else {
    for (j = i; j < argc; j++) {
      if ((fd = open(argv[j], 0)) < 0) { 
        printf("head: cannot open '%s' for reading: No such file or directory\n", argv[j]);
        exit(1); 	
      } 
      if (argc - i >= 2) 
        printf("\n==> %s <==\n", argv[j]); 
      head(fd, count);        
      close(fd); 
    }
  } 
  exit(0); 
}