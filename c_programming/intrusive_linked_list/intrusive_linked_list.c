#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stddef.h>

#define container_of(ptr, type, member) (type *)((char *)ptr - offsetof(type, member))

struct list_node {
  struct list_node *next; 
  struct list_node *prev;
};

struct list_node create_list_node() {
  struct list_node cur;
  cur.next = &cur;
  cur.prev = &cur;
  return cur;
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
};

void push_back(struct list *self, int a) {
  struct list *new_item = malloc(sizeof(struct list));
  if (new_item == NULL) {
    perror("malloc failed");
    exit(1);
  }
  new_item->value = a;
  new_item->head = create_list_node();
  push_back_list_node(&(self->head), &(new_item->head));
}

int back(struct list *self) {
  if (empty_list_node(&(self->head))) {
    perror("back is invalid on empty list");
    exit(1);
  }
  struct list *back_item = container_of(self->head.prev, struct list, head);
  return back_item->value;
}


struct list create_list() {
  struct list retval;
  retval.head = create_list_node();
  retval.push_back = push_back;
  retval.back = back;
  return retval;
}

int main() {
  struct list lst = create_list();
  lst.push_back(&lst, 1);
  printf("last: %d\n", lst.back(&lst));
  return 0;
}
