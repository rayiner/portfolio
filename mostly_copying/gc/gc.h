/*
 * gc.h
 * Interface to Vitamin garbage collector.
 */

#ifndef VITAMIN_GC_H
#define VITAMIN_GC_H

#include <stdio.h>
#include <stdbool.h>
#include "../os/os.h"

#define GC_POLICY_NONGEN 0          /* non-generational semi-space */
#define GC_POLICY_NONGEN_MC 1       /* non-generational mark-compact */
#define GC_POLICY_APPEL 2           /* Appel-style 2-generation semi-space */
#define GC_POLICY_ID_LIMIT 3

#define GC_PAGE_SIZE 1024 /* in bytes, power-of-2, <= 32KB) */
#define GC_FULL_PAGE_SIZE (GC_PAGE_SIZE - 64) /* in bytes */

#define GC_AB_SIZE GC_PAGE_SIZE /* in bytes */
#define GC_PAB_SIZE GC_PAGE_SIZE /* in bytes */
#define GC_SSB_SIZE 65536 /* in bytes */

#define GC_ZONE_TYPE_GLOBAL 0
#define GC_ZONE_TYPE_LOCAL 1

#define GC_ZONE_0 0
#define GC_STEP_0 0
#define GC_MAX_STEP_COUNT 4

#define GC_ROOTS_AMBIG 0
#define GC_ROOTS_EXACT 1

#define GC_MINIMUM_OBJECT_LENGTH 16

#define GC_MARK_STACK_SIZE 131072 /* in elements */
#define GC_PAGE_CACHE_SIZE 16 /* in entries */

#define GC_SCAN_STATUS_UNQUEUED 0
#define GC_SCAN_STATUS_QUEUED 1

#define GC_MARK_STATUS_CLEAN 0
#define GC_MARK_STATUS_DIRTY 1

#define GC_ALLOC_STATUS_CLOSED 0
#define GC_ALLOC_STATUS_OPEN 1

#define GC_ABORT_UNKNOWN -1
#define GC_ABORT_OOM -2
#define GC_ABORT_UNIMPL -3
#define GC_ABORT_FORMAT -4
#define GC_ABORT_OS -5
#define GC_ABORT_POLICY -6
#define GC_ABORT_INVALID_OP -7

#define GC_FINALIZE_CONTEXT 0

#define GC_RTR_HEAP 0
#define GC_RTR_AB_CURRENT 1
#define GC_RTR_AB_LIMIT 2
#define GC_RTR_PAB_CURRENT 3
#define GC_RTR_PAB_LIMIT 4
#define GC_RTR_SSB_CURRENT 5
#define GC_RTR_SSB_LIMIT 6

/* 
 * object header format (64-bit word)
 * [0-32)  Opaque to GC (used by language RTL)
 * [32-34) Format code (see below for codes)
 * [34-63) Format-specific data
 * [63-64) Trace status bit (forwarded marker or live bit)
 *
 * Format codes:
 * 0x0 = Pointer-free object. Rest of header is object length in words.
 * 0x1 = Pointer-full object. Rest of header is object length in words.
 * 0x2 = Simple object. Rest of header is interpreted as follows:
 *   [34-39) Object length in words
 *   [39-63) Pointer-field bitmap (1 if pointer, 0 if non-pointer)
 * 0x3 = Complex object. Rest of header is interpreted as follows:
 *   [34-63) Index into type format table.
 * 
 * Note: All object lengths are non-inclusive of the header word!
 */

#define GC_HEADER_FORMAT_POINTER_FREE 0x0
#define GC_HEADER_FORMAT_POINTER_FULL 0x1
#define GC_HEADER_FORMAT_SIMPLE 0x2
#define GC_HEADER_FORMAT_COMPLEX 0x3

#define GC_HEADER_OPAQUE_SHIFT 0
#define GC_HEADER_OPAQUE_BITS 32
#define GC_HEADER_FORMAT_SHIFT 32
#define GC_HEADER_FORMAT_BITS 2
#define GC_HEADER_DENSE_LENGTH_SHIFT 34
#define GC_HEADER_DENSE_LENGTH_BITS 28
#define GC_HEADER_SIMPLE_LENGTH_SHIFT 34
#define GC_HEADER_SIMPLE_LENGTH_BITS 5
#define GC_HEADER_SIMPLE_BITMAP_SHIFT 39
#define GC_HEADER_SIMPLE_BITMAP_BITS 23
#define GC_HEADER_COMPLEX_INDEX_SHIFT 34
#define GC_HEADER_COMPLEX_INDEX_BITS 28
#define GC_HEADER_TRACE_STATUS_SHIFT 62
#define GC_HEADER_TRACE_STATUS_BITS 1
#define GC_HEADER_OBJECT_BARRIER_SHIFT 63
#define GC_HEADER_OBJECT_BARRIER_BITS 1

typedef os_half gc_space;
typedef os_word gc_header;

typedef struct _gc_list {
  os_pointer* list_entries;
  int entry_count;
  int highest_entry;
  int max_entry_count;
} gc_list;

typedef struct _gc_list_iterator {
  gc_list* list;
  os_pointer* current;
  os_pointer* limit;
} gc_list_iterator;

typedef struct _gc_bit_table {
  long bit_count;
  os_word* bits;
} gc_bit_table;

typedef struct _gc_bit_run_iterator {
  gc_bit_table* table;
  long current_index;
  long end_index;
} gc_bit_run_iterator;

typedef struct _gc_object_stack {
  os_location stack_low;
  os_location stack_top;
  os_location stack_high;
} gc_object_stack;

typedef struct _gc_page {
  gc_space space;
  os_half fill; /* bytes */
  os_half scan; /* bytes */
  os_half zone : 8;
  os_half step : 2;
  os_half scan_status : 1;
  os_half mark_status : 1;
  os_half alloc_status : 1;
  os_half flags : 19;
  os_half link;
} gc_page;

typedef struct _gc_page_cache {
  os_half index_mask;
  int entry_count;
  gc_page** cache_entries;
  os_word age_counter;
  os_word* entry_ages;
  int hint_index;
  gc_space space;
} gc_page_cache;

typedef struct _gc_remembered_set {
  gc_list remembered_objects;
} gc_remembered_set;

typedef struct _gc_zone {
  os_half type : 2;
  os_half root : 2;
  os_half step_count : 2;
  gc_space current_space;
  os_word current_size;
} gc_zone;

/* low/high is a half-open range */
typedef struct _gc_root_area {
  int kind;
  os_pointer area_low;
  os_pointer area_high;
  struct _gc_root_area* link;
} gc_root_area;

typedef struct _gc_page_queue {
  gc_page* page_table;
  gc_page* queue_head;
  gc_page* queue_tail;
} gc_page_queue;

typedef struct _gc_trace {
  gc_space next_space;
  gc_bit_table condemned_mask;
  gc_page_cache alloc_cache;
  os_half* failure_table; /* largest allocations that _may_ succeed */
  gc_page_queue scan_queue;
  gc_object_stack mark_stack;
  bool did_mark_objects;
} gc_trace;

typedef struct _gc_compaction {
  gc_page_queue movable_queue;
  gc_page_queue unmovable_queue;
  os_pointer* offset_table;
  os_pointer highest_live_object;
} gc_compaction;

typedef struct _gc_heap {
  int policy;
  gc_space space_counter;
  os_word heap_size; /* bytes */
  gc_page* page_table;
  os_pointer heap_memory;
  int zone_count;
  gc_zone* zone_table;
  gc_bit_table mark_table;
  gc_page* maybe_free_page;
  gc_root_area* root_areas;
  bool is_logged;
  FILE* event_log;
} gc_heap;

typedef struct _gc_memory_iterator {
  gc_heap* heap;
  gc_page_queue* queue;
  os_pointer current_point;
  os_pointer limit_point;
  gc_page* current_page;
  os_pointer final_point;
} gc_memory_iterator;

typedef struct _gc_mark_table_iterator {
  gc_heap* heap;
  gc_page_queue* queue;
  gc_bit_table* table;
  gc_bit_run_iterator bit_itr;
  os_pointer current_point;
  os_pointer final_point;
} gc_mark_table_iterator;

gc_heap* gc_make_heap(os_word heap_size_bytes, int policy, bool log);
void gc_destroy_heap(gc_heap* heap);
void gc_register_roots(gc_heap* heap, 
		       int kind,
		       os_pointer low, 
		       os_pointer high);

void gc_setup_context(gc_heap* heap);
void gc_refresh_ab();
void gc_refresh_pab();
void gc_refresh_ssb();

os_pointer gc_allocate_object(gc_header header);

void gc_force_collection(gc_heap* heap, int max_zone);
bool gc_is_object_alive(gc_heap* heap, os_pointer obj);
void gc_print_heap_info(gc_heap* heap);
  
#endif
