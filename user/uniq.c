#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define BUF_SIZE  512

// Helper function to convert char to lowercase
int to_lower(int c) {
  if (c >= 'A' && c <= 'Z')
    return c + ('a' - 'A');
  return c;
}

// Helper function to compare chars with insensitive case
int my_strcasecmp(const char *str1, const char *str2) {
  while (*str1 && to_lower(*str1) == to_lower(*str2))
    str1++, str2++;
  return (unsigned char)to_lower(*str1) - (unsigned char)to_lower(*str2);
}

// Helper function to print line depending on flags for uniq command
void print_str(const char *str, const int repeated, const int printed, const int c_flag, const int d_flag) {
  if (!printed) {
    if (c_flag) { 
      // if d_flag and line is not repeated, don't print non-duplicate lines
      if (repeated || !d_flag)
        printf("%d ", repeated + 1);
    }
    if (repeated || !d_flag) 
      printf("%s", str);
  } 
}

void uniq(int fd, int c_flag, int d_flag, int i_flag) {
  char buf[BUF_SIZE]; 
  char line[BUF_SIZE];
  char prev_line[BUF_SIZE] = ""; 
  int repeated = 0, n, i, j, printed = 1;  
  
  while ((n = read(fd, buf, BUF_SIZE)) > 0) {
    for (i = 0, j = 0; i < n; i++) {
      line[j++] = buf[i]; 
      if (buf[i] == '\n') {
        line[j] = '\0';  
        int res = i_flag ? my_strcasecmp(line, prev_line) : strcmp(line, prev_line); 
        if (!res) {
          repeated++; 
        } else {
          print_str(prev_line, repeated, printed, c_flag, d_flag); 
          strcpy(prev_line, line);
          repeated = 0;
          printed = 0; 	  
        } 
        j = 0; 
      }
    }
    // for last line
    print_str(prev_line, repeated, printed, c_flag, d_flag); 
  } 
}

int main(int argc, char *argv[]) {
  int fd, c_flag = 0, d_flag = 0, i_flag = 0; 

  printf("Uniq command is getting executed in user mode.\n");

  // Read from standard input
  if (argc <= 1) {
    uniq(0, c_flag, d_flag, i_flag); 
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
      uniq(fd, c_flag, d_flag, i_flag); 
      close(fd);
      exit(0);  
    }
  }
  exit(0); 
}
