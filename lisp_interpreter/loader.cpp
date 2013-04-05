/*
 * loader.cpp
 * The bytecode loader.
 */

#include <stdio.h>
#include "machine.h"

bool has_more_data(FILE* fp) {
  int c = fgetc(fp);
  if(c == EOF) return false;
  ungetc(c, fp);
  return true;
}

vm_byte read_byte(FILE* fp) {
  int result = fgetc(fp);
  if(result == EOF) vm_bail("premature end of bytecode file");
  return (vm_byte)result;
}

vm_num read_num(FILE* fp) {
  vm_num num = 0;

  int i = 0;
  do {
    vm_byte byte = read_byte(fp);
    num += (byte & 0x7F) << (i++ * 7);

    if(byte >= 0) return num;
  } while (1);
}

string read_string(FILE* fp) {
  string result;
  vm_byte byte = 0;
  do {
    byte = read_byte(fp);
    if(byte == 0) return result;
    result += byte;
  } while(1);
}

vector<vm_byte> read_byte_vector(FILE* fp, int bytes) {
  vector<vm_byte> result;
  for(int i = 0; i < bytes; ++i) {
    vm_byte byte = read_byte(fp);
    result.push_back(byte);
  }
  return result;
}

vector<vm_obj> read_obj_vector(FILE* fp, int bytes) {
  vector<vm_obj> result;
  int scale = sizeof(vm_obj);
  for(int i = 0; i < bytes / scale; ++i) {
    vm_obj obj;
    fread((void*)&obj, sizeof(vm_obj), 1, fp);
    result.push_back(obj);
  }
  return result;
}
vector<string> read_string_vector(FILE* fp, int bytes) {
  vector<string> result;
  long bytes_read = 0;
  while(bytes_read != bytes) {
    string str = read_string(fp);
    result.push_back(str);
    bytes_read += (str.length() + 1);
  }

  return result;
}

bc_procedure* read_procedure(FILE* fp, string name) {
  bc_procedure* proc = new bc_procedure;
  proc->name = name;
  proc->type = BC_ELEMENT_PROCEDURE;
  vm_num csv_length = read_num(fp);
  vm_num rv_length = read_num(fp);
  vm_num cv_length = read_num(fp);
  proc->reg_count = read_num(fp);
  proc->const_vec = read_obj_vector(fp, csv_length);
  proc->ref_vec = read_string_vector(fp, rv_length);
  proc->code_vec = read_byte_vector(fp, cv_length);

  return proc;
}

bc_element* read_element(FILE* fp) {
  if(!has_more_data(fp)) return 0;
  
  string name = read_string(fp);
  vm_byte type = read_byte(fp);

  printf("Loading element %s %d\n", name.c_str(), type);

  switch(type) {
  case BC_ELEMENT_PROCEDURE:
    return (bc_element*)read_procedure(fp, name);
    break;
  }

  return 0;
}

void vm_load_bytecode(vm_world* w, const char* file) {
  FILE* fp = fopen(file, "r");
  if(!fp) vm_bail("could not open bytecode file");

  bc_element* elt = 0;
  while((elt = read_element(fp)) != 0) {
    vm_load_element(w, elt);
  }

  fclose(fp);
}

void vm_load_element(vm_world* w, bc_element* e) {
  w->bytecode[e->name] = shared_ptr<bc_element>(e);
}

void vm_relink_world(vm_world* w) {
  bc_map::iterator itr;
  for(itr = w->bytecode.begin(); itr != w->bytecode.end(); ++itr) {
    if(itr->second->type == BC_ELEMENT_PROCEDURE)
      vm_relink_procedure(w, (bc_procedure*)itr->second.get());
  }
}

void vm_relink_procedure(vm_world* w, bc_procedure* e) {
  e->rel_ref_vec.resize(e->ref_vec.size());

  for(size_t i = 0; i < e->ref_vec.size(); ++i) {
    bc_map::iterator tgt = w->bytecode.find(e->ref_vec[i]);
    if(tgt == w->bytecode.end()) {
      e->rel_ref_vec[i] = 0;
      printf("Unknown reference to %s in %s\n", 
	     e->ref_vec[i].c_str(),
	     e->name.c_str());
    }
    else {
      e->rel_ref_vec[i] = tgt->second.get();
    }
  }
}
