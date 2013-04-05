/*
 * gc-lang.h
 * Minimal "language runtime" for GC tests to use.
 */

#ifndef GC_LANG_H
#define GC_LANG_H

#define OBJECT_TYPE_CONS 1
#define OBJECT_TYPE_PARRAY 3
#define OBJECT_TYPE_NARRAY 2

#define CONS_SIZE 32

os_word object_type(os_pointer p);
os_word object_slot(os_pointer p, os_word idx);
void set_object_slot(os_pointer p, os_word idx, os_word val);
os_word object_id(os_pointer p);

os_pointer make_cons();
os_pointer make_parray(os_word elts);
os_pointer make_narray(os_word elts);
os_pointer cons(os_pointer a, os_pointer b);
os_pointer car(os_pointer p);
void set_car(os_pointer p, os_pointer val);
os_pointer cdr(os_pointer p);
void set_cdr(os_pointer p, os_pointer val);
void print_cons(os_pointer p);

#endif
