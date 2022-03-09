/*********************************************************************
*
*       file:           tunistd.h
*       author:         betty o'neil
*       date:           Feb, '97, F02
*
*       API for Tiny UNIX system calls, like unistd.h
*
*/

#ifndef TUNISTD_H
#define TUNISTD_H

#include "tty_public.h"

/* read nchar bytes into buf from dev */
int read(int dev, char *buf, int nchar);
/* write nchar bytes from buf to dev */
int write(int dev, char *buf, int nchar);
/* misc. device functions (not implemented) */
int control(int dev, int fncode, int val);

/* hw5: semaphore syscalls */
/* create a semaphore with initial count inicount, returns semid */
int sem_create(int inicount);
/* decrement semaphore's count if positive, block if it was 0
   until another process does an up on this semaphore */
int down(int semid);
/* unblock a waiter on this semaphore, if any, or if none
   increment the semaphore's count */
int up(int semid);
/* delete the semaphore */
int sem_delete(int semid);

#endif
