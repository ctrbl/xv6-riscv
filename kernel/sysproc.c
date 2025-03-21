#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
  int n;
  argint(0, &n);
  exit(n);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return fork();
}

uint64
sys_wait(void)
{
  uint64 p;
  argaddr(0, &p);
  return wait(p);
}

uint64
sys_sbrk(void)
{
  uint64 addr;
  int n;

  argint(0, &n);
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

uint64
sys_sleep(void)
{
  int n;
  uint ticks0;

  argint(0, &n);
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

uint64
sys_kill(void)
{
  int pid;

  argint(0, &pid);
  return kill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

uint64
sys_uniq_k(void)
{
  int fd, c_flag, d_flag, i_flag;  
  uint64 addr; 

  argint(0, &fd);
  argaddr(1, &addr);
  argint(2, &c_flag);
  argint(3, &d_flag);
  argint(4, &i_flag); 
  uniq_k(fd, addr, c_flag, d_flag, i_flag);
  return 0;  
}

uint64
sys_head_k(void)
{
  int fd, count;  
  uint64 addr; 

  argint(0, &fd); 
  argaddr(1, &addr); 
  argint(2, &count); 
  head_k(fd, addr, count);
  return 0;
}

uint64
sys_waitx(void)
{
  uint64 addr; 
  int *wait_time, *turnaround_time; 
 
  argaddr(0, &addr); 
  argaddr(1, (uint64*)&wait_time); 
  argaddr(2, (uint64*)&turnaround_time);
  return waitx(addr, wait_time, turnaround_time); 
}

uint64
sys_ps(void) {
  int option, value; 
  uint64 addr; 

  argint(0, &option);
  argint(1, &value); 
  argaddr(2, &addr);
  ps(option, value, addr);
  return 0;  
}

uint64 
sys_set_scheduler(void) {
  int scheduler; 

  argint(0, &scheduler);
  set_scheduler(scheduler);
  return 0; 
}

uint64 
sys_set_priority(void) {
  int pid, priority;

  argint(0, &pid);
  argint(1, &priority);
  return set_priority(pid, priority);
}
