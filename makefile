CC = clang
CCFLAGS = -std=gnu99 -c -MMD -MP -D_GNU_SOURCE -Wall -lpthread
DEBUGFLAGS = -g
ASANFLAGS = -fsanitize=leak -fno-omit-frame-pointer

all: test1 
debug: test1-debug 
asan: test1-asan

test1: malloc tests/test1.c
	$(CC) malloc.o linkedList.o dataStructure.o mark_and_sweep.o -lpthread tests/test1.c -o test1.out

test1-debug: malloc-debug tests/test1.c
	$(CC) $(DEBUGFLAGS) malloc.o dataStructure.o mark_and_sweep.o linkedList.o -lpthread tests/test1.c -o test1-debug.out

test1-asan: malloc tests/test1.c
	$(CC) $(ASANFLAGS) malloc.o dataStructure.o mark_and_sweep.o linkedList.o -lpthread tests/test1.c -o test1-asan.out

test1-without-gc4c-asan: tests/test1-without-gc4c.c
	$(CC) $(ASANFLAGS) tests/test1-without-gc4c.c -o test1-without-gc4c-asan.exe

malloc: linkedList mark_and_sweep inc/malloc.h inc/malloc.c
	$(CC) $(CCFLAGS) inc/malloc.h inc/malloc.c -c

mark_and_sweep: dataStructure inc/mark_and_sweep.h inc/mark_and_sweep.c
	$(CC) $(CCFLAGS) inc/mark_and_sweep.h inc/mark_and_sweep.c -c 

dataStructure: inc/dataStructure.h inc/dataStructure.c
	$(CC) $(CCFLAGS) inc/dataStructure.h inc/dataStructure.c -c

# gc_pthread: linkedList
#	$(CC) $(CCFLAGS) inc/gc_pthread.h inc/gc_pthread.c -c

linkedList: 
	$(CC) $(CCFLAGS) inc/linkedList.h inc/linkedList.c -c


malloc-debug: linkedList-debug mark_and_sweep-debug inc/malloc.h inc/malloc.c
	$(CC) $(CCFLAGS) $(DEBUGFLAGS) inc/malloc.h inc/malloc.c -c

mark_and_sweep-debug: dataStructure-debug inc/mark_and_sweep.h inc/mark_and_sweep.c
	$(CC) $(CCFLAGS) $(DEBUGFLAGS) inc/mark_and_sweep.h inc/mark_and_sweep.c -c 

dataStructure-debug: inc/dataStructure.h inc/dataStructure.c
	$(CC) $(CCFLAGS) $(DEBUGFLAGS) inc/dataStructure.h inc/dataStructure.c -c

# gc_pthread-debug: linkedList-debug
#	$(CC) $(CCFLAGS) $(DEBUGFLAGS) inc/gc_pthread.h inc/gc_pthread.c -c

linkedList-debug: 
	$(CC) $(CCFLAGS) $(DEBUGFLAGS) inc/linkedList.h inc/linkedList.c -c

clean:
	rm -rf *o *.exe *.out
