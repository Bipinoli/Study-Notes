#include <stdio.h>
#include <stdlib.h>
#include "opaque.h"

struct Person {
  char *name;
  int age;
};

struct Person* get_person() {
  struct Person *p = malloc(sizeof(struct Person));
  if (p == NULL) {
    perror("malloc failed. Crashing!");
    exit(1);
  }
  p->name = "Mr. Pipsy squeezy";
  p->age = 8;
  return p;
}

void display_person(struct Person *p) {
  printf("Oh! hello %s. I heard you are already %d years old!\n", p->name, p->age);
}
