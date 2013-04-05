/*
 * machine.h
 * Definition of the virtual machine.
 */

#include <string>
#include <vector>
#include <map>
#include <tr1/memory>

#ifndef MACHINE_H
#define MACHINE_H

#define VM_STACK_SIZE 10485760
#define VM_MAX_ARGS 16

#define BC_ELEMENT_PROCEDURE 0

#define VM_TAG_MASK 0xFFFF
#define VM_DATA_SHIFT 16
#define VM_DATA_MASK 0xFFFFFFFF0000UL
#define VM_TAG_FIXNUM 0
#define VM_TAG_CLOSURE 1
#define VM_TAG_SINGLE_FLOAT 2
#define VM_TAG_SMALL_STRING 3
#define VM_TAG_CANONICAL_TRUE 4
#define VM_TAG_EMPTY_LIST 5

#define VM_INS_NOP 0
#define VM_INS_CPTEMP 1
#define VM_INS_CPCONST 2
#define VM_INS_SKIP 3
#define VM_INS_SKIPUNLESS 4
#define VM_INS_CALL 5
#define VM_INS_TAILCALL 6
#define VM_INS_RETURN 7
#define VM_INS_MVCALL 8
#define VM_INS_APPLY 9
#define VM_INS_FUNCALL 10
#define VM_INS_BOX 11
#define VM_INS_BOXREF 12
#define VM_INS_BOXSET 13
#define VM_INS_CLOSURE 14
#define VM_INS_CLOSUREREF 15
#define VM_INS_EQ 16
#define VM_INS_EQUAL 17
#define VM_INS_NUMADD 18
#define VM_INS_NUMSUB 19
#define VM_INS_NUMMUL 20
#define VM_INS_NUMDIV 21
#define VM_INS_NUMCMPL 22
#define VM_INS_NUMCMPLE 23
#define VM_INS_NUMCMPG 24
#define VM_INS_NUMCMPGE 25
#define VM_INS_NUMCMPE 26
#define VM_INS_NUMCMPNE 27
#define VM_INS_NUMPOW 28
#define VM_INS_NUMMOD 29
#define VM_INS_PRINT 30
#define VM_INS_NOT 31

using namespace std;
using namespace std::tr1;

typedef char vm_byte;
typedef int vm_num;
typedef unsigned long vm_obj;

struct bc_element {
  string name;
  int type;
};

struct bc_procedure : bc_element {
  vector<vm_obj> const_vec;
  vector<string> ref_vec;
  vector<bc_element*> rel_ref_vec;
  vector<vm_byte> code_vec;
  vm_num reg_count;
};

typedef char* vm_ins_ptr;

struct vm_state {
  vm_obj* const_vec;
  bc_element** ref_vec;
  int reg_count;
  vm_ins_ptr ip;
  vm_obj* stack;
};

typedef map< string, shared_ptr<bc_element> > bc_map;

struct vm_world {
  bc_map bytecode;
  vm_obj* stack;
};

void vm_bail(const char* message);
vm_world* vm_make_world();
void vm_unmake_world(vm_world* w);
void vm_load_bytecode(vm_world* w, const char* file);
void vm_load_element(vm_world* w, bc_element* e);
void vm_relink_world(vm_world* w);
void vm_relink_procedure(vm_world* w, bc_procedure* e);
vm_obj vm_interpret_procedure(vm_world* w, 
			      const char* name, 
			      int argc, 
			      vm_obj* argv);
void vm_display_object(vm_obj obj);

bool is_nil(vm_obj obj);
vm_obj box_t();
vm_obj box_nil();
vm_obj box_closure(vm_obj* clos);
vm_obj* unbox_closure(vm_obj clos);

vm_obj prim_numadd(vm_obj a1, vm_obj a2);
vm_obj prim_numsub(vm_obj a1, vm_obj a2);
vm_obj prim_numcmpl(vm_obj a1, vm_obj a2);
vm_obj prim_numcmple(vm_obj a1, vm_obj a2);
vm_obj prim_numcmpg(vm_obj a1, vm_obj a2);
vm_obj prim_numcmpge(vm_obj a1, vm_obj a2);
vm_obj prim_numcmpe(vm_obj a1, vm_obj a2);
vm_obj prim_numcmpne(vm_obj a1, vm_obj a2);

#endif
