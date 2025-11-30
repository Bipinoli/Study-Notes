#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

struct Node {
  void *data;  
  struct Node *next;
};

struct List {
  // As all fields are pointers or word size 
  // the field order as it is already gives the minimal alignment padding
  struct Node *head;
  size_t unit_size;
  void (*push_back)(struct List *self, void *item);
  void (*push_front)(struct List *self, void *item);
  void* (*front)(struct List *self);
  void* (*back)(struct List *self);
  void (*pop_back)(struct List *self);
  void (*pop_front)(struct List *self);
  void (*reverse)(struct List *self);
  bool (*empty)(struct List *self);
  void (*destroy)(struct List *self);
};




bool empty(struct List *self) {
  return self->head == NULL;
}


void push_front(struct List *self, void *item) {
  struct Node *new_node = malloc(sizeof(struct Node));
  void *data = malloc(self->unit_size);
  memcpy(data, item, self->unit_size);
  new_node->data = data;
  new_node->next = self->head;
  self->head = new_node;
}


void push_back(struct List *self, void *item) {
  void *data = malloc(self->unit_size);
  memcpy(data, item, self->unit_size);
  if (self->head == NULL) {
    self->head = malloc(sizeof(struct Node)); 
    if (self->head == NULL) {
      perror("malloc failed");
      exit(1);
    }
    self->head->data = data;
    self->head->next = NULL;
    return;
  }
  struct Node *new_node = malloc(sizeof(struct Node));
  if (new_node == NULL) {
    perror("malloc failed");
    exit(1);
  }
  struct Node *last_node = self->head;
  while (last_node->next != NULL) {
    last_node = last_node->next;
  }
  last_node->next = new_node;
  new_node->data = data;
  new_node->next = NULL;
}



void pop_back(struct List *self) {
  if (self->head == NULL) {
    return;
  }
  if (self->head->next == NULL) {
    free(self->head->data);
    self->head->next = NULL;
    self->head = NULL;
    return;
  }
  struct Node *new_last_node;  
  struct Node *cur = self->head;
  while (cur->next != NULL) {
    new_last_node = cur;
    cur = cur->next;
  }
  free(cur->data);
  cur->next = NULL;
  new_last_node->next = NULL;
}



void pop_front(struct List *self) {
  if (self->head == NULL) {
    return;
  }
  struct Node *next = self->head->next;
  free(self->head->data);
  self->head->next = NULL;
  self->head = next;
}



void* front(struct List *self) {
  if (self->head == NULL) {
    return NULL;
  }
  return self->head->data;
}



void* back(struct List *self) {
  if (self->head == NULL) {
    return NULL;
  }
  struct Node *last_node = self->head;
  while (last_node->next != NULL) {
    last_node = last_node->next;
  }
  return last_node->data;
}
 


void reverse(struct List *self) {
  if (self->head == NULL) {
    return;
  }
  struct Node *cur = self->head;
  struct Node *new_next = NULL;
  while (true) {
    struct Node *prev_next = cur->next;
    cur->next = new_next;
    new_next = cur;
    if (prev_next == NULL) {
      break;
    }
    cur = prev_next;
  }
  self->head = cur;
}


void destroy(struct List *self) {
  struct Node *cur = self->head;
  while (cur != NULL) {
    struct Node *next = cur->next; 
    free(cur->data);  
    cur->next = NULL;
    cur = next;
  }
}


void init(struct List *self, size_t unit_size) {
  self->head = NULL;
  self->unit_size = unit_size;
  self->push_back = push_back;
  self->push_front = push_front;
  self->pop_back = pop_back;
  self->pop_front = pop_front;
  self->front = front;
  self->back = back;
  self->reverse = reverse;
  self->destroy = destroy;
  self->empty = empty;
  self->empty = empty;
}


void display(struct List *list) {
  struct Node *cur = list->head;
  while (cur != NULL) {
    // assuming int type
    printf("%d -> ", *(int *)(cur->data));
    cur = cur->next;
  }
  printf("NULL\n");
}


int main() {
  struct List list;
  init(&list, sizeof(int));

  for (int i=1; i<5; i++) {
    list.push_back(&list, (void *)(&i));
    printf("%d inserted\n", i);
    display(&list);
  }

  printf("reversing\n");
  list.reverse(&list);
  display(&list);

  for (int i=10; i<15; i++) {
    printf("Pusing %d front\n", i);
    list.push_front(&list, (void *)(&i));
    display(&list);
  }

  printf("pop back\n");
  list.pop_back(&list);
  display(&list);

  printf("pop front\n");
  list.pop_front(&list);
  display(&list);

  printf("Back data: %d\n", *(int *)list.back(&list));
  printf("Front data: %d\n", *(int *)list.front(&list));

  bool toBackPop = true;
  while (true) {
    if (toBackPop) {
      printf("Back pop\n");
      list.pop_back(&list);
    } else {
      list.pop_front(&list);
      printf("Front pop\n");
    }
    display(&list);
    if (list.empty(&list)) {
      break;
    }
    printf("Back data: %d\n", *(int *)list.back(&list));
    printf("Front data: %d\n", *(int *)list.front(&list));
    printf("Reversing\n");
    list.reverse(&list);
    display(&list);
    toBackPop = !toBackPop;
  }

  list.destroy(&list);

  return 0;
}
