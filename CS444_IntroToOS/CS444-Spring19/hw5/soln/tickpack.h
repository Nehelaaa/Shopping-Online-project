#ifndef TICKPACK_H
#define TICKPACK_H
#include <cpu.h>
#include <pic.h>

#define TEN_MIL_SEC 0x5000
//#define TEN_MIL_SEC 0x2e9a /*original count */

/* Start ticking service that calls app_tick_callback every interval usecs */
void init_ticks(void);

/* Shut down ticking service */
void shutdown_ticks(void);

#endif
