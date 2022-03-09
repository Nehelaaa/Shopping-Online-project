/*********************************************************************
*
*       file:           tsystm.h
*       author:         betty o'neil
*
*       kernel header for internal prototypes
*
*/

#ifndef TSYSTM_H
#define TSYSTM_H
/* booleans */
#define  TRUE     1
#define  FALSE    0

/* initialize io package*/
void ioinit(void);
/* read nchar bytes into buf from dev */
int sysread(int dev, char *buf, int nchar);
/* write nchar bytes from buf to dev */
int syswrite(int dev, char *buf, int nchar);
/* misc. device functions */
int syscontrol(int dev, int fncode, int val);

/* hw5 semaphores: called from kernel init-- */
void init_semaphores(void);
/* semaphore syscall implementations */
/* int syssem_create(int inicount);
int sysdown(int semid);
int sysup(int semid);
int syssem_delete(int semid);
*/

void tick_handler(void);

/* hw5: for stats */
void update_char_count(void);
extern int sched_calls[];


/* codes for locations of calls to schedule */
#define NLOCS  6
#define  FPROC      0
#define  FEXIT      1
#define  FREAD      2
#define  FWRIT      3
#define  FTICK      4
#define  FSEMA      5
void debug_log(char *msg);

#endif
