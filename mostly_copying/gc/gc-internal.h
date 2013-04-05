/*
 * gc-internal.h
 * Internal GC definitions.
 */

#ifndef VITAMIN_GC_INTERNAL_H
#define VITAMIN_GC_INTERNAL_H

#include <stdbool.h>
#include "gc.h"

/* event log codes */

#define GC_LOG_CREATE_HEAP 1
#define GC_LOG_DESTROY_HEAP 2
#define GC_LOG_REGISTER_ROOTS 3
#define GC_LOG_START_GC 4
#define GC_LOG_FINISH_GC 5
#define GC_LOG_TRACE_AMBIG_ROOT 6
#define GC_LOG_SCAN_PAGE 7
#define GC_LOG_SCAN_OBJECT 8
#define GC_LOG_ALLOC_OBJECT 9
#define GC_LOG_ALLOC_PAGE 10
#define GC_LOG_PROMOTE_PAGE 11
#define GC_LOG_NOTE 12
#define GC_LOG_TRACE_LOCATION 13
#define GC_LOG_ALLOC_BYTES 14
#define GC_LOG_COPY_OBJECT 15
#define GC_LOG_MARK_OBJECT 16
#define GC_LOG_MOVE_OBJECT 17
#define GC_LOG_RELOCATE_POINTER 18
#define GC_LOG_ZONE_STATS 19
#define GC_LOG_START_COMPACT 20
#define GC_LOG_FINISH_COMPACT 21

/* gc-utility.c */
#define GC_FAKE_OBJ_TABLE_LENGTH 26
extern long g_fake_obj_table[];

os_word bytes_to_pages(os_word bytes);
os_word round_bytes_to_page_size(os_word bytes);
os_word bytes_to_words(os_word bytes);
os_word words_to_bytes(os_word words);
os_word bits_to_words(os_word bits);
os_word words_to_bits(os_word words);
os_word min(os_word a, os_word b);
os_word max(os_word a, os_word b);
os_pointer pmin(os_pointer a, os_pointer b);
os_pointer pmax(os_pointer a, os_pointer b);
os_pointer por(os_pointer a, os_pointer b);
os_pointer advance_by_word(os_pointer p);
bool is_pointer_word_aligned(os_pointer p);

void initialize_list(gc_list* list);
void finalize_list();
void append_item(os_pointer item, gc_list* list);
void begin_list_iteration(gc_list* list, gc_list_iterator* itr);
os_pointer current_item(gc_list_iterator* itr);
void advance_item(gc_list_iterator* itr);
void advance_to_valid_item(gc_list_iterator* itr);
void remove_item(gc_list_iterator* itr);
void compact_list(gc_list* list);
void clear_list(gc_list* list);

void initialize_bit_table(gc_bit_table* table, long bit_count);
void finalize_bit_table(gc_bit_table* table);
void set_bit(gc_bit_table* table, long idx);
void clear_bit(gc_bit_table* table, long idx);
bool is_bit_set(gc_bit_table* table, long idx);
void clear_run(gc_bit_table* table, long start, long len);
void clear_bit_table(gc_bit_table* table);
long find_first_set_bit(gc_bit_table* table, long start, long end);
void begin_run_iteration(gc_bit_table* table, 
			 gc_bit_run_iterator* itr,
			 long start,
			 long end);
bool find_next_run(gc_bit_run_iterator* itr,
		   long* start,
		   long* len);
void move_run_iterator(gc_bit_run_iterator* itr, long curr);

void initialize_object_stack(gc_object_stack* stack, int stack_elems);
void finalize_object_stack(gc_object_stack* stack);
void push_object(os_pointer ptr, gc_object_stack* stack);
os_pointer pop_object(gc_object_stack* stack);
bool is_object_stack_empty(gc_object_stack* stack);

os_half null_link();
bool is_link_null(os_half link);
gc_page* page_for_link(gc_page_queue* queue, os_half link);
os_half link_for_page(gc_page_queue* queue, gc_page* page);
void initialize_page_queue(gc_page* table, gc_page_queue* queue);
void queue_page(gc_page* page, gc_page_queue* queue);
gc_page* dequeue_page(gc_page_queue* queue);
gc_page* page_queue_head(gc_page_queue* queue);
gc_page* next_queued_page(gc_page_queue* queue, gc_page* page);
bool is_page_queue_empty(gc_page_queue* queue);

void initialize_page_cache(gc_page_cache* cache, int entries, gc_space space);
void finalize_page_cache(gc_page_cache* cache);
bool does_page_match(gc_page* page, 
		     os_word bytes, 
		     gc_space space, 
		     int zone, 
		     int step);
gc_page* cache_page(gc_page_cache* cache, gc_page* page);
gc_page* lookup_page(gc_page_cache* cache, os_word bytes, int zone, int step);
void flush_page_cache(gc_page_cache* cache, void (*finalizer)(gc_page* page));

void begin_memory_iteration(gc_heap* heap, 
			    gc_page_queue* queue,
			    gc_memory_iterator* itr,
			    os_pointer start,
			    os_pointer end);
os_pointer current_point(gc_memory_iterator* itr);
os_pointer advance_point(gc_memory_iterator* itr, os_word bytes, bool contig);

void begin_bit_run_iteration_on_page(gc_heap* heap,
				     gc_bit_table* table,
				     gc_bit_run_iterator* itr,
				     os_pointer start,
				     os_pointer end);
void begin_mark_table_iteration(gc_heap* heap,
				gc_page_queue* queue,
				gc_bit_table* table,
				gc_mark_table_iterator* itr,
				os_pointer start,
				os_pointer end);
bool find_next_marked_object(gc_mark_table_iterator* itr,
			     os_pointer* obj,
			     os_word* obj_len);

void populate_bit_table(gc_bit_table* table, long* objects, int count);
void queue_even_pages(gc_heap* heap, gc_page_queue* queue);

const char* test_list();
const char* test_bit_table();
const char* test_object_stack();
const char* test_page_cache();
const char* test_memory_iterator();
const char* test_mark_table_iterator();

/* gc-object.c */
os_word generate_mask(int shift, int bits);
os_word extract_field(gc_header h, int shift, int bits);
os_word insert_field(gc_header h, int shift, int bits, os_word val);
os_word header_format(gc_header h);
os_word header_trace_status(gc_header h);
gc_header set_header_trace_status(gc_header h);
gc_header clear_header_trace_status(gc_header h);
os_word header_object_barrier(gc_header h);
gc_header set_header_object_barrier(gc_header h);
gc_header clear_header_object_barrier(gc_header h);
os_word header_dense_length(gc_header h);
os_word header_simple_length(gc_header h);
os_word header_simple_bitmap(gc_header h);
os_word header_complex_index(gc_header h);
gc_header object_header(os_pointer p);
void update_object_header(os_pointer p, gc_header h);
os_pointer object_slots(os_pointer p);
os_pointer object_forwarding_pointer(os_pointer p);
void update_object_forwarding_pointer(os_pointer p, os_pointer newp);
os_word object_length(os_pointer p);
os_word object_length_from_header(gc_header h);

bool is_object_format_pointer_free(gc_header h);

/* gc-support.c */
bool does_point_into_heap(gc_heap* heap, os_pointer ptr);
bool may_point_to_object(gc_heap* heap, os_pointer ptr);

void initialize_page(gc_page* page, gc_space space, int zone, int step);
bool is_page_in_state(gc_page* page, gc_space space, int zone, int step);
void open_page(gc_page* page);
void close_page(gc_page* page);
bool is_page_open(gc_page* page);
bool is_page_closed(gc_page* page);
os_word free_bytes_in_page(gc_page* page);
os_pointer page_free_area(gc_heap* heap, gc_page* page);
bool is_page_full(gc_page* page);
bool will_allocation_fill_page(gc_page* page, os_word bytes);
os_pointer allocate_bytes_in_page(gc_heap* heap, gc_page* page, os_word bytes);

os_half index_for_page(gc_heap* heap, gc_page* page);
gc_page* page_for_index(gc_heap* heap, int page);
gc_page* page_for_pointer(gc_heap* heap, os_pointer p);
os_pointer pointer_for_page(gc_heap* heap, gc_page* page);
gc_page* page_after(gc_heap* heap, gc_page* page);
gc_page* page_before(gc_heap* heap, gc_page* page);
bool do_point_to_same_page(gc_heap* heap, os_pointer p1, os_pointer p2);

bool is_page_reusable(gc_heap* heap, gc_page* page);
bool is_page_in_previous_space(gc_heap* heap, gc_trace* trace, gc_page* page);
bool is_page_in_next_space(gc_heap* heap, gc_trace* trace, gc_page* page);
void segregate_condemned_pages(gc_heap* heap, 
			       gc_trace* trace, 
			       gc_page_queue* reusable_queue,
			       gc_page_queue* previous_queue,
			       gc_page_queue* next_queue);
void promote_page(gc_heap* heap, 
		  gc_trace* trace,
		  gc_page* page, 
		  gc_space space, 
		  int zone, 
		  int step);
gc_page* allocate_page(gc_heap* heap, gc_space space, int zone, int step);

bool is_valid_zone(gc_heap* heap, int zone);
bool is_valid_step(gc_zone* zone, int step);
int index_for_zone(gc_heap* heap, gc_zone* zone);
gc_zone* zone_for_index(gc_heap* heap, int zone);
bool is_zone_condemned(gc_heap* heap, gc_trace* trace, int zone);
os_word zone_current_size(gc_heap* heap, int zone);
void increment_zone_size(gc_heap* heap, int zone, os_word incr);
void reset_zone_statistics(gc_heap* heap, int zone);
void reset_condemned_zone_statistics(gc_heap* heap, gc_trace* trace);
void reset_all_zone_statistics(gc_heap* heap);

gc_space make_space(gc_heap* heap);
void save_next_space(gc_heap* heap, gc_trace* trace);

void save_root_area(gc_heap* heap, gc_root_area* ar);
void free_root_areas(gc_heap* heap);

void queue_page_for_scanning(gc_trace* trace, gc_page* page);
gc_page* dequeue_page_to_scan(gc_trace* trace);
bool is_page_queued_for_scanning(gc_page* page);
bool have_pages_to_scan(gc_trace* trace);

void push_object_for_scanning(gc_trace* trace, os_pointer ptr);
os_pointer pop_object_to_scan(gc_trace* trace);
bool have_objects_to_scan(gc_trace* trace);

void clear_mark_table_for_page(gc_heap* heap, gc_page* page);
void dirty_page(gc_page* page);
void clean_page(gc_heap* heap, gc_page* page);
bool is_page_dirty(gc_page* page);
bool is_page_clean(gc_page* page);

void remember_allocation_failure(gc_trace* trace, 
				 os_word bytes, 
				 int zone, 
				 int step);
bool will_allocation_fail(gc_trace* trace, os_word bytes, int zone, int step);
gc_page* find_open_page(gc_heap* heap, 
			gc_trace* trace, 
			os_word bytes, 
			int zone, 
			int step);
os_pointer allocate_bytes(gc_heap* heap, 
			  gc_trace* trace,
			  os_word bytes, 
			  int zone,
			  int step);

void cleanup_context(os_word arg);
bool is_ab_valid(gc_heap* heap, os_pointer current);
void sync_ab(gc_heap* heap, os_pointer current, os_pointer limit);

/* gc-scan.c */
typedef bool (*gc_trace_func)(gc_heap* heap,
			      gc_trace* trace,
			      os_location loc, 
			      os_word data);

typedef bool (*gc_filter_func)(gc_heap* heap,
			       gc_trace* trace,
			       os_pointer ptr);

bool maybe_call_trace_func(gc_heap* heap,
			   gc_trace* trace,
			   gc_trace_func trace_func,
			   gc_filter_func filter_func,
			   os_location loc,
			   os_word data);

void scan_area(gc_heap* heap,
	       gc_trace* trace,
	       os_pointer start,
	       os_pointer end,
	       gc_trace_func trace_func,
	       gc_filter_func filter_func,
	       os_word data);
os_word scan_object(gc_heap* heap,
		    gc_trace* trace,
		    os_pointer obj, 
		    gc_trace_func trace_func, 
		    gc_filter_func filter_func,
		    os_word data);
os_word scan_pointer_free_object(gc_heap* heap,
				 gc_trace* trace,
				 os_pointer obj,
				 gc_trace_func trace_func,
				 gc_filter_func filter_func,
				 os_word data);
os_word scan_pointer_full_object(gc_heap* heap,
				 gc_trace* trace,
				 os_pointer obj,
				 gc_trace_func trace_func,
				 gc_filter_func filter_func,
				 os_word data);
os_word scan_simple_object(gc_heap* heap,
			   gc_trace* trace,
			   os_pointer obj,
			   gc_trace_func trace_func,
			   gc_filter_func filter_func,
			   os_word data);
os_word scan_complex_object(gc_heap* heap,
			    gc_trace* trace,
			    os_pointer obj,
			    gc_trace_func trace_func,
			    gc_filter_func filter_func,
			    os_word data);
void scan_page(gc_heap* heap, 
	       gc_trace* trace,
	       gc_page* page,
	       gc_trace_func trace_func,
	       gc_filter_func filter_func,
	       os_word data);

/* gc-trace.c */
void initialize_trace(gc_heap* heap, gc_trace* trace, int max_zone);
void finalize_trace(gc_heap* heap, gc_trace* trace);

void trace_heap(gc_heap* heap, 
		gc_trace* trace, 
		os_thread_info* self_info,
		os_thread_info* other_info,
		int other_info_count);
void trace_root_area(gc_heap* heap, gc_trace* trace, gc_root_area* area);
void trace_global_roots(gc_heap* heap, gc_trace* trace);
void trace_thread_roots(gc_heap* heap, 
			gc_trace* trace, 
			os_thread_info* self_info,
			os_thread_info* other_info, 
			int other_info_count);

bool have_things_to_scan(gc_trace* trace);
void scan_queued_pages(gc_heap* heap, gc_trace* trace);
void scan_stacked_objects(gc_heap* heap, gc_trace* trace);

bool filter_pointer_exactly(gc_heap* heap, gc_trace* trace, os_pointer ptr);
bool filter_pointer_ambiguously(gc_heap* heap, 
				gc_trace* trace, 
				os_pointer ptr);
bool trace_ambiguous_root(gc_heap* heap, 
			  gc_trace* trace,
			  os_location loc, 
			  os_word data);
bool trace_field(gc_heap* heap,
		 gc_trace* trace,
		 os_location loc, 
		 os_word data);
os_pointer retain_object(gc_heap* heap, 
			 gc_trace* trace, 
			 os_pointer obj);
os_pointer copy_object(gc_heap* heap,
		       gc_trace* trace,
		       os_pointer obj,
		       gc_header header);
os_pointer mark_object(gc_heap* heap,
		       gc_trace* trace,
		       os_pointer obj,
		       gc_header header);

/* gc-compact.c */

typedef bool (*gc_move_func)(gc_heap* heap,
			     os_pointer src,
			     os_pointer dst,
			     os_word len,
			     os_word data);

void initialize_compaction(gc_heap* heap, gc_compaction* cpt);
void finalize_compaction(gc_compaction* cpt);
void iterate_over_moves(gc_heap* heap,
			gc_bit_table* table,
			gc_page_queue* queue,
			gc_move_func move_func,
			os_word data,
			os_pointer src_begin,
			os_pointer src_end,
			os_pointer dst_begin);

void compact_heap(gc_heap* heap, gc_trace* trace, gc_compaction* cpt);
void determine_move_metrics(gc_heap* heap, gc_compaction* cpt);
bool update_metrics_for_move(gc_heap* heap,
			     os_pointer src,
			     os_pointer dst,
			     os_word len,
			     os_word data);
void move_marked_objects(gc_heap* heap, 
			 gc_trace* trace, 
			 gc_compaction* cpt);
bool move_and_fixup_object(gc_heap* heap,
			   os_pointer src,
			   os_pointer dst,
			   os_word len,
			   os_word data);
bool fixup_field(gc_heap* heap,
		 gc_trace* trace,
		 os_location loc, 
		 os_word data);
os_pointer compute_moved_location(gc_heap* heap, 
				  gc_trace* trace,
				  gc_compaction* cpt,
				  os_pointer obj,
				  bool exhaustive);
bool record_moved_location(gc_heap* heap,
			   os_pointer src,
			   os_pointer dst,
			   os_word len,
			   os_word data);
void fixup_unmovable_pages(gc_heap* heap, gc_trace* trace, gc_compaction* cpt);
void promote_movable_pages(gc_heap* heap, gc_trace* trace, gc_compaction* cpt);

const char* test_move_iteration();
bool test_move_callback(gc_heap* heap,
			os_pointer src,
			os_pointer dst,
			os_word len,
			os_word data);
const char* test_compute_moved_location();

/* gc-policy.c */
int choose_zone_count(gc_heap* heap);
void implement_zone_configuration(gc_heap* heap);
void choose_target_zone_step(gc_heap* heap, 
			     gc_page* page, 
			     int* target_zone, 
			     int* target_step);
bool should_trigger_collection(gc_heap* heap);

/* gc-collect.c */
void maybe_start_collection(gc_heap* heap);
void collect(gc_heap* heap, int max_zone);
os_word collect_rest(os_thread_info* info, os_word arg);
void sync_thread_contexts(gc_heap*  heap,
			  os_thread_info* other_info,
			  int other_info_count,
			  os_thread_info* self_info);

/* gc-debug.c */
void give_up(int code);
const char* header_format_name(os_word format);
void print_gc_heap(gc_heap* heap);
void print_gc_page(gc_heap* heap, gc_page* page);
void print_gc_root_area(gc_root_area* area);
void print_gc_header(gc_header header);
void print_object_gc_header(os_pointer obj);
bool should_log(gc_heap* heap);
void create_event_log(gc_heap* heap);
void finalize_event_log(gc_heap* heap);
void log_event(gc_heap* heap, int event, os_pointer object, os_word datum);
void log_event2(gc_heap* heap, int event, const char* fmt, ...);

#endif
