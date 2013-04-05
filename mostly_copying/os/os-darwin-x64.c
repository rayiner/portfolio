/*
 * os-darwin-x64.c
 * Implementation of portability layer for Darwin 10.5 on x86-64.
 */

#include <sys/mman.h>
#include <sys/types.h>
#include <mach/vm_map.h>
#include <mach/mach.h>
#include <mach/mach_interface.h>
#include <mach/mach_time.h>

#include <pthread.h>
#include <errno.h>
#include <stdio.h>
#include "os.h"

/*
 * Darwin-x64 follows the SysV x86-64 ABI. Callee-save GPRs are:
 *   rbx, rbp, r12, r13, r14, and r15.
 * The stack register %rsp points to a valid stack item. The ABI specifies a
 * red-zone of 128-bytes below the stack pointer, so in general, the stack
 * extents are: [rsp - 128, stack_high)
 */

#define STACK_MAGIC 0xBADC0FFEE0DDF00D /* mark upper end of stack */
#define PTHREAD_KEY_BASE 256    /* first user pthread key */
#define PTHREAD_TLS_BASE 0x60   /* offset of TLS area in pthread struct */
#define X64_RED_ZONE 128        /* bytes of red-zone beyond stack poiner */

typedef struct _os_darwin_x64_thread_info {
  thread_t thread_id;
  os_pointer stack_high;
  os_pointer rtr_area;
  struct _os_darwin_x64_thread_info* link;
} os_darwin_x64_thread_info;

static mach_timebase_info_data_t g_timebase;
static os_darwin_x64_thread_info* g_thread_info;
static pthread_mutex_t g_thread_info_lock;

int os_initialize() {
  int ret = OS_OK;

  mach_timebase_info(&g_timebase);

  if(pthread_mutex_init(&g_thread_info_lock, 0) < 0) {
    ret = OS_ERR_NO_MEM;
    goto exit;
  }

  /* reserve the first 32 pthread keys so nobody else uses them */
  for(int i = 0; i < OS_MAX_RTRS; ++i) {
    pthread_key_t key;
    pthread_key_create(&key, 0);
    if(key != (PTHREAD_KEY_BASE + i)) {
      ret = OS_ERR_THREAD;
      goto exit;
    }
  }

 exit:
  if(ret != OS_OK) {
    pthread_mutex_destroy(&g_thread_info_lock);
  }

  return ret;
}

int os_finalize() {
  pthread_mutex_destroy(&g_thread_info_lock);

  for(int i = 0; i < OS_MAX_RTRS; ++i)
    pthread_key_delete((pthread_key_t)(i + PTHREAD_KEY_BASE));

  return OS_OK;
}

int os_map_memory(os_word bytes, os_location ptr) {
  vm_address_t addr;
  kern_return_t ret = vm_allocate(mach_task_self(), &addr, bytes, TRUE);

  if(ret != KERN_SUCCESS) {
    switch(ret) {
    case KERN_INVALID_ADDRESS: return OS_ERR_ARG_INVALID;
    case KERN_NO_SPACE: return OS_ERR_NO_MEM;
    default: return OS_ERR;
    }
  }

  *ptr = (void*)addr;
  return OS_OK;
}

int os_unmap_memory(os_pointer ptr, os_word bytes) {
  kern_return_t ret = vm_deallocate(mach_task_self(), (vm_address_t)ptr, bytes);
  
  if(ret != KERN_SUCCESS) {
    switch(ret) {
    case KERN_INVALID_ADDRESS: return OS_ERR_ARG_INVALID;
    default: return OS_ERR;
    }
  }

  return OS_OK;
}

int os_duplicate_memory(os_pointer ptr, os_word bytes, os_location nptr) {
  int ret = OS_OK;

  os_pointer dest_osp = 0;
  if((ret = os_map_memory(bytes, &dest_osp)) != OS_OK)
    goto exit;

  kern_return_t osret = vm_copy(mach_task_self(),
				(vm_address_t)ptr,
				bytes,
				(vm_address_t)dest_osp);

  if(osret != KERN_SUCCESS) {
    switch(osret) {
    case KERN_PROTECTION_FAILURE: 
    case KERN_INVALID_ADDRESS:
      ret = OS_ERR_ARG_INVALID;
      break;
    default: ret = OS_ERR; break;
    }
  }

 exit:
  if(ret != OS_OK) {
    os_unmap_memory(dest_osp, bytes);
  }

  *nptr = dest_osp;

  return ret;
}

static void remember_thread_info(os_darwin_x64_thread_info* info) {
  pthread_mutex_lock(&g_thread_info_lock);

  info->link = g_thread_info;
  g_thread_info = info;

  pthread_mutex_unlock(&g_thread_info_lock);
}

static os_darwin_x64_thread_info* find_thread_info(thread_t thread) {
  pthread_mutex_lock(&g_thread_info_lock);

  os_darwin_x64_thread_info* info = g_thread_info;
  while(info && info->thread_id != thread)
    info = info->link;

  pthread_mutex_unlock(&g_thread_info_lock);
  
  return info;
}

static void forget_thread_info(os_darwin_x64_thread_info* info) {
  pthread_mutex_lock(&g_thread_info_lock);

  os_darwin_x64_thread_info* curr = g_thread_info;
  os_darwin_x64_thread_info* prev = 0;

  while(curr && curr != info)
    curr = curr->link;

  if(curr) {
    if(prev)
      prev->link = curr->link;
    else
      g_thread_info = curr->link;
  }

  pthread_mutex_unlock(&g_thread_info_lock);
}

os_word os_enter(os_callback fun, os_word arg) {
  os_darwin_x64_thread_info info;
  unsigned long magic = STACK_MAGIC;
  info.thread_id = mach_thread_self();
  info.stack_high = (os_pointer)&magic;
  info.rtr_area = ((os_pointer)pthread_self()
		   + PTHREAD_TLS_BASE
		   + (PTHREAD_KEY_BASE * sizeof(os_word)));
  
  remember_thread_info(&info);
  os_word result = fun(arg);
  forget_thread_info(&info);
  
  return result;
} 

int os_leave_early() {
  thread_t self = mach_thread_self();
  os_darwin_x64_thread_info* info = find_thread_info(self);

  if(!info)
    return OS_ERR_THREAD;

  forget_thread_info(info);

  return OS_OK;
} 

/*
 * Note that the thread_info lock enforces a consistent view of the thread list
 * during task suspension. This function holds the lock while scanning the list.
 * Any thread inside the runtime must have (atomically) added itself to the list
 * already, and will be stopped. Any thread not on the list will not have made
 * it through the trampoline yet, and will not need to be stopped.
 */
int os_suspend_other_threads() {
  int osret = OS_OK;
  thread_t self = mach_thread_self();

  pthread_mutex_lock(&g_thread_info_lock);

  os_darwin_x64_thread_info* info = g_thread_info;

  while(info) {
    if(info->thread_id != self) {

      kern_return_t ret = thread_suspend(info->thread_id);

      if(ret != KERN_SUCCESS) {
	switch(ret) {
	case KERN_INVALID_ARGUMENT: osret = OS_ERR_ARG_INVALID; break;
	default: ret = OS_ERR; break;
	}

	break;
      }
    }

    info = info->link;
  }

  pthread_mutex_unlock(&g_thread_info_lock);

  return osret;
}

int os_resume_other_threads() {
  int osret = OS_OK;
  thread_t self = mach_thread_self();

  pthread_mutex_lock(&g_thread_info_lock);

  os_darwin_x64_thread_info* info = g_thread_info;

  while(info) {
    if(info->thread_id != self) {

      kern_return_t ret = thread_resume(info->thread_id);

      if(ret != KERN_SUCCESS) {
	switch(ret) {
	case KERN_INVALID_ARGUMENT: osret = OS_ERR_ARG_INVALID; break;
	default: ret = OS_ERR; break;
	}

	break;
      }
    }

    info = info->link;
  }

  pthread_mutex_unlock(&g_thread_info_lock);

  return osret;
}

int os_other_thread_info(os_thread_info** info_vec, int* count) {
  int osret = OS_OK;

  thread_t self = mach_thread_self();

  pthread_mutex_lock(&g_thread_info_lock);

  int info_count = 0;
  os_darwin_x64_thread_info* curr = g_thread_info;
  while(curr) {
    if(curr->thread_id != self)
      ++info_count;
    curr = curr->link;
  }

  if(info_count == 0) {
    osret = OS_ERR_ARG_INVALID;
    goto exit;
  }

  *info_vec = (os_thread_info*)malloc(sizeof(os_thread_info)*info_count);

  curr = g_thread_info;
  info_count = 0;
  while(curr) {
    if(curr->thread_id != self) {

      os_thread_info* info = &(*info_vec)[info_count++];

      x86_thread_state64_t state;
      mach_msg_type_number_t count = x86_THREAD_STATE64_COUNT;
      kern_return_t ret = thread_get_state(curr->thread_id,
					   x86_THREAD_STATE64,
					   (thread_state_t)&state,
					   &count);
      if(ret != KERN_SUCCESS) {
	switch(ret) {
	case KERN_INVALID_ARGUMENT: osret = OS_ERR_ARG_INVALID; break;
	default: osret = OS_ERR; break;
	}

	break;
      }

      info->gpr_count = 16;
      info->gprs[0] = state.__rax;
      info->gprs[1] = state.__rbx;
      info->gprs[2] = state.__rcx;
      info->gprs[3] = state.__rdx;
      info->gprs[4] = state.__rdi;
      info->gprs[5] = state.__rsi;
      info->gprs[6] = state.__rbp;
      info->gprs[7] = state.__rsp;
      info->gprs[8] = state.__r8;
      info->gprs[9] = state.__r9;
      info->gprs[10] = state.__r10;
      info->gprs[11] = state.__r11;
      info->gprs[12] = state.__r12;
      info->gprs[13] = state.__r13;
      info->gprs[14] = state.__r14;
      info->gprs[15] = state.__r15;

      info->stack_low = (os_pointer)(state.__rsp - X64_RED_ZONE);
      info->stack_high = curr->stack_high;

      info->rtr_count = OS_MAX_RTRS;
      memcpy(info->rtrs, curr->rtr_area, sizeof(os_word)*OS_MAX_RTRS);
    }

    curr = curr->link;
  }

  *count = info_count;

 exit:
  pthread_mutex_unlock(&g_thread_info_lock);

  if(osret != OS_OK) {
    free(*info_vec);
    *info_vec = 0;
    *count = 0;
  }

  return osret;
}   

/* 
 * On entry, we know that all live caller-save registers are on the stack,
 * and that the argument registers contain nothing interesting. 
 * We have to push the callee-save registers on the stack, though, because
 * this function body may not force all of them to be spilled to the stack.
 */
os_word os_call_with_self_info(os_self_info_callback fun, os_word arg) {
  os_word rsp = 0;
  __asm__ ("pushq %%rbx\n\t"
	   "pushq %%rbp\n\t"
	   "pushq %%r12\n\t"
	   "pushq %%r13\n\t"
	   "pushq %%r14\n\t"
	   "pushq %%r15\n\t"
	   "movq %%rsp, %0"
	   : "=r" (rsp));

  os_darwin_x64_thread_info* info = find_thread_info(mach_thread_self());

  if(!info) return 0;

  os_thread_info self_info;
  self_info.gpr_count = 0;
  memset(self_info.gprs, 0, sizeof(os_word) * OS_MAX_GPRS);
  self_info.stack_high = info->stack_high;
  self_info.stack_low = (os_pointer)rsp; /* don't need red zone here */

  self_info.rtr_count = OS_MAX_RTRS;
  memcpy(self_info.rtrs, info->rtr_area, sizeof(os_word)*OS_MAX_RTRS);

  return fun(&self_info, arg);
} 

void os_set_rtr(os_word rn, os_word value) {
  size_t offset = (rn + PTHREAD_KEY_BASE) * sizeof(os_word) + PTHREAD_TLS_BASE;
  __asm__ ("mov %0, %%gs:0(%1)" : : "r"(value), "r"(offset));
}

os_word os_get_rtr(os_word rn) {
  size_t value = 0;
  size_t offset = (rn + PTHREAD_KEY_BASE) * sizeof(os_word) + PTHREAD_TLS_BASE;
  __asm__ ("mov %%gs:0(%1), %0" : "=r"(value) : "r"(offset));
  return value;
}

os_time os_time_nsec() {
  uint64_t time = mach_absolute_time();
  return (os_time)(time * g_timebase.numer / g_timebase.denom);
}

void os_exit(int code) {
  exit(code);
}
