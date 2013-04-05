/*
 * gc-compact.c
 * Mechanism for compacting collection.
 */

#include <assert.h>
#include <string.h>
#include "gc-internal.h"

typedef struct _compact_args {
  gc_trace* trace;
  gc_compaction* cpt;
} compact_args;

typedef struct _record_object_destination_state {
  os_pointer src;
  os_pointer dst;
} record_object_destination_state;

typedef struct _test_move_state {
  long fill;
  bool failed;
} test_move_state;

void initialize_compaction(gc_heap* heap, gc_compaction* cpt) {
  initialize_page_queue(heap->page_table, &cpt->movable_queue);
  initialize_page_queue(heap->page_table, &cpt->unmovable_queue);

  os_word page_count = bytes_to_pages(heap->heap_size);
  cpt->offset_table = (os_pointer*)calloc(page_count, sizeof(os_word));

  cpt->highest_live_object = 0;
}

void finalize_compaction(gc_compaction* cpt) {
  free(cpt->offset_table);
}

void iterate_over_moves(gc_heap* heap,
			gc_bit_table* table,
			gc_page_queue* queue,
			gc_move_func move_func,
			os_word data,
			os_pointer src_begin,
			os_pointer src_end,
			os_pointer dst_begin) {
  gc_mark_table_iterator mark_itr;
  begin_mark_table_iteration(heap, queue, table, &mark_itr, src_begin, src_end);

  gc_memory_iterator mem_itr;
  begin_memory_iteration(heap, queue, &mem_itr, dst_begin, 0);

  os_pointer obj_base = 0;
  os_word obj_len = 0;

  while(find_next_marked_object(&mark_itr, &obj_base, &obj_len)) {
    os_pointer obj_dst = advance_point(&mem_itr, obj_len, true);

    assert(obj_dst);

    if(!move_func(heap, obj_base, obj_dst, obj_len, data)) break;
  }
}

void compact_heap(gc_heap* heap, gc_trace* trace, gc_compaction* cpt) {
  log_event2(heap, GC_LOG_START_COMPACT, "");

  segregate_condemned_pages(heap, 
			    trace, 
			    0, 
			    &cpt->movable_queue, 
			    &cpt->unmovable_queue);

  determine_move_metrics(heap, cpt);
  move_marked_objects(heap, trace, cpt);
  fixup_unmovable_pages(heap, trace, cpt);
  promote_movable_pages(heap, trace, cpt);

  log_event2(heap, GC_LOG_FINISH_COMPACT, "");
}

void determine_move_metrics(gc_heap* heap, gc_compaction* cpt) {
  compact_args args;
  args.trace = 0;
  args.cpt = cpt;

  iterate_over_moves(heap,
		     &heap->mark_table,
		     &cpt->movable_queue,
		     update_metrics_for_move,
		     (os_word)&args,
		     0,
		     0,
		     0);
}

bool update_metrics_for_move(gc_heap* heap,
			     os_pointer src,
			     os_pointer dst,
			     os_word len,
			     os_word data) {
  compact_args* args = (compact_args*)data;
  gc_compaction* cpt = args->cpt;

  assert(dst <= src);

  gc_page* src_page = page_for_pointer(heap, src);
  os_word src_index = index_for_page(heap, src_page);
  gc_page* dst_page = page_for_pointer(heap, dst);
  os_pointer dst_base = pointer_for_page(heap, dst_page);

  if(!cpt->offset_table[src_index])
    cpt->offset_table[src_index] = dst;

  os_word new_fill = dst + len - dst_base;
  
  dst_page->fill = new_fill;

  cpt->highest_live_object = pmax(cpt->highest_live_object, dst);

  return true;
}

void move_marked_objects(gc_heap* heap, 
			 gc_trace* trace, 
			 gc_compaction* cpt) {
  compact_args args;
  args.trace = trace;
  args.cpt = cpt;

  iterate_over_moves(heap,
		     &heap->mark_table,
		     &cpt->movable_queue,
		     move_and_fixup_object,
		     (os_word)&args,
		     0,
		     0,
		     0);
}

bool move_and_fixup_object(gc_heap* heap,
			   os_pointer src,
			   os_pointer dst,
			   os_word len,
			   os_word data) {
  compact_args* args = (compact_args*)data;
  gc_trace* trace = args->trace;

  memmove(dst, src, len);
  scan_object(heap, trace, dst, fixup_field, filter_pointer_exactly, data);

  log_event2(heap,
	     GC_LOG_MOVE_OBJECT,
	     ":obj (%lu %lu) :size %d",
	     src,
	     dst,
	     len);

  return true;
}

bool fixup_field(gc_heap* heap,
		 gc_trace* trace,
		 os_location loc, 
		 os_word data) {
  compact_args* args = (compact_args*)data;
  gc_compaction* cpt = args->cpt;

  os_pointer target = *loc;
  *loc = compute_moved_location(heap, trace, cpt, target, false);

  if(*loc != target) {
    log_event2(heap,
	       GC_LOG_RELOCATE_POINTER,
	       ":obj (%lu %lu)",
	       target,
	       *loc);
  }

  return true;
}

os_pointer compute_moved_location(gc_heap* heap,
				  gc_trace* trace,
				  gc_compaction* cpt,
				  os_pointer obj,
				  bool exhaustive) {
  record_object_destination_state state;
  state.src = obj;
  state.dst = 0;

  gc_page* page = page_for_pointer(heap, obj);
  os_word index = index_for_page(heap, page);
  os_pointer page_start = 0;
  os_pointer page_end = 0;
  os_pointer dst_hint = 0;

  if(exhaustive) {
    page_start = 0;
    page_end = 0;
    dst_hint = 0;
  } else {
    page_start = pointer_for_page(heap, page);
    page_end = page_start + GC_PAGE_SIZE;
    dst_hint = cpt->offset_table[index];
  }

  iterate_over_moves(heap,
		     &heap->mark_table,
		     &cpt->movable_queue,
		     record_moved_location,
		     (os_word)&state,
		     page_start,
		     page_end,
		     dst_hint);

  assert(state.dst);

  return state.dst;
}

bool record_moved_location(gc_heap* heap,
			   os_pointer src,
			   os_pointer dst,
			   os_word len,
			   os_word data) {
  record_object_destination_state* state
    = (record_object_destination_state*)data;

  if(state->src == src) {
    state->dst = dst;
    return false;
  }

  return true;
}

void fixup_unmovable_pages(gc_heap* heap, gc_trace* trace, gc_compaction* cpt) {
  compact_args args;
  args.trace = trace;
  args.cpt = cpt;

  while(!is_page_queue_empty(&cpt->unmovable_queue)) {
    gc_page* page = dequeue_page(&cpt->unmovable_queue);
    scan_page(heap, 
	      trace, 
	      page, 
	      fixup_field, 
	      filter_pointer_exactly, 
	      (os_word)&args);
  }
}

void promote_movable_pages(gc_heap* heap, gc_trace* trace, gc_compaction* cpt) {
  gc_page* highest_live_page = page_for_pointer(heap, cpt->highest_live_object);
  while(!is_page_queue_empty(&cpt->movable_queue)) {
    gc_page* page = dequeue_page(&cpt->movable_queue);

    if(page <= highest_live_page) {
      promote_page(heap, 
		   trace, 
		   page, 
		   trace->next_space, 
		   page->zone, 
		   page->step);
    }

    clean_page(heap, page);
  }
}

const char* test_move_iteration() {
  gc_heap* heap = gc_make_heap(8192, GC_POLICY_NONGEN, false);
  populate_bit_table(&heap->mark_table,
		     g_fake_obj_table,
		     GC_FAKE_OBJ_TABLE_LENGTH);

  gc_page_queue queue;
  queue_even_pages(heap, &queue);

  test_move_state state;
  state.fill = 0;
  state.failed = false;

  iterate_over_moves(heap,
		     &heap->mark_table,
		     &queue,
		     test_move_callback,
		     (os_word)&state,
		     0,
		     0,
		     0);

  gc_destroy_heap(heap);

  if(state.failed)
    return "iterate over moves failed";

  return "passed";
}

bool test_move_callback(gc_heap* heap,
			os_pointer src,
			os_pointer dst,
			os_word len,
			os_word data) {
  test_move_state* state = (test_move_state*)data;

  os_word dst_offt = bytes_to_words(dst - heap->heap_memory);
  os_word len_words = bytes_to_words(len);

  if((state->fill + len_words) > bytes_to_words(GC_PAGE_SIZE))
    state->fill = 0;

  if((dst_offt % bytes_to_words(GC_PAGE_SIZE)) != (os_word)state->fill) {
    state->failed = true;
  }

  if((dst_offt / bytes_to_words(GC_PAGE_SIZE)) % 2 != 0)
    state->failed = true;

  state->fill += len_words;

  return true;
}

const char* test_compute_moved_location() {
  gc_heap* heap = gc_make_heap(8192, GC_POLICY_NONGEN, false);
  populate_bit_table(&heap->mark_table,
		     g_fake_obj_table,
		     GC_FAKE_OBJ_TABLE_LENGTH);
  
  gc_compaction cpt;
  initialize_compaction(heap, &cpt);
  queue_even_pages(heap, &cpt.movable_queue);

  determine_move_metrics(heap, &cpt);

  for(int i = 0; i < GC_FAKE_OBJ_TABLE_LENGTH; i += 2) {
    long page = g_fake_obj_table[i] / bytes_to_words(GC_PAGE_SIZE);

    if(page % 2 == 0) {
      os_pointer obj = heap->heap_memory + words_to_bytes(g_fake_obj_table[i]);
      
      os_pointer hint_loc = compute_moved_location(heap, 0, &cpt, obj, false);
      os_pointer real_loc = compute_moved_location(heap, 0, &cpt, obj, true);

      if(hint_loc != real_loc) {
	return "compute moved location failed";
      }
    }
  } 

  gc_destroy_heap(heap);

  return "passed";
}
