/*
 * os-test.c
 * Simple test of the portability layer
 */

#include <stdio.h>
#include <stdlib.h>
#include "os.h"
#include <pthread.h>
#include <unistd.h>

#define TEST_ALLOC_BYTES 91136

os_word stupid_fun(os_word data) {
  printf("Thread %ld start!\n", data);
  os_set_rtr(0, data);
  long sum = 1;
  while(sum > 0) {
    if(sum % 1000000 == 0)
      usleep(1);
    ++sum;
  }
  printf("Thread stop\n");

  return sum;
}

void* stupid_thread(void* data) {
  os_enter(stupid_fun, (os_word)data);
  return 0;
}

os_word print_self_info(os_thread_info* info, os_word arg) {
  printf("Self stack: %p %p\n", info->stack_low, info->stack_high);
  os_word* temp = (os_word*)info->stack_low;
  while(temp != (os_word*)info->stack_high) {
    printf("Self stack word: %ld\n", *temp);
    ++temp;
  }
  printf("Self RTR: %ld\n", info->rtrs[0]);

  return 0;
}

os_word do_test(os_word arg) {
  char* bytes = 0;
  int ret = 0;
  if((ret = os_map_memory(TEST_ALLOC_BYTES, (os_location)&bytes)) != OS_OK) {
    printf("Could not allocate memory, code = %d\n", ret);
    return -1;
  }

  printf("Allocated %d bytes at %p\n", TEST_ALLOC_BYTES, bytes);

  for(int i = 0; i < TEST_ALLOC_BYTES; ++i) {
    bytes[i] = i & 0xF;
  }

  for(int i = 0; i < TEST_ALLOC_BYTES; ++i) {
    if(bytes[i] != (i & 0xF)) {
      printf("Memory could not be reread correctly\n");
      return -1;
    }
  }

  char* nbytes = 0;
  if((ret = os_duplicate_memory(bytes, 
				TEST_ALLOC_BYTES, 
				(os_location)&nbytes)) != OS_OK) {
    printf("Could not duplicate memory, code = %d\n", ret);
    return -1;
  }

  printf("Duplicated %d bytes at %p\n", TEST_ALLOC_BYTES, nbytes);

  for(int i = 0; i < TEST_ALLOC_BYTES; ++i) {
    if(nbytes[i] != (i & 0xF)) {
      printf("Duplicated memory could not be reread correctly\n");
      return -1;
    }
  }

  if((ret = os_unmap_memory(bytes, TEST_ALLOC_BYTES)) != OS_OK) {
    printf("Failed to deallocate memory, code = %d\n", ret);
    return -1;
  }

  if((ret = os_unmap_memory(nbytes, TEST_ALLOC_BYTES)) != OS_OK) {
    printf("Failed to deallocate duplicated memory, code = %d\n", ret);
    return -1;
  }

  os_set_rtr(0, 1337);

  pthread_t thread;
  for(int i = 0; i < 8; ++i) {
    os_word wi = i;
    pthread_create(&thread, 0, stupid_thread, (void*)wi);
  }

  sleep(1);
  
  os_suspend_other_threads();
  os_thread_info* info = 0;
  int info_count;
  if((ret = os_other_thread_info(&info, &info_count)) < 0) {
    printf("Could not get thread info, code = %d\n", ret);
  }

  for(int i = 0; i < info_count; ++i) {
    printf("Thread %d RSP = %ld\n", i, info[i].gprs[7]);
    printf("Thread %d RTR = %ld\n", i, info[i].rtrs[0]);
  }
  free(info);
  os_resume_other_threads();

  os_time before = os_time_nsec();
  for(int i = 0; i < 10; ++i) {
    os_suspend_other_threads();
    os_resume_other_threads();
  }
  os_time after = os_time_nsec();
  printf("Took %lu nsec\n", after - before);

  os_call_with_self_info(print_self_info, 0);

  printf("Tests passed\n");

  return 0;
}


int main() {
  if(os_initialize() < 0) {
    printf("Could not initialize\n");
    return -1;
  }

  os_enter(do_test, 0);

  if(os_finalize() < 0) {
    printf("Could not finalize\n");
    return -1;
  }

  return 0;
}
  
  
