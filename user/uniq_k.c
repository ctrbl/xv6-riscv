#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define BUF_SIZE  512

int main(int argc, char *argv[]) {
  int fd, c_flag = 0, d_flag = 0, i_flag = 0; 
  char buf[BUF_SIZE];     
  printf("Uniq command is getting executed in user mode.\n");

  // Read from standard input
  if (argc <= 1) {
    uniq_k(0, (uint64)buf, c_flag, d_flag, i_flag); 
    exit(0); 
  } 

  int i, j;
  // Process flags and text file in format (allow only 1 file with multi flags)
  // uniq [-c | -d | -i] filename.extension
  for (i = 1; i < argc; i++) {
    if (argv[i][0] == '-') {
      for (j = 1; argv[i][j] != '\0'; j++) {
        if (argv[i][j] == 'c') 
          c_flag = 1;
        else if (argv[i][j] == 'd')
          d_flag = 1;
        else if (argv[i][j] == 'i')
          i_flag = 1; 
        else {
          printf("uniq: invalid option -%c\n", argv[i][j]); 
          exit(1);
        }
      }
    } else {
      if ((fd = open(argv[i], 0)) < 0) {
        printf("uniq: cannot open %s\n", argv[i]); 
	      exit(1);
      }
      uniq_k(fd, (uint64)buf, c_flag, d_flag, i_flag); 
      close(fd);
      exit(0);  
    }
  }
  exit(0); 
}
