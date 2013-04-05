/*
 * primitives.cpp
 * Implementation of primitive operations in the interpreter.
 */

#include "machine.h"

bool is_nil(vm_obj obj) {
  return obj == VM_TAG_EMPTY_LIST;
}

vm_obj box_t () {
  return VM_TAG_CANONICAL_TRUE;
}

vm_obj box_nil() {
  return VM_TAG_EMPTY_LIST;
}

vm_obj box_closure(vm_obj* obj) {
  return (((vm_obj)obj) << VM_DATA_SHIFT) | VM_TAG_CLOSURE;
}

vm_obj* unbox_closure(vm_obj obj) {
  return (vm_obj*)(obj >> VM_DATA_SHIFT);
}

int unbox_fixnum(vm_obj a1) {
  return (a1 & VM_DATA_MASK) >> VM_DATA_SHIFT;
}

vm_obj box_fixnum(int a1) {
  return (vm_obj)a1 << VM_DATA_SHIFT;
}

float unbox_single_float(vm_obj a1) {
  return (a1 & VM_DATA_MASK) >> VM_DATA_SHIFT;
}

vm_obj box_single_float(float a1) {
  unsigned int* p1 = (unsigned int*)&a1;
  return (vm_obj)(*p1) << VM_DATA_SHIFT;
}


vm_obj prim_numadd(vm_obj a1, vm_obj a2) {
  int t1 = a1 & VM_TAG_MASK;
  int t2 = a2 & VM_TAG_MASK;

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_FIXNUM)) {
    int n1 = unbox_fixnum(a1);
    int n2 = unbox_fixnum(a2);
    return box_fixnum(n1 + n2);
  }

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    int n1 = unbox_fixnum(a1);
    float n2 = unbox_single_float(a2);
    return box_single_float(n1 + n2);
  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_FIXNUM)) {
    float n1 = unbox_single_float(a1);
    int n2 = unbox_fixnum(a2);
    return box_single_float(n1 + n2);
  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    float n1 = unbox_single_float(a1);
    float n2 = unbox_single_float(a2);
    return box_single_float(n1 + n2);
  }

  vm_bail("type error in +");
  return -1;
}

vm_obj prim_numsub(vm_obj a1, vm_obj a2) {
  int t1 = a1 & VM_TAG_MASK;
  int t2 = a2 & VM_TAG_MASK;

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_FIXNUM)) {
    int n1 = unbox_fixnum(a1);
    int n2 = unbox_fixnum(a2);
    return box_fixnum(n1 - n2);
  }

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    int n1 = unbox_fixnum(a1);
    float n2 = unbox_single_float(a2);
    return box_single_float(n1 - n2);
  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_FIXNUM)) {
    float n1 = unbox_single_float(a1);
    int n2 = unbox_fixnum(a2);
    return box_single_float(n1 - n2);
  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    float n1 = unbox_single_float(a1);
    float n2 = unbox_single_float(a2);
    return box_single_float(n1 - n2);
  }

  vm_bail("type error in -");
  return -1;
}

vm_obj prim_numcmpl(vm_obj a1, vm_obj a2) {
  int t1 = a1 & VM_TAG_MASK;
  int t2 = a2 & VM_TAG_MASK;

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_FIXNUM)) {
    int n1 = unbox_fixnum(a1);
    int n2 = unbox_fixnum(a2);
    return (n1 < n2) ? box_t() : box_nil();
  }

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    int n1 = unbox_fixnum(a1);
    float n2 = unbox_single_float(a2);
    return (n1 < n2) ? box_t() : box_nil();

  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_FIXNUM)) {
    float n1 = unbox_single_float(a1);
    int n2 = unbox_fixnum(a2);
    return (n1 < n2) ? box_t() : box_nil();

  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    float n1 = unbox_single_float(a1);
    float n2 = unbox_single_float(a2);
    return (n1 < n2) ? box_t() : box_nil();
  }

  vm_bail("type error in <");
  return -1;
}

vm_obj prim_numcmple(vm_obj a1, vm_obj a2) {
  int t1 = a1 & VM_TAG_MASK;
  int t2 = a2 & VM_TAG_MASK;

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_FIXNUM)) {
    int n1 = unbox_fixnum(a1);
    int n2 = unbox_fixnum(a2);
    return (n1 <= n2) ? box_t() : box_nil();
  }

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    int n1 = unbox_fixnum(a1);
    float n2 = unbox_single_float(a2);
    return (n1 <= n2) ? box_t() : box_nil();

  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_FIXNUM)) {
    float n1 = unbox_single_float(a1);
    int n2 = unbox_fixnum(a2);
    return (n1 <= n2) ? box_t() : box_nil();

  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    float n1 = unbox_single_float(a1);
    float n2 = unbox_single_float(a2);
    return (n1 <= n2) ? box_t() : box_nil();
  }

  vm_bail("type error in <=");
  return -1;
}

vm_obj prim_numcmpg(vm_obj a1, vm_obj a2) {
  int t1 = a1 & VM_TAG_MASK;
  int t2 = a2 & VM_TAG_MASK;

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_FIXNUM)) {
    int n1 = unbox_fixnum(a1);
    int n2 = unbox_fixnum(a2);
    return (n1 > n2) ? box_t() : box_nil();
  }

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    int n1 = unbox_fixnum(a1);
    float n2 = unbox_single_float(a2);
    return (n1 > n2) ? box_t() : box_nil();

  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_FIXNUM)) {
    float n1 = unbox_single_float(a1);
    int n2 = unbox_fixnum(a2);
    return (n1 > n2) ? box_t() : box_nil();

  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    float n1 = unbox_single_float(a1);
    float n2 = unbox_single_float(a2);
    return (n1 > n2) ? box_t() : box_nil();
  }

  vm_bail("type error in >");
  return -1;
}

vm_obj prim_numcmpge(vm_obj a1, vm_obj a2) {
  int t1 = a1 & VM_TAG_MASK;
  int t2 = a2 & VM_TAG_MASK;

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_FIXNUM)) {
    int n1 = unbox_fixnum(a1);
    int n2 = unbox_fixnum(a2);
    return (n1 >= n2) ? box_t() : box_nil();
  }

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    int n1 = unbox_fixnum(a1);
    float n2 = unbox_single_float(a2);
    return (n1 >= n2) ? box_t() : box_nil();

  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_FIXNUM)) {
    float n1 = unbox_single_float(a1);
    int n2 = unbox_fixnum(a2);
    return (n1 >= n2) ? box_t() : box_nil();

  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    float n1 = unbox_single_float(a1);
    float n2 = unbox_single_float(a2);
    return (n1 >= n2) ? box_t() : box_nil();
  }

  vm_bail("type error in >=");
  return -1;
}

vm_obj prim_numcmpe(vm_obj a1, vm_obj a2) {
  int t1 = a1 & VM_TAG_MASK;
  int t2 = a2 & VM_TAG_MASK;

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_FIXNUM)) {
    int n1 = unbox_fixnum(a1);
    int n2 = unbox_fixnum(a2);
    return (n1 == n2) ? box_t() : box_nil();
  }

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    int n1 = unbox_fixnum(a1);
    float n2 = unbox_single_float(a2);
    return (n1 == n2) ? box_t() : box_nil();

  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_FIXNUM)) {
    float n1 = unbox_single_float(a1);
    int n2 = unbox_fixnum(a2);
    return (n1 == n2) ? box_t() : box_nil();

  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    float n1 = unbox_single_float(a1);
    float n2 = unbox_single_float(a2);
    return (n1 == n2) ? box_t() : box_nil();
  }

  vm_bail("type error in ==");
  return -1;
}

vm_obj prim_numcmpne(vm_obj a1, vm_obj a2) {
  int t1 = a1 & VM_TAG_MASK;
  int t2 = a2 & VM_TAG_MASK;

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_FIXNUM)) {
    int n1 = unbox_fixnum(a1);
    int n2 = unbox_fixnum(a2);
    return (n1 != n2) ? box_t() : box_nil();
  }

  if((t1 == VM_TAG_FIXNUM) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    int n1 = unbox_fixnum(a1);
    float n2 = unbox_single_float(a2);
    return (n1 != n2) ? box_t() : box_nil();

  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_FIXNUM)) {
    float n1 = unbox_single_float(a1);
    int n2 = unbox_fixnum(a2);
    return (n1 != n2) ? box_t() : box_nil();

  }

  if((t1 == VM_TAG_SINGLE_FLOAT) && (t2 == VM_TAG_SINGLE_FLOAT)) {
    float n1 = unbox_single_float(a1);
    float n2 = unbox_single_float(a2);
    return (n1 != n2) ? box_t() : box_nil();
  }

  vm_bail("type error in !=");
  return -1;
}
