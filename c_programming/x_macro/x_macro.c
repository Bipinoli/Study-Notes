#include <stdio.h>

#define COLORS \
  X(RED) \
  X(YELLOW) \
  X(PURPLE) \
  X(ORANGE) \
  X(BLUE) \
  X(TEAL) \
  X(OTHERS) 

#define X(col) col,
enum Colors {
  COLORS
};
#undef X

int main() {
  enum Colors color = RED;
  #define X(col) \
    case col: \
      printf(#col "\n"); \
      break;

  switch (color) {
    COLORS
  }
  #undef X
  return 0;
}

