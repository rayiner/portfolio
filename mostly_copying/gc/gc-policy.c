/*
 * gc-policy.c
 * Policy implementations for the GC.
 */

#include <stdio.h>
#include "gc.h"
#include "gc-internal.h"

/* choose_* functions should not modify global state! */

int choose_zone_count(gc_heap* heap) {
  switch(heap->policy) {
  case GC_POLICY_NONGEN: 
  case GC_POLICY_NONGEN_MC: 
    return 1;
  case GC_POLICY_APPEL: return 2;
  }

  give_up(GC_ABORT_UNIMPL);
  return 0; /* unreachable */
}

void implement_zone_configuration(gc_heap* heap) {
  switch(heap->policy) {
  case GC_POLICY_NONGEN:
  case GC_POLICY_NONGEN_MC:
    heap->zone_table->type = GC_ZONE_TYPE_GLOBAL;
    heap->zone_table->root = 0;
    heap->zone_table->step_count = 3;
    break;
  case GC_POLICY_APPEL:
    heap->zone_table[0].type = GC_ZONE_TYPE_GLOBAL;
    heap->zone_table[0].root = 0;
    heap->zone_table[0].step_count = 2;
    heap->zone_table[1].type = GC_ZONE_TYPE_GLOBAL;
    heap->zone_table[1].root = 0;
    heap->zone_table[1].step_count = 1;
    break;
  default: give_up(GC_ABORT_UNIMPL);
  }
}

void choose_target_zone_step(gc_heap* heap, 
			     gc_page* page, 
			     int* target_zone, 
			     int* target_step) {
  gc_zone* curr_zone = zone_for_index(heap, page->zone);
  int next_step = page->step + 1;
  int next_zone = page->zone + 1;

  switch(heap->policy) {
  case GC_POLICY_NONGEN:
  case GC_POLICY_NONGEN_MC:
  case GC_POLICY_APPEL:
    if(is_valid_step(curr_zone, next_step)) {
      *target_zone = page->zone;
      *target_step = next_step;
    } else if(is_valid_zone(heap, next_zone)) {
      *target_zone = next_zone;
      *target_step = 0;
    } else {
      *target_zone = page->zone;
      *target_step = page->step;
    }

    break;
  default: give_up(GC_ABORT_UNIMPL);
  }
}

bool should_trigger_collection(gc_heap* heap) {
  switch(heap->policy) {
  case GC_POLICY_NONGEN:
    return (zone_current_size(heap, GC_ZONE_0) >= (heap->heap_size / 2));
  case GC_POLICY_NONGEN_MC:
    return (zone_current_size(heap, GC_ZONE_0) == heap->heap_size);
  }

  give_up(GC_ABORT_UNIMPL);
  return 0; /* unreachable */
}
