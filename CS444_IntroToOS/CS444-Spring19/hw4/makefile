# makefile for hw4
# format of entries;

# < target list >:  	< dependency list >
# 			< command list >

# make will look at the last-write dates of each file, and if the target
# file hasn't been updated since the source files were last modified,
# it will update the target file by executing the shell command. Note that
# the spacing to the < dependency list > and < command list > MUST be done
# with tabs, not spaces.
#
# now here is a Macro as defined in Glass Unix.

cc =	gcc
CFLAGS =   -m32 

calcit:	main.o getop.o stack.o getch.o
		$(cc) $(CFLAGS) -g -o calcit main.o getop.o stack.o getch.o

# note that if calc.h changes, main.c and getop.c must be recompiled

main.o:	main.c calc.h
		$(cc) $(CFLAGS) -c -o main.o main.c
getop.o:	getop.c calc.h
		$(cc) $(CFLAGS) -c -o getop.o getop.c
stack.o:	stack.c 
		$(cc) $(CFLAGS) -c -o stack.o stack.c
getch.o: 	getch.c 
		$(cc) $(CFLAGS) -c -o getch.o getch.c

# this tells make what to make if you just type 'make'; if this isn't there,
# the first rule in the file will be the default.

# default:	calcit

# here is a rule to clean up the directory when calcit is final and you want
# to reduce the clutter in the listing. Note that clean doesn't need to
# depend on any file modification time, so the < dependency list > position is
# just left empty.

clean:
		rm *.o
