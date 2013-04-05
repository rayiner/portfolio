/*
 * gc-object.c
 * Routines for handling formatted objects.
 */

#include "gc-internal.h"

os_word generate_mask(int shift, int bits) {
  return (((1UL << bits) - 1) << shift);
}

os_word extract_field(gc_header h, int shift, int bits) {
  os_word mask = generate_mask(shift, bits);
  return ((h & mask) >> shift);
}

os_word insert_field(gc_header h, int shift, int bits, os_word val) {
  os_word mask = generate_mask(shift, bits);
  return ((h & (!mask)) | ((val << shift) & mask));
}

os_word header_format(gc_header h) {
  return extract_field(h, GC_HEADER_FORMAT_SHIFT, GC_HEADER_FORMAT_BITS);
}

os_word header_trace_status(gc_header h) {
  return extract_field(h, 
		       GC_HEADER_TRACE_STATUS_SHIFT,
		       GC_HEADER_TRACE_STATUS_BITS);
}

gc_header set_header_trace_status(gc_header h) {
  return insert_field(h, 
		      GC_HEADER_TRACE_STATUS_SHIFT,
		      GC_HEADER_TRACE_STATUS_BITS, 
		      1);
}

gc_header clear_header_trace_status(gc_header h) {
  return insert_field(h, 
		      GC_HEADER_TRACE_STATUS_SHIFT,
		      GC_HEADER_TRACE_STATUS_BITS, 
		      0);
}

os_word header_object_barrier(gc_header h) {
  return extract_field(h, 
		       GC_HEADER_OBJECT_BARRIER_SHIFT,
		       GC_HEADER_OBJECT_BARRIER_BITS);
}

gc_header set_header_object_barrier(gc_header h) {
  return insert_field(h, 
		      GC_HEADER_OBJECT_BARRIER_SHIFT,
		      GC_HEADER_OBJECT_BARRIER_BITS, 
		      1);
}

gc_header clear_header_object_barrier(gc_header h) {
  return insert_field(h, 
		      GC_HEADER_OBJECT_BARRIER_SHIFT,
		      GC_HEADER_OBJECT_BARRIER_BITS, 
		      0);
}

os_word header_dense_length(gc_header h) {
  return extract_field(h, 
		       GC_HEADER_DENSE_LENGTH_SHIFT,
		       GC_HEADER_DENSE_LENGTH_BITS);
}

os_word header_simple_length(gc_header h) {
  return extract_field(h, 
		       GC_HEADER_SIMPLE_LENGTH_SHIFT, 
		       GC_HEADER_SIMPLE_LENGTH_BITS);
}

os_word header_simple_bitmap(gc_header h) {
  return extract_field(h, 
		       GC_HEADER_SIMPLE_BITMAP_SHIFT,
		       GC_HEADER_SIMPLE_BITMAP_BITS);
}

os_word header_complex_index(gc_header h) {
  return extract_field(h, 
		       GC_HEADER_COMPLEX_INDEX_SHIFT,
		       GC_HEADER_COMPLEX_INDEX_BITS);
}

gc_header object_header(os_pointer p) {
  return *((gc_header*)p);
}

void update_object_header(os_pointer p, gc_header h) {
  *((gc_header*)p) = h;
}

os_pointer object_slots(os_pointer p) {
  return advance_by_word(p);
}

os_pointer object_forwarding_pointer(os_pointer p) {
  return *((os_pointer*)advance_by_word(p));
}

void update_object_forwarding_pointer(os_pointer p, os_pointer newp) {
  *((os_pointer*)advance_by_word(p)) = newp;
}

os_word object_length(os_pointer p) {
  return object_length_from_header(object_header(p));
}

os_word object_length_from_header(gc_header h) {
  os_word format = header_format(h);
  switch(format) {
  case GC_HEADER_FORMAT_POINTER_FREE:
  case GC_HEADER_FORMAT_POINTER_FULL:
    return sizeof(gc_header) + words_to_bytes(header_dense_length(h));
  case GC_HEADER_FORMAT_SIMPLE:
    return sizeof(gc_header) + words_to_bytes(header_simple_length(h));
  }

  give_up(GC_ABORT_UNIMPL);
  return 0;  /* unreachable */
}

bool is_object_format_pointer_free(gc_header h) {
  return (header_format(h) == GC_HEADER_FORMAT_POINTER_FREE);
}
