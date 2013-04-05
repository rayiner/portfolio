/*
 * gc-collect.c
 * Collection logic for the GC.
 */

#include <assert.h>
#include <stdlib.h>
#include "gc-internal.h"

typedef struct _collect_args {
  gc_heap* heap;
  int max_zone;
} collect_args;

void maybe_start_collection(gc_heap* heap) {
  if(should_trigger_collection(heap)) {
    collect(heap, GC_ZONE_0);
  }
}

void collect(gc_heap* heap, int max_zone) {
  assert(max_zone < heap->zone_count); 

  log_event2(heap, 
	     GC_LOG_START_GC,
	     ":max-zone %d",
	     max_zone);

  collect_args args;
  args.heap = heap;
  args.max_zone = max_zone;

  os_suspend_other_threads();
  os_call_with_self_info(collect_rest, (os_word)&args);
  os_resume_other_threads();

  for(int i = 0; i < (max_zone + 1); ++i) {
    log_event2(heap,
	       GC_LOG_ZONE_STATS,
	       ":zone %d :live-size %d",
	       i,
	       zone_current_size(heap, i));
  }

  log_event2(heap, GC_LOG_FINISH_GC, "");
}

os_word collect_rest(os_thread_info* self_info, os_word arg) {
  collect_args* args = (collect_args*)arg;
  gc_heap* heap = args->heap;
  int max_zone = args->max_zone;

  os_thread_info* other_info = 0;
  int other_info_count;
  os_other_thread_info(&other_info, &other_info_count);

  sync_thread_contexts(heap, other_info, other_info_count, self_info);

  gc_trace trace;
  initialize_trace(heap, &trace, max_zone);

  trace_heap(heap, &trace, self_info, other_info, other_info_count);

  if(trace.did_mark_objects) {
    gc_compaction cpt;
    initialize_compaction(heap, &cpt);
    compact_heap(heap, &trace, &cpt);
    finalize_compaction(&cpt);
  }

  finalize_trace(heap, &trace);

  return 0;
}

void sync_thread_contexts(gc_heap* heap, 
			  os_thread_info* other_info,
			  int other_info_count, 
			  os_thread_info* self_info) {
  for(int i = 0; i < other_info_count; ++i) {
    sync_ab(heap,
	    (os_pointer)other_info[i].rtrs[GC_RTR_AB_CURRENT],
	    (os_pointer)other_info[i].rtrs[GC_RTR_AB_LIMIT]);
  }

  sync_ab(heap,
	  (os_pointer)self_info->rtrs[GC_RTR_AB_CURRENT],
	  (os_pointer)self_info->rtrs[GC_RTR_AB_LIMIT]);
}
