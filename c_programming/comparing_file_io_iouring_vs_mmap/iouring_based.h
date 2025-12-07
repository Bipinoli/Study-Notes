#pragma once
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <liburing>
#include <sys/stat.h>

void write_to_file() {
  const char *in_filename = "war_and_peace.txt";
  const char *out_filename = "build/war_and_peace3.txt";
  int in_fd = open(in_filename, O_RDONLY); 
  int out_fd = open(out_filename, O_RDWR | O_CREAT | O_TRUNC, S_IRWXU);
  if (in_fd == -1 || out_fd == -1) {
    perror("CRASH! couldn't open files to read/write");
    exit(1);
  }
  struct stat file_stat = {0};
  if (fstat(in_fd, &file_stat) == -1) {
    perror("CRASH! couldn't get file stat");
    exit(1);
  }
  const int file_size = file_stat.st_size;
  const int PAGE_SIZE = sysconf(_SC_PAGESIZE);
  
}
