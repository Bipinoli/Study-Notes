#include <cstdlib>

#include <verilated.h>

#include "Vtestbench.h"

int main(int argc, char **argv) {
  Verilated::commandArgs(argc, argv);

  Vtestbench *top = new Vtestbench;

  while(!Verilated::gotFinish()) {
    top->eval();
  }

  top->final();

  delete top;

  return EXIT_SUCCESS;
}

