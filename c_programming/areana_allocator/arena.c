#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

struct arena {
  void *buffer;
  size_t capacity;
  size_t cursor;
  void* (*allocate)(struct arena *self, size_t size);
  void (*reset)(struct arena *self);
  void (*destory)(struct arena *self);
};


void* allocate(struct arena *self, size_t size) {
  // align memory allocation to 8 bytes (64 bit)
  size_t ceil_size = (size + 7) & ~7; // ignoring lowest 3 bits (i.e < 8)
  if (self->cursor + ceil_size > self->capacity) {
    perror("Allocation failed. Arena full");
    return NULL;
  }
  void *retval = self->buffer + self->cursor;
  self->cursor += ceil_size;
  return retval;
}


void reset(struct arena *self) {
  if(madvise(self->buffer, self->capacity, MADV_DONTNEED) == -1) {
    perror("madvise failed");
  }
  self->cursor = 0;
}


void destory(struct arena *self) {
  if(munmap(self->buffer, self->capacity) == -1) {
    perror("munmap failed");
    exit(1);
  }
  self->cursor = 0;
  self->buffer = NULL;
  self->capacity = 0;
}


struct arena create_arena(size_t size) {
  struct arena ar;
  ar.capacity = size;
  ar.cursor = 0;
  ar.allocate = allocate;
  ar.reset = reset;
  ar.destory = destory;
  ar.buffer = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0); 
  if (ar.buffer == MAP_FAILED) {
    perror("mmap failed");
    exit(1);
  }
  if(madvise(ar.buffer, size, MADV_SEQUENTIAL) == -1) {
    perror("madvise failed");
  }
  return ar;
}

 int main() {
 struct arena ar = create_arena(10 * 1000);
   char *ch[1000];
   for (int i=0; i<1000; i++) {
     ch[i] = ar.allocate(&ar, 1);
     *ch[i] = 'A' + i % 26; 
   }
   for (int i=0; i<1000; i+=100) {
     printf("%c\n", *ch[i]);
   }
   ar.destory(&ar);
   return 0;

 }

// int main() {
//   char *ch[1000];
//   for (int i=0; i<1000; i++) {
//     ch[i] = malloc(1);
//     *ch[i] = 'A' + i % 26; 
//   }
//   for (int i=0; i<1000; i+=100) {
//     printf("%c\n", *ch[i]);
//   }
//   for (int i=0; i<1000; i++) {
//     free(ch[i]);
//   }
//   return 0;
// }
