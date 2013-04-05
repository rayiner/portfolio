/*
 * gc-support.c
 * Infrastructure code for the GC.
 */

#include <assert.h>
#include <stdlib.h>
#include "gc-internal.h"

/* object pointers */

bool does_point_into_heap(gc_heap* heap, os_pointer ptr) {
  return (ptr >= heap->heap_memory) 
    && (ptr < (heap->heap_memory + heap->heap_size));
}

bool may_point_to_object(gc_heap* heap, os_pointer ptr) {
  return does_point_into_heap(heap, ptr) && is_pointer_word_aligned(ptr);
}

/* pages */

void initialize_page(gc_page* page, gc_space space, int zone, int step) {
  page->space = space;
  page->zone = zone;
  page->step = step;
  page->fill = 0;
  page->scan_status = GC_SCAN_STATUS_UNQUEUED;
  page->mark_status = GC_MARK_STATUS_CLEAN;
  page->alloc_status = GC_ALLOC_STATUS_CLOSED;
  page->flags = 0;
  page->link = null_link();
}

bool is_page_in_state(gc_page* page, gc_space space, int zone, int step) {
  return ((page->space == space) 
	  && (page->zone == zone) 
	  && (page->step == step));
}

void open_page(gc_page* page) {
  assert(is_page_closed(page));

  page->alloc_status = GC_ALLOC_STATUS_OPEN;
}

void close_page(gc_page* page) {
  assert(is_page_open(page));

  page->scan = 0;
  page->alloc_status = GC_ALLOC_STATUS_CLOSED;
}

bool is_page_open(gc_page* page) {
  return (page->alloc_status == GC_ALLOC_STATUS_OPEN);
}

bool is_page_closed(gc_page* page) {
  return (page->alloc_status == GC_ALLOC_STATUS_CLOSED);
}

os_word used_bytes_in_page(gc_page* page) {
  return page->fill;
}

os_word free_bytes_in_page(gc_page* page) {
  return GC_PAGE_SIZE - page->fill;
}

os_pointer page_free_area(gc_heap* heap, gc_page* page) {
  return pointer_for_page(heap, page) + page->fill;
}

bool is_page_full(gc_page* page) {
  return (used_bytes_in_page(page) >= GC_FULL_PAGE_SIZE);
}

bool will_allocation_fill_page(gc_page* page, os_word bytes) {
  return ((used_bytes_in_page(page) + bytes) >= GC_FULL_PAGE_SIZE);
}

os_pointer allocate_bytes_in_page(gc_heap* heap, gc_page* page, os_word bytes) {
  assert(bytes % sizeof(os_word) == 0);

  if(free_bytes_in_page(page) < bytes)
    return 0;

  os_pointer memory_base = page_free_area(heap, page);
  page->fill += bytes;
  return memory_base;
}

/* page table */

os_half index_for_page(gc_heap* heap, gc_page* page) {
  return page - heap->page_table;
}

gc_page* page_for_index(gc_heap* heap, int page) {
  return &heap->page_table[page];
}

gc_page* page_for_pointer(gc_heap* heap, os_pointer p) {
  os_word page_idx = (p - heap->heap_memory) / GC_PAGE_SIZE;
  return page_for_index(heap, page_idx);
}

os_pointer pointer_for_page(gc_heap* heap, gc_page* page) {
  os_word pointer_idx = (page - heap->page_table) * GC_PAGE_SIZE;
  return &heap->heap_memory[pointer_idx];
}

gc_page* page_after(gc_heap* heap, gc_page* page) {
  if((index_for_page(heap, page) + 1) == (heap->heap_size / GC_PAGE_SIZE))
    return heap->page_table;
  return page + 1;
}

gc_page* page_before(gc_heap* heap, gc_page* page) {
  if(page == heap->page_table)
    return page_for_index(heap, heap->heap_size / GC_PAGE_SIZE - 1);
  return page - 1;
}

bool do_point_to_same_page(gc_heap* heap, os_pointer p1, os_pointer p2) {
  return (page_for_pointer(heap, p1) == page_for_pointer(heap, p2));
}

/* page logic */

bool is_page_reusable(gc_heap* heap, gc_page* page) {
  return page->space < heap->zone_table[page->zone].current_space;
}

bool is_page_in_previous_space(gc_heap* heap, gc_trace* trace, gc_page* page) {
  return ((page->space >= heap->zone_table[page->zone].current_space)
	  && (page->space < trace->next_space));
}

bool is_page_in_next_space(gc_heap* heap, gc_trace* trace, gc_page* page) {
  return page->space == trace->next_space;
}

void segregate_condemned_pages(gc_heap* heap,
			       gc_trace* trace,
			       gc_page_queue* reusable_queue,
			       gc_page_queue* previous_queue,
			       gc_page_queue* next_queue) {
  gc_page* iterator = heap->page_table;
  do {
    if(is_zone_condemned(heap, trace, iterator->zone)) {
      if(reusable_queue && is_page_reusable(heap, iterator))
	queue_page(iterator, reusable_queue);

      if(is_page_in_previous_space(heap, trace, iterator))
	queue_page(iterator, previous_queue);

      if(is_page_in_next_space(heap, trace, iterator))
	queue_page(iterator, next_queue);
    }

    iterator = page_after(heap, iterator);
  } while(iterator != heap->page_table);
}

void promote_page(gc_heap* heap, 
		  gc_trace* trace,
		  gc_page* page,
		  gc_space space,
		  int zone,
		  int step) {
  assert((space > page->space) 
	 && ((zone != page->zone) || (step >= page->step)));

  assert(is_page_closed(page));

  log_event2(heap, 
	     GC_LOG_PROMOTE_PAGE,
	     ":page %d :mem %lu :space (%d %d) :zone (%d %d) :step (%d %d)",
	     index_for_page(heap, page),
	     pointer_for_page(heap, page),
	     page->space, 
	     space,
	     page->zone,
	     zone,
	     page->step,
	     step);

  page->space = space;
  page->zone = zone;
  page->step = step;

  increment_zone_size(heap, page->zone, GC_PAGE_SIZE);
}

gc_page* allocate_page(gc_heap* heap, gc_space space, int zone, int step) {
  gc_page* iterator = heap->maybe_free_page;
  do {
    gc_page* next_page = page_after(heap, iterator);
    if(is_page_reusable(heap, iterator)) {
      assert(iterator->scan == 0);

      heap->maybe_free_page  = next_page;
      initialize_page(iterator, space, zone, step);
      increment_zone_size(heap, zone, GC_PAGE_SIZE);

      log_event2(heap, 
		 GC_LOG_ALLOC_PAGE,
		 ":page %d :mem %lu :space %d :zone %d :step %d",
		 index_for_page(heap, iterator),
		 pointer_for_page(heap, iterator),
		 space,
		 zone,
		 step);

      return iterator;
    }

    iterator = next_page;
  } while(iterator != heap->maybe_free_page);

  return 0;
}

/* zones */

bool is_valid_zone(gc_heap* heap, int zone) {
  return (zone < heap->zone_count);
}

bool is_valid_step(gc_zone* zone, int step) {
  return (step < zone->step_count);
}

int index_for_zone(gc_heap* heap, gc_zone* zone) {
  return zone - heap->zone_table;
}

gc_zone* zone_for_index(gc_heap* heap, int zone) {
  return &heap->zone_table[zone];
}

bool is_zone_condemned(gc_heap* heap, gc_trace* trace, int zone) {
  return is_bit_set(&trace->condemned_mask, zone);
}

os_word zone_current_size(gc_heap* heap, int zone) {
  return heap->zone_table[zone].current_size;
}

void increment_zone_size(gc_heap* heap, int zone, os_word incr) {
  heap->zone_table[zone].current_size += incr;
}

void reset_zone_statistics(gc_heap* heap, int zone) {
  heap->zone_table[zone].current_size = 0;
}

void reset_condemned_zone_statistics(gc_heap* heap, gc_trace* trace) {
  for(int i = 0; i < heap->zone_count; ++i) {
    if(is_zone_condemned(heap, trace, i)) {
      reset_zone_statistics(heap, i);
    }
  }
}

void reset_all_zone_statistics(gc_heap* heap) {
  for(int i = 0; i < heap->zone_count; ++i)
    reset_zone_statistics(heap, i);
}

/* spaces */

gc_space make_space(gc_heap* heap) {
  return ++heap->space_counter;
}

void save_next_space(gc_heap* heap, gc_trace* trace) {
  for(int i = 0; i < heap->zone_count; ++i)
    if(is_bit_set(&trace->condemned_mask, i))
      heap->zone_table[i].current_space = trace->next_space;
}

/* root areas */

void save_root_area(gc_heap* heap, gc_root_area* ar) {
  ar->link = heap->root_areas;
  heap->root_areas = ar;
}

void free_root_areas(gc_heap* heap) {
  gc_root_area* iterator = heap->root_areas;
  while(iterator) {
    gc_root_area* temp = iterator;
    iterator = iterator->link;
    free(temp);
  }
}

/* scan queue */

void queue_page_for_scanning(gc_trace* trace, gc_page* page) {
  assert(!is_page_queued_for_scanning(page));

  page->scan_status = GC_SCAN_STATUS_QUEUED;
  queue_page(page, &trace->scan_queue);
}

gc_page* dequeue_page_to_scan(gc_trace* trace) {
  gc_page* page = dequeue_page(&trace->scan_queue);
  
  assert(is_page_queued_for_scanning(page));

  page->scan_status = GC_SCAN_STATUS_UNQUEUED;
  
  return page;
}

bool is_page_queued_for_scanning(gc_page* page) {
  return (page->scan_status == GC_SCAN_STATUS_QUEUED);
}

bool have_pages_to_scan(gc_trace* trace) {
  return !is_page_queue_empty(&trace->scan_queue);
}

/* mark stack */

void push_object_for_scanning(gc_trace* trace, os_pointer ptr) {
  push_object(ptr, &trace->mark_stack);
}

os_pointer pop_object_to_scan(gc_trace* trace) {
  return pop_object(&trace->mark_stack);
}

bool have_objects_to_scan(gc_trace* trace) {
  return !is_object_stack_empty(&trace->mark_stack);
} 

/* mark table */

void clear_mark_table_for_page(gc_heap* heap, gc_page* page) {
  long start = bytes_to_words(pointer_for_page(heap, page) - heap->heap_memory);
  long run = bytes_to_words(GC_PAGE_SIZE);

  clear_run(&heap->mark_table, start, run);
}

void dirty_page(gc_page* page) {
  page->mark_status = GC_MARK_STATUS_DIRTY;
}

void clean_page(gc_heap* heap, gc_page* page) {
  if(page->mark_status == GC_MARK_STATUS_DIRTY) {
    clear_mark_table_for_page(heap, page);
    page->mark_status = GC_MARK_STATUS_CLEAN;
  }
}

bool is_page_dirty(gc_page* page) {
  return (page->mark_status == GC_MARK_STATUS_DIRTY);
}

bool is_page_clean(gc_page* page) {
  return (page->mark_status == GC_MARK_STATUS_CLEAN);
}

/* allocation during tracing */

void remember_allocation_failure(gc_trace* trace, 
				 os_word bytes, 
				 int zone, 
				 int step) {
  int index = zone * GC_MAX_STEP_COUNT + step;
  trace->failure_table[index] = min(bytes - 1, trace->failure_table[index]);
}

bool will_allocation_fail(gc_trace* trace, os_word bytes, int zone, int step) {
  int index = zone * GC_MAX_STEP_COUNT + step;
  return (bytes > trace->failure_table[index]);
}

gc_page* find_open_page(gc_heap* heap, 
			gc_trace* trace, 
			os_word bytes, 
			int zone, 
			int step) {
  gc_page* alloc_page = lookup_page(&trace->alloc_cache, bytes, zone, step);

  if(!alloc_page) {
    alloc_page = allocate_page(heap, trace->next_space, zone, step);

    if(!alloc_page) return 0;

    open_page(alloc_page);
    gc_page* evicted_page = cache_page(&trace->alloc_cache, alloc_page);

    if(evicted_page) {
      close_page(evicted_page);
    }
  }

  assert(is_page_open(alloc_page));
  assert(is_page_clean(alloc_page));

  return alloc_page;
}

os_pointer allocate_bytes(gc_heap* heap, 
			  gc_trace* trace,
			  os_word bytes, 
			  int zone,
			  int step) {
  if(will_allocation_fail(trace, bytes, zone, step)) {
    return 0;
  }

  gc_page* alloc_page = find_open_page(heap, trace, bytes, zone, step);

  if(!alloc_page) {
    remember_allocation_failure(trace, bytes, zone, step);
    return 0;
  }

  if(!is_page_queued_for_scanning(alloc_page))
    queue_page_for_scanning(trace, alloc_page);
  
  log_event2(heap,
	     GC_LOG_ALLOC_BYTES,
	     ":page %d :size %d :space %d :zone %d :step %d",
	     index_for_page(heap, alloc_page),
	     bytes,
	     trace->next_space,
	     zone,
	     step);

  return allocate_bytes_in_page(heap, alloc_page, bytes);
}

/* contexts */

void cleanup_context(os_word arg) {
  os_pointer ssb_base = (os_pointer)arg;

  free(ssb_base);
}

bool is_ab_valid(gc_heap* heap, os_pointer current) {
  return ((current >= heap->heap_memory)
	  && (current <= (heap->heap_memory + heap->heap_size)));
}

void sync_ab(gc_heap* heap, os_pointer current, os_pointer limit) {
  os_pointer base = limit - GC_AB_SIZE;
  gc_page* page = page_for_pointer(heap, base);
  os_word new_fill = current - base;
  
  page->fill = current - base;
}
