#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Vector {
  void *data;
  size_t capacity;
  size_t size;
  size_t unit_size;
  void (*init) (struct Vector *self, size_t uni_size);
  void (*push_back) (struct Vector *self, void *item);
  void* (*get) (struct Vector *self, size_t index);
  void (*free_vector) (struct Vector *self);
};

void push_back(struct Vector *self, void *item) {
  if (self->size == self->capacity) {
    self->capacity = self->capacity * 2;
    void *new_alloc = realloc(self->data, self->capacity * self->unit_size); 
    if (new_alloc == NULL) {
      perror("Couldn't allocate more memory to grow the dynamic array");
      exit(1);
    }
    self->data = new_alloc;
  }
  memcpy(self->data + self->size * self->unit_size, item, self->unit_size);
  self->size += 1;
}

void* get(struct Vector *self, size_t index) {
  return self->data + index * (self->unit_size);
}

void free_vector(struct Vector *self) {
  free(self->data);
  self->capacity = 0;
  self->size = 0;
}

void init (struct Vector *self, size_t unit_size) {
  self->capacity = 1;
  void *data_ptr = malloc(self->capacity * unit_size);
  if (data_ptr == NULL) {
    perror("malloc failed");
    exit(1);
  }
  self->data = data_ptr;
  self->size = 0;
  self->unit_size = unit_size;
  self->push_back = push_back; 
  self->get = get;
  self->free_vector = free_vector;
}


int main() {
  struct Vector v;
  init(&v, sizeof(int));

  for (int i=1; i<10; i++) {
    v.push_back(&v, (void *)(&i)); 
    printf("Inserted %d\n", i);
  }

  for (int i=0; i<v.size; i++) {
    int value = *(int*)v.get(&v, (size_t) i);
    printf("%d\n", value);
  }

  v.free_vector(&v);

  return 0;
}
