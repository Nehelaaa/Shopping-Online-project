# file :	ulib.s
# name :	joseph tam paul hui
#date  :	3-2-97
#description:	assembler routine for read,write, ioctl1,exit
#hw5:	 add semaphore syscalls				

.globl _write,_read,_ioctl,_exit, _sem_create, _down, _up, _sem_delete
.text
	
_write:	pushl %ebx                    # save the value of ebx
	movl 8(%esp),%ebx              
	movl 12(%esp),%ecx
	movl 16(%esp),%edx
	movl $3,%eax
        int $0x80                     # call trap handler
	popl  %ebx                    # restore the value of ebx
	ret

_read:	pushl %ebx                       # save the value of ebx
	movl 8(%esp),%ebx
	movl 12(%esp),%ecx
	movl 16(%esp),%edx
	movl $2,%eax
        int $0x80                     # call trap handler      
	popl  %ebx                    # restore the value of ebx
	ret
	
_ioctl:	pushl %ebx                     # save the value of ebx
	movl 8(%esp),%ebx
	movl 12(%esp),%ecx
	movl 16(%esp),%edx
	movl $5,%eax
        int $0x80                     # call trap handler
	popl  %ebx                    # restore the value of ebx
	ret
			
_exit:	pushl %ebx                      # save the value of ebx
	movl 8(%esp),%ebx
	movl $1,%eax          
        int $0x80                      # call trap handler
	popl  %ebx                     # restore the value of ebx
	ret	

_sem_create:	pushl %ebx                      # save the value of ebx
	movl 8(%esp),%ebx
	movl $6,%eax          
        int $0x80                      # call trap handler
	popl  %ebx                     # restore the value of ebx
	ret	

_down:	pushl %ebx                      # save the value of ebx
	movl 8(%esp),%ebx
	movl $7,%eax          
        int $0x80                      # call trap handler
	popl  %ebx                     # restore the value of ebx
	ret	

_up:	pushl %ebx                      # save the value of ebx
	movl 8(%esp),%ebx
	movl $8,%eax          
        int $0x80                      # call trap handler
	popl  %ebx                     # restore the value of ebx
	ret	

_sem_delete:	pushl %ebx                      # save the value of ebx
	movl 8(%esp),%ebx
	movl $9,%eax          
        int $0x80                      # call trap handler
	popl  %ebx                     # restore the value of ebx
	ret	


