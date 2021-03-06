/*********************************************************************
*
*       file:           io.c
*       author:         betty o'neil
*
*       device-independent i/o package for SAPC
*
*/
#include <cpu.h>
#include "io_public.h"
#include "ioconf.h"

/*====================================================================
*
* i/o initialization loop for SAPC devices
*
*/

void ioinit()
{
  int i;

  cli();
  for (i = 0; i < NDEVS; i++)
    devtab[i].dvinit(i);	/* call device-specific init routine */
  sti();
}

/*====================================================================
*
*       read function calling routine for SAPC devices
*
*/

int read(int dev, char *buf, int nchar)
{
  if (dev < 0 || dev >= NDEVS) return -1;      /* fail */
  return devtab[dev].dvread(dev, buf, nchar); /* call dev-specific routine */
}

/*====================================================================
*
*       write function calling routine for SAPC devices
*
*/
int write(int dev, char *buf, int nchar)
{
  if (dev < 0 || dev >= NDEVS) return -1;       /* fail */
  return devtab[dev].dvwrite(dev, buf, nchar); /* call dev-specific routine */
}

/*====================================================================
*
*       control function calling routine for SAPC devices
*
*/
int control(int dev, int fncode, int val)  /* note: val could be pointer */
{
  if (dev < 0 || dev >= NDEVS) return -1;          /* fail */
  return devtab[dev].dvcontrol(dev, fncode, val); /* dev-specific routine */
}
