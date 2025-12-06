#pragma once
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>


void stream_file(int in_fd, int out_fd) {
  const int PAGE_SIZE = sysconf(_SC_PAGE_SIZE);
  char buffer[PAGE_SIZE];
  while (true) {
    int read_bytes = read(in_fd, buffer, PAGE_SIZE);  
    if (read_bytes == -1) {
      perror("CRASH! read failed");
      exit(1);
    }
    if (read_bytes == 0) {
      break;
    }
    int total_wrote = 0;
    while (total_wrote < read_bytes) {
      int written = write(out_fd, buffer, read_bytes);
      if (written == -1) {
        perror("CRASH! write failed");
        exit(1);
      }
      total_wrote += written;
    }
  }
}


void write_to_file() {
  const char *in_filename = "war_and_peace.txt";
  const char *out_filename = "build/war_and_peace1.txt";
  int in_fd = open(in_filename, O_RDONLY); 
  int out_fd = open(out_filename, O_WRONLY | O_CREAT | O_TRUNC, S_IRWXU);
  if (in_fd == -1 || out_fd == -1) {
    perror("couldn't open files to read/write");
    return;
  }
  stream_file(in_fd, out_fd);
  if (close(in_fd) == -1 || close(out_fd) == -1) {
    perror("CRASH! file close failed");
    exit(1);
  }
}
