/*
 * os.h
 * Simple multi-OS multi-CPU portability layer.
 */

#ifndef VITAMIN_OS_H
#define VITAMIN_OS_H

#include <stdlib.h>

#define OS_WORD_BITS 64

#define OS_OK 0
#define OS_ERR -1
#define OS_ERR_NO_MEM -2
#define OS_ERR_ARG_INVALID -3
#define OS_ERR_THREAD -4
#define OS_ERR_INFO -5

#define OS_MAX_GPRS 32
#define OS_MAX_RTRS 32

typedef unsigned long os_time;
typedef char* os_pointer;
typedef char** os_location;
typedef unsigned long os_word;

typedef unsigned int os_half;
typedef unsigned char os_byte;

#define OS_MIN_BYTE 0
#define OS_MIN_HALF 0
#define OS_MIN_WORD 0
#define OS_MAX_BYTE 255
#define OS_MAX_HALF 4294967295
#define OS_MAX_WORD 18446744073709551615UL

/*
 * all stack limits are half-open ranges:
 * [stack_low, stack_high) are valid data
 */
typedef struct _os_thread_info {
  int gpr_count;
  os_word gprs[OS_MAX_GPRS];
  int rtr_count;
  os_word rtrs[OS_MAX_RTRS];
  os_pointer stack_low; 
  os_pointer stack_high;
} os_thread_info;

typedef os_word (*os_callback)(os_word arg);
typedef os_word (*os_self_info_callback)(os_thread_info* info, os_word arg);

int os_initialize();
int os_finalize();
int os_map_memory(os_word bytes, os_location ptr);
int os_unmap_memory(os_pointer ptr, os_word bytes);
int os_duplicate_memory(os_pointer ptr, os_word bytes, os_location nptr);
os_word os_enter(os_callback fun, os_word arg);
int os_leave_early();
int os_suspend_other_threads();
int os_resume_other_threads();
int os_other_thread_info(os_thread_info** info_vec, int* count);
os_word os_call_with_self_info(os_self_info_callback fun, os_word arg)
  __attribute__ ((noinline));
void os_set_rtr(os_word rn, os_word value);
os_word os_get_rtr(os_word rn);
os_time os_time_nsec();
void os_exit(int code);

#endif
