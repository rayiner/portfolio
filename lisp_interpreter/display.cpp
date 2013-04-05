/*
 * display.cpp
 * Routines for displaying objects and internal structures.
 */

#include "machine.h"

void vm_display_object(vm_obj obj) {
  unsigned int tag = obj & VM_TAG_MASK;
  switch(tag) {
  case VM_TAG_FIXNUM: 
    printf("%d", (int)((obj >> VM_DATA_SHIFT) & 0xFFFFFFFF));
    break;
  case VM_TAG_CLOSURE:
    printf("closure %p", (void*)((obj >> VM_DATA_SHIFT)));
    break;
  case VM_TAG_SINGLE_FLOAT:
    printf("%f", (float)((obj >> VM_DATA_SHIFT) & 0xFFFFFFFF));
    break;
  case VM_TAG_SMALL_STRING:
    int len = (obj >> VM_DATA_SHIFT) & 0xFF;
    for(int i = 0; i < len; ++i) {
      int c = (obj >> ((i + 3) * 8)) & 0xFF;
      printf("%c", c);
    }
    break;
  case VM_TAG_CANONICAL_TRUE:
    printf("t");
    break;
  case VM_TAG_EMPTY_LIST:
    printf("nil");
    break;
  default: 
    vm_bail("type error in display"); break;
  }
}

    
