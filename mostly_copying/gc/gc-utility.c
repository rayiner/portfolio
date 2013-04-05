/*
 * gc-utility.c
 * Utility routines.
 */

#include <assert.h>
#include <math.h>
#include <stdbool.h>
#include <string.h>
#include "gc-internal.h"

#if GC_PAGE_SIZE < 1024
#define BIG_OBJ_SIZE 25
#else
#define BIG_OBJ_SIZE 100
#endif

long g_fake_obj_table[] = {5, BIG_OBJ_SIZE, /* 0 */
			   120, 4,
			   175, 5, /* 1 */
			   190, 2, 
			   256, 3, /* 2 */
			   379, 5,
			   384, 3, /* 3 */
			   510, 2,  
			   520, 10, /* 4 */
			   530, 10,
			   641, 15, /* 5 */
			   770, 10, /* 6 */
			   900, 15}; /* 7 */

os_word bytes_to_pages(os_word bytes) {
  os_word pages = bytes / GC_PAGE_SIZE;
  if(bytes % GC_PAGE_SIZE != 0)
    ++pages;
  return pages;
}

os_word round_bytes_to_page_size(os_word bytes) {
  return GC_PAGE_SIZE * bytes_to_pages(bytes);
}

os_word bytes_to_words(os_word bytes) {
  os_word words = bytes / sizeof(os_word);
  if(bytes % sizeof(os_word) != 0)
    ++words;
  return words;
}

os_word words_to_bytes(os_word words) {
  return words * sizeof(os_word);
}

os_word bits_to_words(os_word bits) {
  os_word words = bits / OS_WORD_BITS;
  if(words % sizeof(os_word) != 0)
    ++words;
  return words;
}

os_word words_to_bits(os_word words) {
  return words * OS_WORD_BITS;
}

os_word min(os_word a, os_word b) {
  return (a < b) ? a : b;
}

os_word max(os_word a, os_word b) {
  return (a > b) ? a : b;
}

os_pointer pmin(os_pointer a, os_pointer b) {
  return (a < b) ? a : b;
}

os_pointer pmax(os_pointer a, os_pointer b) {
  return (a > b) ? a : b;
}

os_pointer por(os_pointer a, os_pointer b) {
  if(a)
    return a;
  return b;
}

os_pointer advance_by_word(os_pointer p) {
  return p + sizeof(os_word);
}

bool is_pointer_word_aligned(os_pointer p) {
  return ((os_word)p % sizeof(os_word) == 0);
}

/* pointer lists */

void initialize_list(gc_list* list) {
  list->entry_count = 0;
  list->highest_entry = 0;
  list->max_entry_count = 8;
  list->list_entries = 
    (os_pointer*)calloc(list->max_entry_count, sizeof(os_pointer));
}

void finalize_list(gc_list* list) {
  free(list->list_entries);
}

void append_item(os_pointer item, gc_list* list) {
  assert(item);

  if(list->highest_entry == list->max_entry_count) {
    list->max_entry_count *= 2;
    list->list_entries = 
      (os_pointer*)reallocf(list->list_entries, 
			    sizeof(os_pointer)*list->max_entry_count);
  }

  list->list_entries[list->highest_entry] = item;
  ++list->highest_entry;
  ++list->entry_count;
}

void begin_list_iteration(gc_list* list, gc_list_iterator* itr) {
  itr->list = list;
  itr->current = list->list_entries;
  itr->limit = list->list_entries + list->highest_entry;

  advance_to_valid_item(itr);
}

os_pointer current_item(gc_list_iterator* itr) {
  if(itr->current == itr->limit) {
    return 0;
  }

  assert(*itr->current);

  return *itr->current;
}

void advance_item(gc_list_iterator* itr) {
  assert(itr->current != itr->limit);

  ++itr->current;
  advance_to_valid_item(itr);
}

void advance_to_valid_item(gc_list_iterator* itr) {
  while((itr->current != itr->limit)
	&& !(*itr->current)) {
    ++itr->current;
  }
}

void remove_item(gc_list_iterator* itr) {
  if(*itr->current) {
    *itr->current = 0;
    --itr->list->entry_count;
  }
}

void compact_list(gc_list* list) {
  os_pointer* new_entries = 
    (os_pointer*)calloc(list->max_entry_count, sizeof(os_pointer*));
  os_pointer* fill = new_entries;
  os_pointer* iterator = list->list_entries;
  os_pointer* limit = list->list_entries + list->max_entry_count;
  
  while(iterator != limit) {
    if(*iterator) {
      *fill = *iterator;
      ++fill;
    }
    ++iterator;
  }

  assert((fill - new_entries) == list->entry_count);

  list->highest_entry = list->entry_count;

  printf("Compacting\n");

  free(list->list_entries);
  list->list_entries = new_entries;
}

/* bit tables */

void initialize_bit_table(gc_bit_table* table, long bit_count) {
  table->bits = (os_word*)calloc(bits_to_words(bit_count), sizeof(os_word));
  table->bit_count = bit_count;
}

void finalize_bit_table(gc_bit_table* table) {
  free(table->bits);
}

void set_bit(gc_bit_table* table, long idx) {
  assert(idx < table->bit_count);

  long word_idx = idx / OS_WORD_BITS;
  long word_off = idx % OS_WORD_BITS;
  table->bits[word_idx] |= (1UL << word_off);
}

void clear_bit(gc_bit_table* table, long idx) {
  assert(idx < table->bit_count);

  long word_idx = idx / OS_WORD_BITS;
  long word_off = idx % OS_WORD_BITS;
  table->bits[word_idx] &= ~(1UL << word_off);
}

bool is_bit_set(gc_bit_table* table, long idx) {
  assert(idx < table->bit_count);

  long word_idx = idx / OS_WORD_BITS;
  long word_off = idx % OS_WORD_BITS;
  return (table->bits[word_idx] & (1UL << word_off)) != 0;
}

void clear_run(gc_bit_table* table, long start, long len) {
  if((start % OS_WORD_BITS == 0) && (len % OS_WORD_BITS == 0)) {
    long word_idx = start / OS_WORD_BITS;
    long word_run = len / OS_WORD_BITS;

    for(long idx = word_idx; idx < (word_idx + word_run); ++idx) {
      table->bits[idx] = 0;
    }
  } else {
    for(long idx = start; idx < (start + len); ++idx)
      clear_bit(table, idx);
  }
}

void clear_bit_table(gc_bit_table* table) {
  os_word table_bytes = bits_to_words(table->bit_count) * sizeof(os_word);
  memset(table->bits, 0, table_bytes);
}

long find_first_set_bit(gc_bit_table* table, long start, long end) {
  for(long i = start; i < end; ++i) 
    if(is_bit_set(table, i)) return i;
  return -1;
}

void begin_run_iteration(gc_bit_table* table,
			 gc_bit_run_iterator* itr,
			 long start,
			 long end) {
  itr->table = table;
  itr->current_index = start;
  itr->end_index = end;
}

bool find_next_run(gc_bit_run_iterator* itr,
		   long* start,
		   long* len) {
  long run_start = find_first_set_bit(itr->table, 
				      itr->current_index,
				      itr->end_index);

  if((run_start < 0) || ((run_start + 1) == itr->end_index))
    return false;

  long run_end = find_first_set_bit(itr->table,
				    run_start + 1,
				    itr->end_index);

  if(run_end < 0) return false;

  itr->current_index = min(run_end + 1, itr->end_index);

  *start = run_start;
  *len = (run_end - run_start + 1);
  return true;
}   

void move_run_iterator(gc_bit_run_iterator* itr, long curr) {
  itr->current_index = curr;
}

/* object stacks */

void initialize_object_stack(gc_object_stack* stack, int stack_elems) {
  stack->stack_low = (os_location)calloc(stack_elems, sizeof(os_pointer));
  stack->stack_high = stack->stack_low + stack_elems * sizeof(os_pointer);
  stack->stack_top = stack->stack_low;
}

void finalize_object_stack(gc_object_stack* stack) {
  free(stack->stack_low);
}

void push_object(os_pointer ptr, gc_object_stack* stack) {
  assert(stack->stack_top != stack->stack_high);

  *stack->stack_top = ptr;
  ++stack->stack_top;
}

os_pointer pop_object(gc_object_stack* stack) {
  assert(stack->stack_top != stack->stack_low);

  --stack->stack_top;
  return *stack->stack_top;
}

bool is_object_stack_empty(gc_object_stack* stack) {
  return stack->stack_top == stack->stack_low;
}

/* page queues */

os_half null_link() {
  return OS_MAX_HALF;
}

bool is_link_null(os_half link) {
  return (link == null_link());
}

gc_page* page_for_link(gc_page_queue* queue, os_half link) {
  if(!is_link_null(link))
    return queue->page_table + link;
  return 0;
}

os_half link_for_page(gc_page_queue* queue, gc_page* page) {
  if(page)
    return page - queue->page_table;
  return null_link();
}

void initialize_page_queue(gc_page* table, gc_page_queue* queue) {
  queue->page_table = table;
  queue->queue_head = 0;
  queue->queue_tail = 0;
}

void queue_page(gc_page* page, gc_page_queue* queue) {
  assert(is_link_null(page->link));

  if(!queue->queue_tail)
    queue->queue_head = queue->queue_tail = page;
  else {
    queue->queue_tail->link = link_for_page(queue, page);
    queue->queue_tail = page;
  }
}

gc_page* dequeue_page(gc_page_queue* queue) {
  assert(queue->queue_head);

  gc_page* page = queue->queue_head;

  queue->queue_head = page_for_link(queue, page->link);

  if(queue->queue_tail == page)
    queue->queue_tail = 0;

  page->link = null_link();

  return page;
}

gc_page* page_queue_head(gc_page_queue* queue) {
  return queue->queue_head;
}

gc_page* next_queued_page(gc_page_queue* queue, gc_page* page) {
  return page_for_link(queue, page->link);
}

bool is_page_queue_empty(gc_page_queue* queue) {
  return queue->queue_head == 0;
}

/* page caches */

void initialize_page_cache(gc_page_cache* cache, int entries, gc_space space) {
  cache->index_mask = (1 << lround(ceil(log2(entries)))) - 1;
  cache->entry_count = entries;
  cache->cache_entries = (gc_page**)calloc(entries, sizeof(gc_page*));
  cache->age_counter = 0; 
  cache->entry_ages = (os_word*)calloc(entries, sizeof(os_word));
  cache->hint_index = 0;
  cache->space = space;
}

void finalize_page_cache(gc_page_cache* cache) {
  free(cache->cache_entries);
  free(cache->entry_ages);
}

bool does_page_match(gc_page* page, 
		     os_word bytes, 
		     gc_space space,
		     int zone, 
		     int step) {
  return page 
    && is_page_in_state(page, space, zone, step) 
    && (free_bytes_in_page(page) >= bytes);
}

gc_page* cache_page(gc_page_cache* cache, gc_page* page) {
  assert(page->space == cache->space);

  int candidate = 0;
  for(int i = 0; i < cache->entry_count; ++i) {
    if(cache->entry_ages[i] < cache->entry_ages[candidate])
      candidate = i;
  }

  gc_page* evicted = cache->cache_entries[candidate];
  cache->cache_entries[candidate] = page;
  cache->entry_ages[candidate] = ++cache->age_counter;
  
  return evicted;
}

gc_page* lookup_page(gc_page_cache* cache, os_word bytes, int zone, int step) {
  int index = cache->hint_index;
  do {
    if(does_page_match(cache->cache_entries[index],
		       bytes,
		       cache->space,
		       zone,
		       step)) {
      gc_page* page = cache->cache_entries[index];
      cache->entry_ages[index] = ++cache->age_counter;
      cache->hint_index = index;

      if(page && will_allocation_fill_page(page, bytes)) {
	cache->entry_ages[index] = 0;
      }

      return page;
    }

    index = (index + 1) & cache->index_mask;
  } while(index != cache->hint_index);

  return 0;
}

void flush_page_cache(gc_page_cache* cache, void (*finalizer)(gc_page* page)) {
  for(int i = 0; i < cache->entry_count; ++i) {
    if(cache->cache_entries[i]) {
      if(finalizer) 
	finalizer(cache->cache_entries[i]);
      cache->cache_entries[i] = 0;
      cache->entry_ages[i] = 0;
    }
  }

  cache->hint_index = 0;
}

/* memory iterators */

void begin_memory_iteration_on_page(gc_heap* heap,
				    gc_page* page,
				    gc_memory_iterator* itr,
				    os_pointer start,
				    os_pointer end) {
  os_pointer page_base = pointer_for_page(heap, page);
  os_pointer page_limit = page_base + GC_PAGE_SIZE;

  itr->current_point = por(start, pointer_for_page(heap, page));
  itr->limit_point = por(pmin(end, page_limit), page_limit);
  itr->current_page = page;
}

void begin_memory_iteration(gc_heap* heap,
			    gc_page_queue* queue,
			    gc_memory_iterator* itr,
			    os_pointer start,
			    os_pointer end) {
  itr->heap = heap;
  itr->queue = queue;

  gc_page* page = 0;

  if(start)
    page = page_for_pointer(heap, start);
  else
    page = page_queue_head(queue);
  
  assert(page);

  begin_memory_iteration_on_page(heap, page, itr, start, end);

  itr->final_point = end;
}

os_pointer current_point(gc_memory_iterator* itr) {
  return itr->current_point;
}

os_pointer advance_point(gc_memory_iterator* itr, os_word bytes, bool contig) {
  assert(bytes <= GC_PAGE_SIZE);

  os_pointer result = itr->current_point;

  if((itr->current_point + bytes) > itr->limit_point) {
    gc_page* next_page = next_queued_page(itr->queue, itr->current_page);

    if(!next_page) return 0;

    os_word remainder = itr->limit_point - itr->current_point;

    begin_memory_iteration_on_page(itr->heap, 
				   next_page, 
				   itr, 
				   0, 
				   itr->final_point);
    if(!remainder || contig) {
      result = itr->current_point;
    } else {
      bytes -= remainder;
    }
  }

  itr->current_point += bytes;

  return result;
}

/* mark table iterators */

void begin_bit_run_iteration_on_page(gc_heap* heap,
				     gc_bit_table* table,
				     gc_bit_run_iterator* itr,
				     os_pointer start,
				     os_pointer end) {
  gc_page* page = page_for_pointer(heap, start);
  os_pointer base = pointer_for_page(heap, page);
  os_pointer limit = end ? pmin(base + GC_PAGE_SIZE, end) : base + GC_PAGE_SIZE;

  long start_idx = bytes_to_words(start - heap->heap_memory);
  long limit_idx = bytes_to_words(limit - heap->heap_memory);

  begin_run_iteration(table, itr, start_idx, limit_idx);
}

void begin_mark_table_iteration(gc_heap* heap,
				gc_page_queue* queue,
				gc_bit_table* table,
				gc_mark_table_iterator* itr,
				os_pointer start,
				os_pointer end) {
  itr->heap = heap;
  itr->queue = queue;
  itr->table = table;

  if(start)
    itr->current_point = start;
  else {
    gc_page* page = page_queue_head(queue);

    assert(page);

    itr->current_point = pointer_for_page(heap, page);
  }

  itr->final_point = end;

  begin_bit_run_iteration_on_page(heap, 
				  table, 
				  &itr->bit_itr, 
				  itr->current_point, 
				  itr->final_point);
}

bool find_next_marked_object(gc_mark_table_iterator* itr,
			     os_pointer* obj,
			     os_word* obj_len) {
  long obj_start = 0;
  long obj_len_words = 0;

  while(!find_next_run(&itr->bit_itr, &obj_start, &obj_len_words)) {
    gc_page* page = page_for_pointer(itr->heap, itr->current_point);
    gc_page* next_page = next_queued_page(itr->queue, page);

    if(!next_page) return false;

    itr->current_point = pointer_for_page(itr->heap, next_page);
    
    begin_bit_run_iteration_on_page(itr->heap,
				    itr->table,
				    &itr->bit_itr,
				    itr->current_point,
				    itr->final_point);
  }

  *obj = itr->heap->heap_memory + words_to_bytes(obj_start);
  *obj_len = words_to_bytes(obj_len_words);

  return true;
}

/* unit tests */

void populate_bit_table(gc_bit_table* table, long* objects, int count) {
  for(int i = 0; i < count; i += 2) {
    set_bit(table, objects[i]);
    set_bit(table, objects[i] + objects[i+1] - 1);
  }
}

void queue_even_pages(gc_heap* heap, gc_page_queue* queue) {
  int page_count = heap->heap_size / GC_PAGE_SIZE;
  initialize_page_queue(heap->page_table, queue);

  for(int i = 0; i < page_count; ++i) {
    if((i % 2) == 0) {
      queue_page(&heap->page_table[i], queue);
    }
  }
}

const char* test_list() {
  gc_list list;

  initialize_list(&list);

  for(long i = 1; i < 17; ++i)
    append_item((os_pointer)i, &list);

  gc_list_iterator itr;
  begin_list_iteration(&list, &itr);

  os_pointer item = 0;
  long expected = 1;
  while((item = current_item(&itr))) {
    if((long)item != expected)
      return "append item failed";
    if((long)item % 2 == 0 || (long)item < 7)
      remove_item(&itr);
    advance_item(&itr);
    ++expected;
  }

  for(long i = 16; i < 19; ++i)
    append_item((os_pointer)i, &list);

  long expected2[] = {7, 9, 11, 13, 15, 16, 17, 18};
  int expected2_idx = 0;

  begin_list_iteration(&list, &itr);
  while((item = current_item(&itr))) {
    if((long)item != expected2[expected2_idx++])
      return "remove item failed";
    advance_item(&itr);
  }

  finalize_list(&list);

  return "passed";
}

const char* test_bit_table() {
  gc_bit_table table;

  initialize_bit_table(&table, 1023);
  if(table.bit_count != 1023) return "initialize failed";

  set_bit(&table, 67);
  if(table.bits[1] != 0x8) return "set bit 1 failed";

  set_bit(&table, 68);
  if(table.bits[1] != 0x18) return "set bit 2 failed";

  clear_bit(&table, 67);
  if(table.bits[1] != 0x10) return "clear bit 1 failed";

  set_bit(&table, 64);
  set_bit(&table, 63);
  if(table.bits[0] != 9223372036854775808UL
     || table.bits[1] != 0x11) {
    return "set bit 3 failed";
  }

  if(!is_bit_set(&table, 63)) return "get bit 1 failed";
  if(!is_bit_set(&table, 64)) return "get bit 2 failed";
  if(!is_bit_set(&table, 68)) return "get bit 3 failed";

  if(find_first_set_bit(&table, 0, 1023) != 63)
    return "find first set bit 1 failed";

  if(find_first_set_bit(&table, 64, 1023) != 64)
    return "find first set bit 2 failed";

  if(find_first_set_bit(&table, 65, 1023) != 68)
    return "find first set bit 3 failed";

  set_bit(&table, 73);

  // at this point, 63, 64, 68, and 73 are set
  long start_table[] = {63, 68};
  long len_table[] = {2, 6};

  gc_bit_run_iterator itr;
  begin_run_iteration(&table, &itr, 0, 100);

  long start = 0;
  long len = 0;
  long idx = 0;

  while(find_next_run(&itr, &start, &len)) {
    if((start != start_table[idx]) || (len != len_table[idx]))
      return "run iteration 1 failed";
    ++idx;
  }

  for(int i = 256; i < 768; ++i)
    set_bit(&table, i);

  clear_run(&table, 320, 128);
  clear_run(&table, 450, 200);

  for(int i = 256; i < 768; ++i) {
    if(i >= 256 && i < 320 && !is_bit_set(&table, i)) 
      return "clear run 1 failed";

    if(i >= 320 && i < 448 && is_bit_set(&table, i)) 
      return "clear run 1 failed";

    if(i >= 448 && i < 450 && !is_bit_set(&table, i)) 
      return "clear run 1 failed";

    if(i >= 450 && i < 650 && is_bit_set(&table, i)) 
      return "clear run 2 failed";

    if(i >= 650 && !is_bit_set(&table, i)) 
      return "clear run 2 failed";
  }

  finalize_bit_table(&table);
  
  return "passed";
}

const char* test_object_stack() {
  gc_object_stack stack;

  os_pointer pa = (os_pointer)0xABCDABCDABCDABCD;
  os_pointer pb = (os_pointer)0x1337133713371337;

  initialize_object_stack(&stack, 10);

  push_object(pa, &stack);
  if(stack.stack_low[0] != pa) return "push 1 failed";

  push_object(pb, &stack);
  if(stack.stack_low[1] != pb) return "push 2 failed";

  if(pop_object(&stack) != pb) return "pop 1 failed";

  if(is_object_stack_empty(&stack)) return "is empty 1 failed";

  if(pop_object(&stack) != pa) return "pop 2 failed";

  if(!is_object_stack_empty(&stack)) return "is empty 2 failed";

  finalize_object_stack(&stack);

  return "passed";
}

const char* test_page_cache() {
  gc_page_cache cache;
  initialize_page_cache(&cache, 16, 0);
  gc_page pages[32];
  for(int i = 0; i < 32; ++i) {
    pages[i].fill = GC_PAGE_SIZE - 512;
    pages[i].space = 0;
    pages[i].zone = i;
    pages[i].step = 0;
  }

  for(int i = 0; i < 16; ++i) {
    cache_page(&cache, &pages[i]);
  }

  int sum = 0;
  for(int i = 0; i < 16; ++i)
    sum += cache.cache_entries[i]->zone;

  if(sum != 120) return "cache 1 failed";

  for(int i = 16; i < 32; ++i) {
    if(cache_page(&cache, &pages[i])->zone != (i - 16))
      return "cache 2 failed";
  }

  sum = 0;
  for(int i = 0; i < 16; ++i) {
    sum += cache.cache_entries[i]->zone;
  }

  if(sum != 376) return "cache 3 failed";

  gc_page* page = lookup_page(&cache, 200, 19, 0);
  if(page->zone != 19) return "lookup 1 failed";

  if(cache.cache_entries[cache.hint_index]->zone != 19)
    return "lookup 2 failed";

  page = lookup_page(&cache, 200, 5, 0);
  if(page != 0) return "lookup 3 failed";

  page = lookup_page(&cache, 700, 21, 0);
  if(page != 0) return "lookup 4 failed";

  page = lookup_page(&cache, 200, 21, 0);
  if(page->zone != 21) return "lookup 5 failed";
  
  if(cache.cache_entries[cache.hint_index]->zone != 21)
    return "lookup 6 failed";

  finalize_page_cache(&cache);

  return "passed";
}

const char* test_memory_iterator() {
  gc_heap* heap = gc_make_heap(16 * GC_PAGE_SIZE, GC_POLICY_NONGEN, false);
 
  gc_page_queue queue;
  queue_even_pages(heap, &queue);

  gc_memory_iterator itr;
  begin_memory_iteration(heap, &queue, &itr, heap->heap_memory, 0);
  do {
  } while(advance_point(&itr, 32, true));

  os_pointer expected_point 
    = heap->heap_memory + heap->heap_size - GC_PAGE_SIZE;

  if(current_point(&itr) != expected_point) 
    return "advance 1 failed";

  os_word expected_offset = 100;

  begin_memory_iteration(heap, &queue, &itr, heap->heap_memory + 100, 0);
  do {
    os_pointer current_pointer = current_point(&itr);
    os_word current_offset = current_pointer - heap->heap_memory;

    if(current_offset != expected_offset)
      return "advance 2 failed";

    if(((expected_offset + 500) / GC_PAGE_SIZE) 
       != (expected_offset / GC_PAGE_SIZE)) {
      expected_offset += (GC_PAGE_SIZE - expected_offset % GC_PAGE_SIZE);
      expected_offset += GC_PAGE_SIZE;
    }
    
    expected_offset += 500;
  } while(advance_point(&itr, 500, true));

  expected_offset = 100;
  os_word increment = 500;

  begin_memory_iteration(heap, &queue, &itr, heap->heap_memory, 0);
  do {
    increment = 500;

    if(((expected_offset + 500) / GC_PAGE_SIZE) 
       != (expected_offset / GC_PAGE_SIZE)) {
      os_word remainder = GC_PAGE_SIZE - expected_offset % GC_PAGE_SIZE;
      expected_offset += remainder;
      increment -= remainder;
      expected_offset += GC_PAGE_SIZE;
    }
  } while(advance_point(&itr, increment, false));

  gc_destroy_heap(heap);

  return "passed";
}

const char* test_mark_table_iterator() {
  gc_heap* heap = gc_make_heap(8192, GC_POLICY_NONGEN, false);
  populate_bit_table(&heap->mark_table, 
		     g_fake_obj_table, 
		     GC_FAKE_OBJ_TABLE_LENGTH);

  gc_page_queue queue;
  queue_even_pages(heap, &queue);

  gc_mark_table_iterator itr;
  begin_mark_table_iteration(heap, 
			     &queue, 
			     &heap->mark_table,
			     &itr,
			     heap->heap_memory,
			     heap->heap_memory + words_to_bytes(779));
  
  os_pointer obj_base = 0;
  os_word obj_len;

  while(find_next_marked_object(&itr, &obj_base, &obj_len)) {
    long obj_offt = bytes_to_words(obj_base - heap->heap_memory);
    long obj_len_words = bytes_to_words(obj_len);
    long page_idx = obj_offt / bytes_to_words(GC_PAGE_SIZE);

    if(page_idx % 2 != 0)
      return "find next marked object base failed";

    int i = 0;
    while((i < GC_FAKE_OBJ_TABLE_LENGTH) && (g_fake_obj_table[i] != obj_offt)) 
      i += 2;

    if(i == GC_FAKE_OBJ_TABLE_LENGTH)
      return "find next marked object base failed";

    if((obj_offt + obj_len_words) > 779)
      return "find next marked object base failed";

    if(g_fake_obj_table[i + 1] != obj_len_words)
      return "find next marked object length failed";
  }

  gc_destroy_heap(heap);

  return "passed";
}
