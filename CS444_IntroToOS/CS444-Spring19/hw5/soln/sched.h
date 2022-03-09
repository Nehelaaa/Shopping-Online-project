/* sched.h, Scheduler API */
/* Note lack of encapsulation here: these functions and others all */
/*   access the proctab data.  */

/* hw5: needed definitions for the scheduler */
#define  QUANTUM    4
#define REPORT_BLOCKING 
/* Call this with interrupts off */
/* Find next runnable user process */
/* if none, select kernel (null) process */
/* hw5: add debug tracking of call location */
void scheduler(int call_loc);

/* call this with interrupts off */
/* set current process to BLOCKED on specified event */
/* indicate event and call scheduler to find another process */
/* hw5: add debug tracking of caller */
void sleep(int event, int caller);

/* wakeup all processes blocked on event */
void wakeup(int event);
