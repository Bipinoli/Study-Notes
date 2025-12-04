#include <stdio.h>
#include <stddef.h>

#define container_of(ptr, type, member) ((type *)((char *)ptr - offsetof(type, member)))

struct person {
  char name[21];
  int age;
};

int main() {
  printf("%lu\n", sizeof(struct person));
  printf("offsetof name: %lu\n", offsetof(struct person, name));
  printf("offsetof age: %lu\n", offsetof(struct person, age));
  struct person p;
  int *age_ptr = &p.age;
  printf("Address of person: %lu\n", &p);
  printf("Address of person from container_of: %lu\n", container_of(age_ptr, struct person, age));

  bool chooseA = false;
  struct person pr = ({
    struct person tmp;
    if (chooseA) {
      tmp = (struct person){
        .name = "PersonA",
        .age = 28
      };
    } else {
      tmp = (struct person){
        .name = "PersonB",
        .age = 32
      };
    }
    tmp;
  });

  printf("The name is %s\n", pr.name);

  return 0;
}
