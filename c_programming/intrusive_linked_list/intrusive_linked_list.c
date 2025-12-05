#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stddef.h>

#define container_of(ptr, type, member) (type *)((char *)ptr - offsetof(type, member))

struct list_node {
  struct list_node *next; 
  struct list_node *prev;
};

void init_list_node(struct list_node *self) {
  self->next = self;
  self->prev = self;
}

void push_back_list_node(struct list_node *head, struct list_node *new_node) {
  struct list_node *cur = head;
  while (cur->next != head) {
    cur = cur->next;
  }
  new_node->next = cur->next; 
  cur->next->prev = new_node;
  cur->next = new_node;
  new_node->prev = cur;
}

void pop_back_list_node(struct list_node *head) {
  struct list_node *cur = head; 
  while (cur->next != head) {
    cur = cur->next;
  }
  cur->prev->next = cur->next;
  cur->next->prev = cur->prev;
  cur->prev = cur;
  cur->next = cur;
}

bool empty_list_node(struct list_node *head) {
  return head->next == head; 
}



struct list {
  int value;
  struct list_node head;
  void (*push_back)(struct list *self, int a);
  void (*pop_back)(struct list *self);
  int (*back)(struct list *self);
  bool (*empty)(struct list *self);
  void (*destroy)(struct list *self);
};


void destroy(struct list *self) {
  struct list_node *cur = self->head.next;
  struct list_node *next;
  while (cur != &(self->head)) {
    next = cur->next;
    struct list *cur_cont = container_of(cur, struct list, head);
    free(cur_cont);
    cur = next;
  }
}


void push_back(struct list *self, int a) {
  struct list *new_item = malloc(sizeof(struct list));
  if (new_item == NULL) {
    perror("malloc failed");
    exit(1);
  }
  new_item->value = a;
  init_list_node(&(new_item->head));
  push_back_list_node(&(self->head), &(new_item->head));
}

void pop_back(struct list *self) {
  if (self->empty(self)) {
    return;
  }
  struct list_node *last = self->head.prev;
  pop_back_list_node(&(self->head));
  struct list *last_item = container_of(last, struct list, head);
  free(last_item);
}

int back(struct list *self) {
  if (empty_list_node(&(self->head))) {
    perror("back is invalid on empty list");
    exit(1);
  }
  struct list *back_item = container_of(self->head.prev, struct list, head);
  return back_item->value;
}


bool empty(struct list *self) {
  return empty_list_node(&(self->head));
}



void init_list(struct list *self) {
  init_list_node(&(self->head));
  self->push_back = push_back;
  self->pop_back = pop_back;
  self->back = back;
  self->empty = empty;
  self->destroy = destroy;
}


void display_list(struct list *self) {
  struct list_node *cur = self->head.next;
  while (cur != &(self->head)) {
    printf("%d -> ", (container_of(cur, struct list, head))->value);
    cur = cur->next;
  }
  printf("\n");
}




int main() {
  struct list lst;
  init_list(&lst);
  for (int i=1; i<10; i++) {
    lst.push_back(&lst, i);
    display_list(&lst);
    printf("Back: %d\n", lst.back(&lst));
  }
  while (!lst.empty(&lst)) {
    lst.pop_back(&lst);
    display_list(&lst);
    printf("Back: %d\n", lst.back(&lst));
  }
  destroy(&lst);
  return 0;
}
