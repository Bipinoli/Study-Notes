#include <stdio.h>
#include "opaque.h"

int main() {
  struct Person *p = get_person();
  // __builtin_trap();
  display_person(p);
  // this is illegal as the info about the content is not available here i.e opaque type
  // printf("%lu\n", sizeof(struct Person));
  return 0;
}
