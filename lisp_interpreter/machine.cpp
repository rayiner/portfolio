/*
 * machine.cpp
 * Core of the virtual machine.
 */

#include <stdio.h>
#include <stdlib.h>
#include "machine.h"

int main(int argc, char** argv) {
  if(argc != 3) {
    printf("Usage: vitamin <bytecode-file> <procedure>\n");
    return -1;
  }

  vm_world* w = vm_make_world();

  vm_load_bytecode(w, argv[1]);
  vm_relink_world(w);
  vm_obj result = vm_interpret_procedure(w, argv[2], 0, 0);
  printf("result: ");
  vm_display_object(result);
  printf("\n");

  vm_unmake_world(w);

  return 0;
}

void vm_bail(const char* message) {
  printf("Virtual machine quit with error: %s\n", message);
  exit(-1);
}

vm_world* vm_make_world() {
  vm_world* w = new vm_world;
  w->stack = (vm_obj*)malloc(VM_STACK_SIZE);
  return w;
}

void vm_unmake_world(vm_world* w) {
  free(w->stack);
  delete w;
}
