/* file   : tunix.c
   purpose: beginning kernel code
   author : Dana C.Chandler III (merged with hw3.soln by Betty O'Neil)
   class  : CS444 Fall 2002
   date   : 09-Oct-2002
  
   modified: Ron Cheung 5/2017
	     fix bug in sysexit
	     remove semaphore related code
 */

#include <stdio.h>
#include <cpu.h>
#include <gates.h>
#include "tsyscall.h"
#include "tsystm.h"
#include "sched.h"
#include "proc.h"
#include "tickpack.h"

/* for saved eflags register */
#define EFLAGS_IF 0x200
/* for saved esp register--stack bases for user programs */
/* could use enum here */
#define STACKBASE1 0x3f0000
#define STACKBASE2 0x3e0000
#define STACKBASE3 0x3d0000

extern IntHandler syscall; /* the assembler envelope routine    */
extern void ustart1(void),ustart2(void), ustart3(void);
extern void finale(void);

void k_init(void);
void syscallc( int user_eax, int devcode, char *buff , int bufflen);
void debug_set_trap_gate(int n, IntHandler *inthand_addr, int debug);
void set_trap_gate(int n, IntHandler *inthand_addr);
void process0(void), init_proctab(void), shutdown(void);
int sysexit(int);

/* Record debug info in otherwise free memory between program and stack */
/* 0x300000 = 3M, the start of the last M of user memory on the SAPC */
#define DEBUG_AREA 0x300000
char *debug_log_area = (char *)DEBUG_AREA;
char *debug_record;  /* current pointer into log area */ 

/* kernel globals added for scheduler */
PEntry proctab[NPROC],*curproc; 
int number_of_zombie;

#define MAX_CALL 10

/* syscall dispatch table */
static  struct sysent {
       short   sy_narg;        /* total number of arguments */
       int     (*sy_call)(int, ...);   /* handler */
} sysent[MAX_CALL];

/* hw5: for stats on # calls to scheduler from various places */
int sched_calls[NLOCS];		/* call counts by location of call */
static const char *func_name[NLOCS] = 
{"Process 0", "SysExit", "SysRead", "SysWrite", 
 "Tick Handler", "Semaphore::down"};

/* end of kernel globals */

/****************************************************************************/
/* k_init: this function for the initialize  of the kernel system      */
/****************************************************************************/

void k_init(void)
{
  cli();                 /* initialize with interrupts off */
  debug_record = debug_log_area; /* clear debug log */
  ioinit();                             /* initialize the deivce */ 
  set_trap_gate(0x80, &syscall);        /* SET THE TRAP GATE*/
 
  /* Note: Could set these with initializers */
  /* Need to cast function pointer type to keep ANSI C happy */
  sysent[TREAD].sy_call = (int (*)(int, ...))sysread;
  sysent[TWRITE].sy_call = (int (*)(int, ...))syswrite;
  sysent[TEXIT].sy_call = (int (*)(int, ...))sysexit;
  sysent[TIOCTL].sy_call = (int (*)(int, ...))syscontrol;
  sysent[TEXIT].sy_call = (int (*)(int, ...))sysexit;

  /* for hw5 semaphores */
  /*sysent[TSEM_CRE].sy_call = (int (*)(int, ...))syssem_create;
  sysent[TUP].sy_call = (int (*)(int, ...))sysup;
  sysent[TDOWN].sy_call = (int (*)(int, ...))sysdown;
  sysent[TSEM_DEL].sy_call = (int (*)(int, ...))syssem_delete;
 */ 
  sysent[TEXIT].sy_narg = 1;            /* set the arg number of function */
  sysent[TREAD].sy_narg = 3;
  sysent[TIOCTL].sy_narg = 3;
  sysent[TWRITE].sy_narg = 3;
/*  sysent[TSEM_CRE].sy_narg = 1;
  sysent[TDOWN].sy_narg = 1;
  sysent[TUP].sy_narg = 1;
  sysent[TSEM_DEL].sy_narg = 1;
 */
  number_of_zombie = 0;
  init_proctab();
  init_ticks();			/* hw5: set up the timer */
/*  init_semaphores();  */	/* hw5: initialize semaphores */
 sti();
  process0();			/* rest of kernel operation (non-init) */
}

/****************************************************************************/
/* process0:  code for process 0: runs when necessary, shuts down           */
/****************************************************************************/
void process0()
{
  int i;

  /* execution will come back here when restore process 0*/
  while (number_of_zombie < NPROC-1) { /* proc 0 can't be zombie */     
    sti();			/* let proc 0 take interrupts (important!) */
    cli();
    scheduler(FPROC);
  }
  kprintf("SHUTTING DOWN\n");
  sti();
  for (i=0; i< 10000000; i++)
    ;				/* let output finish (kludge) */
  shutdown();
  /* note that we can return, in process0, to the startup module
     with its int $3.  It's OK to jump to finale, but not necessary */
}

/****************************************************************************/
/* init_proctab: this function for setting init_sp, init_pc              */
/* zeroing out savededp, and set to RUN                                     */
/****************************************************************************/
void init_proctab()
{
  int i;

  proctab[1].p_savedregs[SAVED_PC] = (int)&ustart1;
  proctab[2].p_savedregs[SAVED_PC] = (int)&ustart2;
  proctab[3].p_savedregs[SAVED_PC] = (int)&ustart3;
 
  proctab[1].p_savedregs[SAVED_ESP] = STACKBASE1;
  proctab[2].p_savedregs[SAVED_ESP] = STACKBASE2;
  proctab[3].p_savedregs[SAVED_ESP] = STACKBASE3;

  for(i=0;i<NPROC;i++){
    proctab[i].p_savedregs[SAVED_EBP] = 0;
    proctab[i].p_savedregs[SAVED_EFLAGS] = EFLAGS_IF; /* make IF=1 */
    proctab[i].p_status=RUN;
    proctab[i].p_cpu_usage = 0;
    proctab[i].p_chars_out = 0;
    proctab[i].p_quantum   = 4;
  }

  curproc=&proctab[0];
 
  number_of_zombie=0;
}

/* shut the system down */
void shutdown()
{
  int i;

  kprintf("SHUTTING THE SYSTEM DOWN!\n");

  shutdown_ticks();

  /* hw5 stats report-- */
  for(i=1;i<NPROC;i++) {
    kprintf("\nSHUTTING DOWN process %d with exit code %d, CPU Usage: %d, Chars Out: %d\n",
	    i, proctab[i].p_exitval, proctab[i].p_cpu_usage, 
	    proctab[i].p_chars_out);
  }
  kprintf("-----------------------------------------------------------------");
  for (i=0;i<NLOCS;i++)
    kprintf("\nSchedule called %d times from %s\n", sched_calls[i], func_name[i]);
  kprintf("-----------------------------------------------------------------\n");
  kprintf("Debug log from run:\n");
  kprintf("Marking kernel events as follows:\n");
  kprintf("  ^a   COM2 input interrupt, a received\n");
  kprintf("  ~    COM2 output interrupt, ordinary char output\n");
  kprintf("  ~e   COM2 output interrupt, echo output\n");
  kprintf("  ~s   COM2 output interrupt, shutdown TX ints\n");
  kprintf("  %%    Pre-emption attempted\n");
  kprintf("  *n   timer interrupt in process n\n");

  kprintf("  |(1z-2) process switch from 1, now a zombie, to 2\n");
#ifdef REPORT_BLOCKING
  kprintf("  |(1b-2) process switch from 1, now blocked, to 2\n");
#endif
  kprintf("  |(2-1) process switch by preemption from 2 to 1\n");
  kprintf("\n\n%s", debug_log_area);	/* the debug log from memory */
  kprintf("\nLEAVE KERNEL!\n\n");
}

/****************************************************************************/
/* syscallc: this function for the trap c routine handler                   */
/****************************************************************************/

void syscallc( int user_eax, int devcode, char *buff , int bufflen){
  int nargs;
  int syscall_no = user_eax;

  switch(nargs = sysent[syscall_no].sy_narg)
    {
    case 1:         /* 1-argument system call */
	user_eax = sysent[syscall_no].sy_call(devcode);   /* sysexit */
	break;
    case 3:         /* 3-arg system call: calls sysread or syswrite */
	user_eax = sysent[syscall_no].sy_call(devcode,buff,bufflen); 
	break;
    default: kprintf("bad # syscall args %d, syscall #%d\n",
		     nargs, syscall_no);
    }
} 

/****************************************************************************/
/* sysexit: this function for the exit syscall function */
/****************************************************************************/

int sysexit(int exit_code)
{ 
  int saved_eflags = get_eflags();

  curproc->p_exitval = exit_code;

  cli();			/* hw5: prevent race condition */
  number_of_zombie++;		/* (in case preemption *inside* here) */
  set_eflags(saved_eflags);     /* back to previous CPU int. status */

  curproc->p_status = ZOMBIE;
  scheduler(FEXIT);
  //  sleep(ZOMBIE, FEXIT);
  /* never returns */       
  return 0;    
}

/****************************************************************************/
/* set_trap_gate: this function for setting the trap gate */
/****************************************************************************/

void set_trap_gate(int n, IntHandler *inthand_addr)
{
  debug_set_trap_gate(n, inthand_addr, 0);
}

/* write the nth idt descriptor as a trap gate to inthand_addr */
void debug_set_trap_gate(int n, IntHandler *inthand_addr, int debug)
{
  char *idt_addr;
  Gate_descriptor *idt, *desc;
  unsigned int limit = 0;
  extern void locate_idt(unsigned int *, char **);

  if (debug)
    kprintf("Calling locate_idt to do sidt instruction...\n");
  locate_idt(&limit,&idt_addr);
  /* convert to CS seg offset, i.e., ordinary address, then to typed pointer */
  idt = (Gate_descriptor *)(idt_addr - KERNEL_BASE_LA);
  if (debug)
    kprintf("Found idt at %x, lim %x\n",idt, limit);
  desc = &idt[n];               /* select nth descriptor in idt table */
  /* fill in descriptor */
  if (debug)
    kprintf("Filling in desc at %x with addr %x\n",(unsigned int)desc,
           (unsigned int)inthand_addr);
  desc->selector = KERNEL_CS;   /* CS seg selector for int. handler */
  desc->addr_hi = ((unsigned int)inthand_addr)>>16; /* CS seg offset of inthand */
  desc->addr_lo = ((unsigned int)inthand_addr)&0xffff;
  desc->flags = GATE_P|GATE_DPL_KERNEL|GATE_TRAPGATE; /* valid, trap */
  desc->zero = 0;
}

void tick_handler()
{
  char buf[100];

  sprintf(buf,"*%d", curproc-proctab);
  debug_log(buf);
/* 
 * hw5: manage the quantum
*/
  ++curproc->p_cpu_usage;
  if (curproc != &proctab[0] && --curproc->p_quantum == 0) {  
    /* preempting, later start over with full quantum */
    curproc->p_quantum = 4; 
    debug_log("%");   /* record preemption attempt in log */
    scheduler(FTICK);  /* find another process to run */    
  }   
}


/* append msg to memory log */
void debug_log(char *msg)
{
    strcpy(debug_record, msg);
    debug_record +=strlen(msg);
}


