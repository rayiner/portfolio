/*
 * gc-debug.c
 * GC debugging routines
 */

#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include "gc-internal.h"

static char* g_error_codes[] = {
  "Unknown Error", /* GC_ABORT_UNKNOWN */
  "Out of Memory", /* GC_ABORT_OOM */
  "Unimplemented Feature", /* GC_ABORT_UNIMPL */
  "Invalid Object Format", /* GC_ABORT_FORMAT */
  "OS or Runtime Error", /* GC_ABORT_OS */
  "Invalid Operation", /* GC_ABORT_INVALID_OP */
};

static char* g_zone_names[] = { ":z0", ":z1", ":z2"};

static char* g_root_kinds[] = {":ambig", ":exact"};

static char* g_event_names[] = {
  "invalid", /* */
  ":create-heap", /* GC_LOG_CREATE_HEAP */
  ":destroy-heap", /* GC_LOG_DESTROY_HEAP */
  ":register-roots", /* GC_LOG_REGISTER_ROOTS */
  ":start-gc", /* GC_LOG_START_GC */
  ":finish-gc", /* GC_LOG_FINISH_GC */
  ":trace-ambiguous-root", /* GC_LOG_TRACE_AMBIG_ROOT */
  ":scan-page", /* GC_LOG_SCAN_PAGE */
  ":scan-object", /* GC_LOG_SCAN_OBJECT */
  ":allocate-object", /* GC_LOG_ALLOC_OBJECT */
  ":allocate-page", /* GC_LOG_ALLOC_PAGE */
  ":promote-page", /* GC_LOG_PROMOTE_PAGE */
  ":note", /* GC_LOG_NOTE */
  ":trace-location", /* GC_LOG_TRACE_LOCATION */
  ":allocate-bytes", /* GC_LOG_ALLOC_BYTES */
  ":copy-object", /* GC_LOG_COPY_OBJECT */
  ":mark-object", /* GC_LOG_MARK_OBJECT */
  ":move-object", /* GC_LOG_MOVE_OBJECT */
  ":relocate-pointer", /* GC_LOG_RELOCATE_POINTER */
  ":zone-stats", /* GC_LOG_ZONE_STATS */
  ":start-compact", /* GC_LOG_START_COMPACT */
  ":finish-compact", /* GC_LOG_FINISH_COMPACT */
};

static char* g_header_format_names[] = {
  ":pointer-free", /* GC_HEADER_FORMAT_POINTER_FREE */
  ":pointer-full", /* GC_HEADER_FORMAT_POINTER_FULL */
  ":simple", /* GC_HEADER_FORMAT_SIMPLE */
  ":complex" /* GC_HEADER_FORMAT_COMPLEX */
};

void give_up(int code) {
  fprintf(stderr, "Collector aborted with: %s\n", g_error_codes[-code - 1]);
  os_exit(code);
}

const char* header_format_name(os_word format) {
  return g_header_format_names[format];
}

void print_gc_heap(gc_heap* heap) {
  printf("heap %p\n(space_counter = %d\n", heap, heap->space_counter);
  printf(" current_space = [");
  for(int i = 0; i < heap->zone_count; ++i)
    printf("%d ", heap->zone_table[i].current_space);
  printf("]\n");
  printf(" heap_pages = %p\n", heap->page_table);
  printf(" heap_memory = %p\n", heap->heap_memory);
  printf(" heap_size = %d\n", heap->heap_size);
  printf(" maybe_free_page = %d\n", 
	 index_for_page(heap, heap->maybe_free_page));
}

void print_gc_page(gc_heap* heap, gc_page* page) {
  printf("page %d (space = %d, zone = %d, fill = %d) ",
	 index_for_page(heap, page),
	 page->space,
	 page->zone,
	 page->fill);
  if(is_page_reusable(heap, page))
    printf("FREE\n");
  else
    printf("%s\n", g_zone_names[page->zone]);
}

void print_gc_root_area(gc_root_area* area) {
  printf("root area %p (kind = %s, begin = %p, end = %p)\n",
	 area,
	 g_root_kinds[area->kind],
	 area->area_low,
	 area->area_high);
}

void print_gc_header_rest(gc_header header) {
  os_word format = header_format(header);
  printf("(format = %s, ", g_header_format_names[format]);
  switch(format) {
  case GC_HEADER_FORMAT_POINTER_FREE:
  case GC_HEADER_FORMAT_POINTER_FULL:
    printf("length = %d)\n", header_dense_length(header));
    break;
  case GC_HEADER_FORMAT_SIMPLE:
    printf("length = %d, bitmap = %b)\n",
	   header_simple_length(header),
	   header_simple_bitmap(header));
    break;
  case GC_HEADER_FORMAT_COMPLEX:
    printf("index = %d)\n", header_complex_index(header));
    break;
  default:
    give_up(GC_ABORT_UNIMPL);
  }
}

void print_gc_header(gc_header header) {
  printf("gc header ");
  print_gc_header_rest(header);
}

void print_object_gc_header(os_pointer obj) {
  printf("gc header %p ", obj);
  print_gc_header_rest(object_header(obj));
}

bool should_log(gc_heap* heap) {
  return heap->is_logged;
}

void create_event_log(gc_heap* heap) {
  if(should_log(heap)) {
    char file_name[256];
    memset(file_name, 0, 256);
    sprintf(file_name, "events-%lu.txt", os_time_nsec());
    heap->event_log = fopen(file_name, "w");
    fprintf(heap->event_log, "((:create-log :heap %d)", heap);
  }
}

void finalize_event_log(gc_heap* heap) {
  if(should_log(heap)) {
    fprintf(heap->event_log, "\n (:finalize-log :heap %d))\n", heap);
    fclose(heap->event_log);
  }
}

void log_event(gc_heap* heap, int event, os_pointer object, os_word datum) {
  log_event2(heap, event, "%lu %lu", object, datum);
}

void log_event2(gc_heap* heap, int event, const char* fmt, ...) {
  if(should_log(heap)) {
    va_list va;
    va_start(va, fmt);

    fprintf(heap->event_log, "\n (%s ", g_event_names[event]);
    vfprintf(heap->event_log, fmt, va);
    fprintf(heap->event_log, ")");
    fflush(heap->event_log);
	     
    va_end(va);
  }
}
    
