/*
 * interpreter.cpp
 * The bytecode interpreter.
 */

#include "machine.h"

#define FETCH3(a, b, c)  \
  vm_num a = fetch_num(&state); \
  vm_num b = fetch_num(&state); \
  vm_num c = fetch_num(&state);
  
vm_num fetch_num_rest(vm_state* state, vm_num num) {
  int shift = 7;
  do {
    vm_byte byte = *state->ip++;
    num += (byte & 0x7F) << shift;
    shift += 7;

    if(byte >= 0) {
      return num;
    }
  } while(1);
}

vm_num fetch_num(vm_state* state) {
  vm_num num = *state->ip++;

  if(num >= 0) return num;
  return fetch_num_rest(state, num);
}

vm_obj get_reg(vm_state* state, vm_num rn) {
  return state->stack[rn];
}

void set_reg(vm_state* state, vm_num rn, vm_obj val) {
  state->stack[rn] = val;
}

void skip_ip(vm_state* state, vm_num bytes) {
  state->ip += bytes;
}

vm_obj get_const(vm_state* state, vm_num cn) {
  return state->const_vec[cn];
}

bc_element* get_ref(vm_state* state, vm_num rn) {
  return state->ref_vec[rn];
}

vm_state get_procedure_state(bc_element* e, vm_obj* new_stack) {
  bc_procedure* p = (bc_procedure*)e;
  vm_state s;
  s.const_vec = &p->const_vec[0];
  s.ref_vec = &p->rel_ref_vec[0];
  s.reg_count = p->reg_count;
  s.ip = &p->code_vec[0];
  s.stack = new_stack;
  return s;
}

vm_num execute_state(vm_world* w, vm_state state) {
  do {
    vm_num op = fetch_num(&state);

    switch(op) {
    case VM_INS_NOP: break;
    case VM_INS_CPTEMP: {
      vm_num dest = fetch_num(&state);
      vm_num source = fetch_num(&state);
      set_reg(&state, dest, get_reg(&state, source));
    }
      break;
    case VM_INS_CPCONST: {
      vm_num dest = fetch_num(&state);
      vm_num cst = fetch_num(&state);
      set_reg(&state, dest, get_const(&state, cst));
    }
      break;
    case  VM_INS_SKIP: {
      vm_num dist = fetch_num(&state);
      skip_ip(&state, dist);
    }
      break;
    case VM_INS_SKIPUNLESS: {
      vm_num pred = fetch_num(&state);
      vm_num dist = fetch_num(&state);
      if(is_nil(get_reg(&state, pred))) {
	skip_ip(&state, dist);
      }
    }
      break;
    case VM_INS_CALL: {
      vm_num dest = fetch_num(&state);
      vm_num fun = fetch_num(&state);
      vm_num argc = fetch_num(&state);

      vm_obj* new_stack = state.stack + state.reg_count;

      assert(new_stack < (w->stack + VM_STACK_SIZE));

      for(int i = 0; i < argc; ++i) {
	vm_num arg = fetch_num(&state);
	new_stack[i] = get_reg(&state, arg);
      }

      bc_element* e = get_ref(&state, fun);
      if(!e) vm_bail("attempt to call undefined function");

      vm_state tgt_state = get_procedure_state(e, new_stack);
      int ret_count = execute_state(w, tgt_state);
      for(int i = 0; i < ret_count; ++i) {
	set_reg(&state, dest, get_reg(&tgt_state, 0));
      }
    }
      break;
    case VM_INS_TAILCALL: {
      vm_num fun = fetch_num(&state);
      vm_num argc = fetch_num(&state);

      vm_obj argbuf[VM_MAX_ARGS];
      for(int i = 0; i < argc; ++i) {
	vm_num arg = fetch_num(&state);
	argbuf[i] = get_reg(&state, arg);
      }
      for(int i = 0; i < argc; ++i) {
	state.stack[i] = argbuf[i];
      }

      bc_element* e = get_ref(&state, fun);
      if(!e) vm_bail("attempt to call undefined function");

      state = get_procedure_state(e, state.stack);
    }
      break;
    case VM_INS_RETURN: {  
      vm_obj retbuf[VM_MAX_ARGS];
      vm_num ret_count = fetch_num(&state);
      for(int i = 0; i < ret_count; ++i) {
	vm_num ret_arg = fetch_num(&state);
	retbuf[i] = get_reg(&state, ret_arg);
      }
      for(int i = 0; i < ret_count; ++i) {
	set_reg(&state, i, retbuf[i]);
      }
      return ret_count;
    }
      break;
    case VM_INS_CLOSURE: {
      vm_num dest = fetch_num(&state);
      vm_num fun = fetch_num(&state);
      vm_num count = fetch_num(&state);
      vm_obj* clos = (vm_obj*)malloc(sizeof(vm_obj) * (count + 1));
      clos[0] = (vm_obj)get_ref(&state, fun);
      for(int i = 0; i < count; ++i) {
	vm_num arg = fetch_num(&state);
	clos[i+1] = get_reg(&state, arg);
      }
      set_reg(&state, dest, box_closure(clos));
    }
      break;
    case VM_INS_CLOSUREREF: {
      vm_num dest = fetch_num(&state);
      vm_num creg = fetch_num(&state);
      vm_num idx = fetch_num(&state);
      vm_obj* clos = unbox_closure(get_reg(&state, creg));
      set_reg(&state, dest, clos[idx+1]);
    }
      break;
    case VM_INS_EQ: {
      FETCH3(dest, lhs, rhs);
      if(get_reg(&state, lhs) == get_reg(&state, rhs))
	set_reg(&state, dest, box_t());
      else
	set_reg(&state, dest, box_nil());
    } 
      break;
    case VM_INS_NUMADD: {
      FETCH3(dest, src1, src2);
      set_reg(&state, 
	      dest, 
	      prim_numadd(get_reg(&state, src1), get_reg(&state, src2)));
    }
      break;
    case VM_INS_NUMSUB: {
      FETCH3(dest, src1, src2);
      set_reg(&state,
	      dest,
	      prim_numsub(get_reg(&state, src1), get_reg(&state, src2)));
    }
      break;
    case VM_INS_NUMCMPL: {
      FETCH3(dest, lhs, rhs);
      set_reg(&state,
	      dest,
	      prim_numcmpl(get_reg(&state, lhs), get_reg(&state, rhs)));
    }
      break;
    case VM_INS_NUMCMPLE: {
      FETCH3(dest, lhs, rhs);
      set_reg(&state,
	      dest,
	      prim_numcmple(get_reg(&state, lhs), get_reg(&state, rhs)));
    }
      break;
    case VM_INS_NUMCMPG: {
      FETCH3(dest, lhs, rhs);
      set_reg(&state,
	      dest,
	      prim_numcmpg(get_reg(&state, lhs), get_reg(&state, rhs)));
    }
      break;
    case VM_INS_NUMCMPGE: {
      FETCH3(dest, lhs, rhs);
      set_reg(&state,
	      dest,
	      prim_numcmpge(get_reg(&state, lhs), get_reg(&state, rhs)));
    }
      break;
    case VM_INS_NUMCMPE: {
      FETCH3(dest, lhs, rhs);
      set_reg(&state,
	      dest,
	      prim_numcmpe(get_reg(&state, lhs), get_reg(&state, rhs)));
    }
      break;
    case VM_INS_NUMCMPNE: {
      FETCH3(dest, lhs, rhs);
      set_reg(&state,
	      dest,
	      prim_numcmpne(get_reg(&state, lhs), get_reg(&state, rhs)));
    }
      break;
    case VM_INS_PRINT: {
      vm_num dest = fetch_num(&state);
      vm_num src = fetch_num(&state);
      set_reg(&state, dest, box_nil());
      printf("-> ");
      vm_display_object(get_reg(&state, src));
      printf("\n");
    }
      break;
    case VM_INS_NOT: {
      vm_num dest = fetch_num(&state);
      vm_num reg = fetch_num(&state);
      set_reg(&state, dest, is_nil(get_reg(&state, reg)) ? box_t() : box_nil());
    }
      break;
    default: printf("unknown instruction %d\n", op); break;
    }
  } while(1);
}

vm_obj vm_interpret_procedure(vm_world* w,
			      const char* name,
			      int argc,
			      vm_obj* argv) {
  assert(argc == 0);
  assert(argv == 0);

  string sname(name);
  bc_procedure* p = (bc_procedure*)w->bytecode[sname].get();
  vm_state s = get_procedure_state(p, w->stack);
  execute_state(w, s);
  return w->stack[0];
}
