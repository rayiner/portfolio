/*
 * gc-lang.c
 * Minimal "language runtime" for GC tests to use.
 */

#include <stdio.h>
#include <stdlib.h>
#include "gc.h"
#include "gc-lang.h"

static int g_object_counter = 0;

os_word object_type(os_pointer p) {
  gc_header header = *((gc_header*)p);
  return header & 0xFFFFFFFF;
}

os_word object_slot(os_pointer p, os_word idx) {
  os_word* base = (os_word*)p;
  return base[1 + idx];
}

void set_object_slot(os_pointer p, os_word idx, os_word val) {
  os_word* base = (os_word*)p;
  base[1 + idx] = val;
}

os_word object_id(os_pointer p) {
  if(p)
    return object_slot(p, 0);
  else {
    printf("Error in OBJECT_ID: encountered nil\n");
    exit(-1);
  }
}

void brand_object(os_pointer p) {
  if(p)
    set_object_slot(p, 0, g_object_counter++);
  else {
    printf("Error in BRAND_OBJECT: encountered nil\n");
    exit(-1);
  }
}

os_pointer make_cons() {
  gc_header header = 
    ((os_word)0x2 << 32) 
    | ((os_word)0x3 << 34) 
    | ((os_word)0x6 << 39) 
    | OBJECT_TYPE_CONS;

  os_pointer p = gc_allocate_object(header);
  brand_object(p);

  return p;
}

os_pointer make_parray(os_word elts) {
  gc_header header =
    ((os_word)0x1 << 32)
    | (elts << 34)
    | OBJECT_TYPE_PARRAY;

  return gc_allocate_object(header);
}

os_pointer make_narray(os_word elts) {
 gc_header header = 
   ((os_word)0x0 << 32)
   | ((elts + 1) << 34)
   | OBJECT_TYPE_NARRAY;

 os_pointer p = gc_allocate_object(header);
 brand_object(p);

 return p;
}

os_pointer cons(os_pointer a, os_pointer b) {
  os_pointer c = make_cons();
  set_car(c, a);
  set_cdr(c, b);
  return c;
}

os_pointer car(os_pointer p) {
  if(p && object_type(p) == OBJECT_TYPE_CONS)
    return (os_pointer)object_slot(p, 1);
  return 0;
}

void set_car(os_pointer p, os_pointer val) {
  if(p && object_type(p) == OBJECT_TYPE_CONS)
    set_object_slot(p, 1, (os_word)val);
  else {
    printf("Type error in CAR, %p is not a CONS\n", p);
    exit(-1);
  }
}

os_pointer cdr(os_pointer p) {
  if(p && object_type(p) == OBJECT_TYPE_CONS)
    return (os_pointer)object_slot(p, 2);
  return 0;
}

void set_cdr(os_pointer p, os_pointer val) {
  if(p && object_type(p) == OBJECT_TYPE_CONS)
    set_object_slot(p, 2, (os_word)val);
  else {
    printf("Type error in CDR, %p is not a CONS\n", p);
    exit(-1);
  }
}

void print_cons(os_pointer p) {
  if(p && object_type(p) == OBJECT_TYPE_CONS) {
    printf("CONS %d (%p, %p)", object_id(p), car(p), cdr(p));
  }
  else
    printf("nil");
}
