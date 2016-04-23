/*
 * malloc.h
 *
 * Header file for malloc functions
 *
 */
#ifndef _MALLOC_H_
#define _MALLOC_H_

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stddef.h>
#include "dataStructure.h" 
#include "mark_and_sweep.h"

#define malloc(size) gc_malloc(size)
#define realloc(ptr, size) gc_malloc(ptr, size)
#define calloc(nmemb, size) gc_calloc(nmemb, size)
#define free(ptr) gc_free(ptr)

int _gcMultiThreaded = 0;

void gc_init();
void gc_init_r();
void* gc_malloc(size_t size);
void* gc_realloc(void* ptr, size_t size);
void gc_free(void* ptr);
void* gc_calloc(size_t nmemb, size_t size);
void gc_destroy();

#endif
