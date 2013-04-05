/*
 * gc-trace.c
 * Heap tracing.
 */

#include <assert.h>
#include <string.h>
#include "../os/os.h"
#include "gc-internal.h"

void initialize_trace(gc_heap* heap, gc_trace* trace, int max_zone) {
  trace->next_space = make_space(heap);

  initialize_bit_table(&trace->condemned_mask, heap->zone_count);
  for(int i = 0; i <= max_zone; ++i)
    set_bit(&trace->condemned_mask, i);

  initialize_page_cache(&trace->alloc_cache, 
			     GC_PAGE_CACHE_SIZE,
			     trace->next_space);

  trace->failure_table = 
    (os_half*)calloc(heap->zone_count*GC_MAX_STEP_COUNT, sizeof(os_half));
  for(int i = 0; i < heap->zone_count*GC_MAX_STEP_COUNT; ++i)
    trace->failure_table[i] = OS_MAX_HALF;

  initialize_page_queue(heap->page_table, &trace->scan_queue);
  initialize_object_stack(&trace->mark_stack, GC_MARK_STACK_SIZE);

  trace->did_mark_objects = false;
}

void finalize_trace(gc_heap* heap, gc_trace* trace) {
  save_next_space(heap, trace);

  finalize_bit_table(&trace->condemned_mask);
  finalize_page_cache(&trace->alloc_cache);
  free(trace->failure_table);
  finalize_object_stack(&trace->mark_stack);
}

void trace_heap(gc_heap* heap, 
		gc_trace* trace,
		os_thread_info* self_info,
		os_thread_info* other_info,
		int other_info_count) {
  reset_condemned_zone_statistics(heap, trace);

  trace_global_roots(heap, trace);
  trace_thread_roots(heap, trace, self_info, other_info, other_info_count);

  while(have_things_to_scan(trace)) {
    scan_queued_pages(heap, trace);
    scan_stacked_objects(heap, trace);
  }

  flush_page_cache(&trace->alloc_cache, close_page);
}

void trace_root_area(gc_heap* heap, gc_trace* trace, gc_root_area* area) {
  if(area->kind == GC_ROOTS_AMBIG) {
    scan_area(heap,
	      trace,
	      area->area_low, 
	      area->area_high, 
	      trace_ambiguous_root,
	      filter_pointer_ambiguously,
	      0);
  } else if (area->kind == GC_ROOTS_EXACT) {
    scan_area(heap,
	      trace,
	      area->area_low,
	      area->area_high,
	      trace_field,
	      filter_pointer_exactly,
	      0);
  } else {
    give_up(GC_ABORT_UNIMPL);
  } 
}

void trace_global_roots(gc_heap* heap, gc_trace* trace) {
  gc_root_area* area = heap->root_areas;

  while(area) {
    trace_root_area(heap, trace, area);
    area = area->link;
  }
}
    
void trace_thread_roots(gc_heap* heap, 
			gc_trace* trace, 
			os_thread_info* self_info,
			os_thread_info* other_info, 
			int other_info_count) {
  for(int i = 0; i < other_info_count; ++i) {
    os_thread_info* curr_info = &other_info[i];

    gc_root_area regs_area;
    regs_area.kind = GC_ROOTS_AMBIG;
    regs_area.area_low = (os_pointer)curr_info->gprs;
    regs_area.area_high = (os_pointer)curr_info->gprs + curr_info->gpr_count;
    trace_root_area(heap, trace, &regs_area);

    gc_root_area stack_area;
    stack_area.kind = GC_ROOTS_AMBIG;
    stack_area.area_low = curr_info->stack_low;
    stack_area.area_high = curr_info->stack_high;
    trace_root_area(heap, trace, &stack_area);
  }

  gc_root_area stack_area;
  stack_area.kind = GC_ROOTS_AMBIG;
  stack_area.area_low = self_info->stack_low;
  stack_area.area_high = self_info->stack_high;
  trace_root_area(heap, trace, &stack_area);
}

bool have_things_to_scan(gc_trace* trace) {
  return (have_pages_to_scan(trace) || have_objects_to_scan(trace));
}

void scan_queued_pages(gc_heap* heap, gc_trace* trace) {
  while(have_pages_to_scan(trace)) {
    gc_page* page = dequeue_page_to_scan(trace);
    scan_page(heap, trace, page, trace_field, filter_pointer_exactly, 0);
  }
}

void scan_stacked_objects(gc_heap* heap, gc_trace* trace) {
  while(have_objects_to_scan(trace)) {
    os_pointer obj = pop_object_to_scan(trace);
    scan_object(heap, trace, obj, trace_field, filter_pointer_exactly, 0);
  }
}

bool filter_pointer_exactly(gc_heap* heap, gc_trace* trace, os_pointer ptr) {
  if(!may_point_to_object(heap, ptr))
    return true;

  gc_page* page = page_for_pointer(heap, ptr);

  if(!is_zone_condemned(heap, trace, page->zone)
     || !is_page_in_previous_space(heap, trace, page))
    return true;

  return false;
}

bool filter_pointer_ambiguously(gc_heap* heap, 
				gc_trace* trace, 
				os_pointer ptr) {
  if(!does_point_into_heap(heap, ptr))
    return true;

  gc_page* page = page_for_pointer(heap, ptr);

  if(!is_zone_condemned(heap, trace, page->zone)
     || !is_page_in_previous_space(heap, trace, page))
    return true;

  return false;
}

bool trace_ambiguous_root(gc_heap* heap, 
			  gc_trace* trace,
			  os_location loc, 
			  os_word data) {
  os_pointer target = *loc;

  gc_page* target_page = page_for_pointer(heap, target);

  int target_zone = 0;
  int target_step = 0;
  choose_target_zone_step(heap, target_page, &target_zone, &target_step);

  promote_page(heap, 
	       trace, 
	       target_page, 
	       trace->next_space, 
	       target_zone,
	       target_step);

  queue_page_for_scanning(trace, target_page);

  log_event2(heap, 
	     GC_LOG_TRACE_AMBIG_ROOT, 
	     ":root %lu :page %d",
	     target,
	     index_for_page(heap, page_for_pointer(heap, target)));

  return true;
}

bool trace_field(gc_heap* heap,
		 gc_trace* trace,
		 os_location loc, 
		 os_word data) {
  os_pointer target = *loc;

  *loc = retain_object(heap, trace, target);

  if(*loc != target) {
    log_event2(heap,
	       GC_LOG_RELOCATE_POINTER,
	       ":obj (%lu %lu)",
	       target,
	       *loc);
  }

  return true;
}

os_pointer retain_object(gc_heap* heap, 
			 gc_trace* trace, 
			 os_pointer obj) {
  gc_header header = object_header(obj);
  os_word status = header_trace_status(header); /* is forwarded? */
    
  if(status) {
    return object_forwarding_pointer(obj);
  }

  os_pointer new_obj = copy_object(heap, trace, obj, header);

  if(!new_obj) {
    new_obj = mark_object(heap, trace, obj, header);
  }

  return new_obj;
}

os_pointer copy_object(gc_heap* heap, 
		       gc_trace* trace, 
		       os_pointer obj,
		       gc_header header) {
  gc_page* page = page_for_pointer(heap, obj);

  int target_zone = 0;
  int target_step = 0;
  choose_target_zone_step(heap, page, &target_zone, &target_step);

  os_word obj_len = object_length(obj);
  os_pointer new_obj = allocate_bytes(heap, 
				      trace, 
				      obj_len, 
				      target_zone,
				      target_step);

  if(!new_obj) return 0;

  memcpy(new_obj, obj, obj_len);

  gc_header new_header = set_header_trace_status(header);
  update_object_header(obj, new_header);
  update_object_forwarding_pointer(obj, new_obj);

  log_event2(heap,
	     GC_LOG_COPY_OBJECT,
	     ":obj %lu :size %d",
	     obj,
	     obj_len);

  return new_obj;
}

os_pointer mark_object(gc_heap* heap,
		       gc_trace* trace,
		       os_pointer obj,
		       gc_header header) {
  os_word first = bytes_to_words(obj - heap->heap_memory);
  os_word last = first + bytes_to_words(object_length_from_header(header)) - 1;

  set_bit(&heap->mark_table, first);
  set_bit(&heap->mark_table, last);

  gc_page* page = page_for_pointer(heap, obj);
  dirty_page(page);

  push_object_for_scanning(trace, obj);

  trace->did_mark_objects = true;
  
  log_event2(heap,
	     GC_LOG_MARK_OBJECT,
	     ":obj %lu :first %d :last %d",
	     obj,
	     first,
	     last);
  
  return obj;
}
