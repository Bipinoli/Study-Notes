#pragma once
// needed due to ftruncate
// man feature_test_macros
#define _DEFAULT_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <string.h>


void write_to_file() {
  const char *in_filename = "war_and_peace.txt";
  const char *out_filename = "build/war_and_peace2.txt";
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
  if (ftruncate(out_fd, file_size) == -1) {
    perror("CRASH! couldn't resize output file");
    exit(1);
  }
  char *in_bytes = mmap(NULL, file_size, PROT_READ, MAP_PRIVATE, in_fd, 0);
  char *out_bytes = mmap(NULL, file_size, PROT_WRITE, MAP_SHARED, out_fd, 0);
  if (in_bytes == MAP_FAILED || out_bytes == MAP_FAILED) {
    // __builtin_trap();
    perror("CRASH! mmap failed");
    exit(1);
  }
  if (close(in_fd) == -1 || close(out_fd) == -1) {
    perror("CRASH! file close failed");
    exit(1);
  }
  memcpy(out_bytes, in_bytes, file_size);
  if (munmap(in_bytes, file_size) == -1 || munmap(out_bytes, file_size) == -1) {
    perror("CRASH! munmap failed");
    exit(1);
  }
}
