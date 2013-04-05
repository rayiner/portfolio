/*
 * gc.c
 * Vitamin garbage collector.
 */

#include <stdio.h>
#include <string.h>
#include <assert.h>
#include "gc.h"
#include "gc-internal.h"

gc_heap* gc_make_heap(os_word heap_size_bytes, int policy, bool log) {
  assert(policy < GC_POLICY_ID_LIMIT);

  gc_heap* heap = (gc_heap*)calloc(1, sizeof(gc_heap));

  heap->policy = policy;
  heap->space_counter = 1;

  os_word page_count = bytes_to_pages(heap_size_bytes);
  os_word page_table_size = page_count * sizeof(gc_page);
  os_word rounded_heap_size = round_bytes_to_page_size(heap_size_bytes);

  heap->heap_size = rounded_heap_size;
  
  if(os_map_memory(page_table_size, (os_location)&heap->page_table) != OS_OK)
    give_up(GC_ABORT_OOM);

  for(os_word i = 0; i < page_count; ++i) {
    initialize_page(&heap->page_table[i], 0, 0, 0);
  }

  if(os_map_memory(rounded_heap_size, (os_location)&heap->heap_memory) != OS_OK)
    give_up(GC_ABORT_OOM);

  heap->zone_count = choose_zone_count(heap);
  heap->zone_table = (gc_zone*)calloc(heap->zone_count, sizeof(gc_zone));
  implement_zone_configuration(heap);

  for(int i = 0; i < heap->zone_count; ++i)
    heap->zone_table[i].current_space = 1;

  reset_all_zone_statistics(heap);

  initialize_bit_table(&heap->mark_table, bytes_to_words(heap->heap_size));

  heap->maybe_free_page = heap->page_table;
  heap->root_areas = 0;

  heap->is_logged = log;
  create_event_log(heap);

  log_event2(heap, 
	     GC_LOG_CREATE_HEAP, 
	     ":heap %lu :mem %lu :size %d :page-size %d :zones %d",
	     heap,
	     heap->heap_memory,
	     heap_size_bytes,
	     GC_PAGE_SIZE,
	     heap->zone_count);

  return heap;
}

void gc_destroy_heap(gc_heap* heap) {
  os_word page_table_size = heap->heap_size / GC_PAGE_SIZE * sizeof(gc_page);

  if(os_unmap_memory((os_pointer)heap->page_table, page_table_size) != OS_OK)
    give_up(GC_ABORT_UNKNOWN);

  if(os_unmap_memory(heap->heap_memory, heap->heap_size) != OS_OK)
    give_up(GC_ABORT_UNKNOWN);

  finalize_bit_table(&heap->mark_table);

  free_root_areas(heap);

  log_event2(heap, 
	     GC_LOG_DESTROY_HEAP, 
	     ":heap %lu",
	     heap);

  finalize_event_log(heap);

  free(heap);
}

void gc_register_roots(gc_heap* heap, 
		       int kind, 
		       os_pointer low, 
		       os_pointer high) {
  gc_root_area* area = (gc_root_area*)calloc(1, sizeof(gc_root_area));
  area->kind = kind;
  area->area_low = low;
  area->area_high = high;
  save_root_area(heap, area);

  log_event2(heap, 
	     GC_LOG_REGISTER_ROOTS, 
	     ":base %lu :size %d",
	     area->area_low,
	     area->area_high - area->area_low);
}

void gc_setup_context(gc_heap* heap) {
  os_word exist_heap = os_get_rtr(GC_RTR_HEAP);

  if(exist_heap) give_up(GC_ABORT_INVALID_OP);

  os_pointer ssb_base = (os_pointer)malloc(GC_SSB_SIZE);

  os_set_rtr(GC_RTR_HEAP, (os_word)heap);
  os_set_rtr(GC_RTR_AB_CURRENT, 0);
  os_set_rtr(GC_RTR_AB_LIMIT, 0);
  os_set_rtr(GC_RTR_PAB_CURRENT, 0);
  os_set_rtr(GC_RTR_PAB_LIMIT, 0);
  os_set_rtr(GC_RTR_SSB_CURRENT, (os_word)ssb_base);
  os_set_rtr(GC_RTR_SSB_LIMIT, (os_word)(ssb_base + GC_SSB_SIZE));
}

void gc_refresh_ab() {
  gc_heap* heap = (gc_heap*)os_get_rtr(GC_RTR_HEAP);
  os_pointer current = (os_pointer)os_get_rtr(GC_RTR_AB_CURRENT);
  os_pointer limit = (os_pointer)os_get_rtr(GC_RTR_AB_LIMIT);

  if(is_ab_valid(heap, current))
    sync_ab(heap, current, limit);

  maybe_start_collection(heap);

  gc_page* page = allocate_page(heap, 
				heap->zone_table[0].current_space,
				GC_ZONE_0,
				GC_STEP_0);

  if(!page)
    give_up(GC_ABORT_OOM);

  os_pointer p = pointer_for_page(heap, page);

  os_set_rtr(GC_RTR_AB_CURRENT, (os_word)p);
  os_set_rtr(GC_RTR_AB_LIMIT, (os_word)(p + GC_AB_SIZE));
}

os_pointer gc_allocate_object(gc_header header) {
  gc_heap* heap = (gc_heap*)os_get_rtr(GC_RTR_HEAP);

  os_word obj_len = object_length_from_header(header);

  os_pointer current = (os_pointer)os_get_rtr(GC_RTR_AB_CURRENT);
  os_pointer limit = (os_pointer)os_get_rtr(GC_RTR_AB_LIMIT);

  if((current + obj_len) > limit) {
    gc_refresh_ab(heap);

    current = (os_pointer)os_get_rtr(GC_RTR_AB_CURRENT);
    limit = (os_pointer)os_get_rtr(GC_RTR_AB_LIMIT);
  }

  os_pointer obj_ptr = current;

  memset(obj_ptr, 0, obj_len);
  update_object_header(obj_ptr, header);

  os_set_rtr(GC_RTR_AB_CURRENT, (os_word)(current + obj_len));

  log_event2(heap,
	     GC_LOG_ALLOC_OBJECT, 
	     ":obj %lu :size %d",
	     obj_ptr,
	     obj_len);

  return obj_ptr;
}

void gc_force_collection(gc_heap* heap, int max_zone) {
  collect(heap, max_zone);
}

bool gc_is_object_alive(gc_heap* heap, os_pointer obj) {
  gc_page* page = page_for_pointer(heap, obj);
  return !is_page_reusable(heap, page);
} 

void gc_print_heap_info(gc_heap* heap) {
  print_gc_heap(heap);
  printf("--- root areas ---\n");
  gc_root_area* iterator = heap->root_areas;
  while(iterator) {
    print_gc_root_area(iterator);
    iterator = iterator->link;
  }
  printf("--- page table ---\n");
  for(os_word i = 0; i < heap->heap_size / GC_PAGE_SIZE; ++i)
    print_gc_page(heap, &heap->page_table[i]);
}
