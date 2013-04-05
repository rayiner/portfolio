/*
 * gc-scan.c
 * Object-field scanning.
 */

#include <assert.h>
#include <string.h>
#include "gc-internal.h"

bool maybe_call_trace_func(gc_heap* heap,
			   gc_trace* trace,
			   gc_trace_func trace_func,
			   gc_filter_func filter_func,
			   os_location loc,
			   os_word data) {
  if(!filter_func(heap, trace, *loc))
    return trace_func(heap, trace, loc, data);
  return true;
}

void scan_area(gc_heap* heap,
	       gc_trace* trace,
	       os_pointer start,
	       os_pointer end,
	       gc_trace_func trace_func,
	       gc_filter_func filter_func,
	       os_word data) {
  os_pointer iterator = start;

  while(iterator != end) {
    if(!maybe_call_trace_func(heap, 
			      trace, 
			      trace_func, 
			      filter_func,
			      (os_location)iterator, 
			      data)) {
      break;
    }

    iterator = advance_by_word(iterator);
  }
}

os_word scan_object(gc_heap* heap,
		    gc_trace* trace,
		    os_pointer obj, 
		    gc_trace_func trace_func, 
		    gc_filter_func filter_func,
		    os_word data) {
  gc_header obj_header = object_header(obj);
  os_word obj_format = header_format(obj_header);

  switch(obj_format) {
  case GC_HEADER_FORMAT_POINTER_FREE:
    return scan_pointer_free_object(heap, 
				    trace, 
				    obj, 
				    trace_func, 
				    filter_func, 
				    data);
  case GC_HEADER_FORMAT_POINTER_FULL:
    return scan_pointer_full_object(heap, 
				    trace, 
				    obj, 
				    trace_func, 
				    filter_func, 
				    data);
  case GC_HEADER_FORMAT_SIMPLE:
    return scan_simple_object(heap, trace, obj, trace_func, filter_func, data);
  case GC_HEADER_FORMAT_COMPLEX:
    return scan_complex_object(heap, trace, obj, trace_func, filter_func, data);
  }

  give_up(GC_ABORT_FORMAT);
  return 0; /* unreachable */
}

os_word scan_pointer_free_object(gc_heap* heap,
				 gc_trace* trace,
				 os_pointer obj,
				 gc_trace_func trace_func,
				 gc_filter_func filter_func,
				 os_word data) {
  return object_length(obj);
}

os_word scan_pointer_full_object(gc_heap* heap,
				 gc_trace* trace,
				 os_pointer obj,
				 gc_trace_func trace_func,
				 gc_filter_func filter_func,
				 os_word data) {
  gc_header obj_header = object_header(obj);
  os_word slot_count = header_dense_length(obj_header);

  os_pointer iterator = object_slots(obj);
  os_pointer end = iterator + words_to_bytes(slot_count);

  while(iterator != end) {
    if(!maybe_call_trace_func(heap, 
			      trace, 
			      trace_func, 
			      filter_func,
			      (os_location)iterator,
			      data)) {
      break;
    }

    iterator = advance_by_word(iterator);
  }

  return object_length_from_header(obj_header);
}

os_word scan_simple_object(gc_heap* heap,
			   gc_trace* trace,
			   os_pointer obj,
			   gc_trace_func trace_func,
			   gc_filter_func filter_func,
			   os_word data) {
  gc_header obj_header = object_header(obj);
  os_word slot_count = header_simple_length(obj_header);
  os_word slot_bitmap = header_simple_bitmap(obj_header);
  os_word scan_words = min(slot_count, GC_HEADER_SIMPLE_BITMAP_BITS);

  os_pointer iterator = object_slots(obj);
  os_pointer end = iterator + words_to_bytes(scan_words);

  os_word slot_mask = 1;
  while(iterator != end) {
    if(slot_mask & slot_bitmap) {
      if(!maybe_call_trace_func(heap, 
				trace, 
				trace_func,
				filter_func,
				(os_location)iterator,
				data)) {
	break;
      }
    }

    slot_mask <<= 1;
    iterator = advance_by_word(iterator);
  }

  return object_length_from_header(obj_header);
}

os_word scan_complex_object(gc_heap* heap,
			    gc_trace* trace,
			    os_pointer obj,
			    gc_trace_func trace_func,
			    gc_filter_func filter_func,
			    os_word data) {
  give_up(GC_ABORT_UNIMPL);
  return 0; /* unreachable */
}

void scan_page(gc_heap* heap,
	       gc_trace* trace,
	       gc_page* page,
	       gc_trace_func trace_func,
	       gc_filter_func filter_func,
	       os_word data) {
  log_event2(heap, 
	     GC_LOG_SCAN_PAGE,
	     ":page %d :mem %lu :fill %d",
	     index_for_page(heap, page),
	     pointer_for_page(heap, page), 
	     page->fill);

  os_pointer page_base = pointer_for_page(heap, page);
  os_pointer page_curr = page_base + page->scan;

  while(page_curr < (page_base + page->fill)) {
    os_word obj_len = scan_object(heap, 
				  trace, 
				  page_curr, 
				  trace_func, 
				  filter_func,  
				  data);
    page_curr += obj_len;
  }

  assert(page_curr == (page_base + page->fill));

  // only open pages might be re-scanned
  if(is_page_open(page)) {
    page->scan = page->fill;
  }
}
