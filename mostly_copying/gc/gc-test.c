/*
 * test.c
 * Simple test program for GC.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "gc.h"
#include "gc-internal.h"
#include "gc-lang.h"

typedef struct _unit_test {
  const char* (*test_fun)();
  const char* test_name;
} unit_test;

unit_test g_unit_tests[] = {
  {test_list, "list"},
  {test_bit_table, "bit table"},
  {test_object_stack, "object stack"},
  {test_page_cache, "page cache"},
  {test_memory_iterator, "memory iterator"},
  {test_mark_table_iterator, "mark table iterator"},
  {test_move_iteration, "move iteration"},
  {test_compute_moved_location, "compute moved location"},
  {0, 0}
};

os_word run_tests(os_word arg);
void list_test();

int main() {
  os_initialize();

  os_enter(run_tests, 0);

  os_finalize();

  return 0;
}

os_word run_tests(os_word arg) {
  list_test();

  unit_test* test = g_unit_tests;

  int failed = 0;
  while(test->test_fun != 0) {
    const char* result = test->test_fun();
    printf("Unit test (%s) : %s\n", test->test_name, result);
    if(strcmp(result, "passed") != 0)
      ++failed;
    ++test;
  }

  return 0;
}

void list_test() {
  int retain_factor = 64;
  int page_count = 50000;
  int max_live = 20000;
  os_word alloc_count = max_live * GC_PAGE_SIZE * retain_factor / CONS_SIZE;

  gc_heap* heap = gc_make_heap(page_count * GC_PAGE_SIZE, 
			       GC_POLICY_NONGEN, 
			       false);
  gc_setup_context(heap);

  bool failed = false;

  os_pointer list_head = 0;
  os_pointer list_tail = 0;

  for(os_word i = 0; i < alloc_count; ++i) {
    os_pointer cell = cons(0, 0);

    if((i % retain_factor == 0)) {
      if(!list_head) {
	list_head = cell;
	list_tail = cell;
      }
      else {
	set_cdr(list_tail, cell);
	list_tail = cell;
      }
    }
    /*
    int errors = 0;
    os_pointer iterator = list_head;
    for(os_word j = 0; j <= i; j += retain_factor) {
      if(object_id(iterator) != j) {
	printf("Invalid list item: found %lu, expected %lu/%lu\n", 
	       object_id(list_head),
	       j,
	       i);
	++errors;
      }

      iterator = cdr(iterator);
    };

    if(errors) {
      failed = true;
      break;
      }*/
  }

  gc_destroy_heap(heap);

  if(failed)
    printf("Failed list test\n");
  else
    printf("Passed list test\n");
}

