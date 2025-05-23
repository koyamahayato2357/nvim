/**
 * @file include/gene.h
 * @brief Define macros for generic programming
 */

#pragma once
#include "def.h"
#include <stddef.h>

#define overloadable [[clang::overloadable]]

#define DEF_PRIM(T) \
  overloadable void printany(T); \
  overloadable void printanyf(T); \
  overloadable bool eq(T, T);
#define DEF_GEN(T) DEF_PRIM(T) DEF_PRIM(T *)

#define TYPES bool, char, int, size_t, long, long long, double

#define PRIM_TYPES void *

#define APPLY_ADDSUB(M) M(Add, +) M(Sub, -)
#define APPLY_ARTHM(M)  APPLY_ADDSUB(M) M(Mul, *) M(Div, /)
#define APPLY_LTGT(M)   M(Lt, <) M(Gt, >)

MAP(DEF_GEN, TYPES)
MAP(DEF_PRIM, PRIM_TYPES)

#define _PRINTREC(first, ...) \
  printany(first); \
  __VA_OPT__(RECURSE(_PRINT, REC)(__VA_ARGS__))
#define PRINT(...) \
  do { EVAL(_PRINTREC(__VA_ARGS__)) } while (0)
