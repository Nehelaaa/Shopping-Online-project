/* printf.c - printf */
#include <sysapi.h>

#define	OK	1
/*------------------------------------------------------------------------
 *  printf  --  write formatted output on console 
 *------------------------------------------------------------------------
 */
printf(fmt, args)
	char	*fmt;
{
	_doprnt(fmt, &args, putc, CONSOLE);
	return(OK);
}
