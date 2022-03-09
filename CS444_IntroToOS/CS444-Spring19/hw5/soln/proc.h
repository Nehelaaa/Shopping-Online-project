/*********************************************************************
*
*       file:        proc.h
*                    Process structure info
*
*/
#ifndef PROC_H
#define PROC_H

#define  NPROC 4

#define  N_SAVED_REGS 7
/* 7 non-scratch CPU registers, saved in this order: */
enum cpu_regs { SAVED_ESP, SAVED_EBX, SAVED_ESI, SAVED_EDI, 
		  SAVED_EBP, SAVED_EFLAGS, SAVED_PC};

/* for p_status ( RUN=1, BLOCKED=2, ZOMBIE=3) */
typedef enum proc_status {RUN = 1, BLOCKED, ZOMBIE} ProcStatus;

/* for p_waitcode, what process is waiting for */
/* hw5: added SEM_BASE after i/o event codes */
typedef enum proc_wait {TTY0_OUTPUT = 1, TTY1_OUTPUT, 
			TTY0_INPUT, TTY1_INPUT, SEM_BASE} WaitCode;

/* Process Entry */
typedef struct {
   int p_savedregs[N_SAVED_REGS]; /* saved non-scratch registers */
   ProcStatus p_status;   /* RUN, BLOCKED, or ZOMBIE */
   WaitCode p_waitcode;   /* valid only if status=BLOCKED: TTY0_OUT, etc. */
   int p_exitval;         /* valid only if status=ZOMBIE */
   int p_cpu_usage; /* hw5 addition: cpu usage */
   int p_chars_out; /* hw5 addition: # of chars outputted */
   int p_quantum;   /* hw5 addition: #ticks left before preemption */
/*   int p_sem_signalled;*/  /* hw5 sem addition: OK to return from down */
} PEntry;

/* extern these globals here, define them in tunix.c, main-like .c file  */
extern PEntry proctab[], *curproc;

#endif /*PROC_H */
