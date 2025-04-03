/**
 * @file include/chore.h
 * @brief Define util macros
 */

#pragma once
#include "def.h"
#include <dirent.h>
#include <stdio.h>

#define HERE             __FILE__ ":" TOSTR(__LINE__)
#define lesser(lhs, rhs) ((lhs) < (rhs) ? (lhs) : (rhs))
#define bigger(lhs, rhs) ((lhs) > (rhs) ? (lhs) : (rhs))
#define overloadable     [[clang::overloadable]]
#define ondrop(cl)       [[gnu::cleanup(cl)]]
#define drop             ondrop(freecl)
#define dropfile         ondrop(fclosecl)
#define dropdir          ondrop(closedircl)
#define _                auto CAT(_DISCARD_, __COUNTER__) [[gnu::unused]]

#define zalloc(T, size) ((T *)palloc(size * sizeof(T)))

#define nfree(p) \
  do { \
    if (p == nullptr) break; \
    free(p); \
    p = nullptr; \
  } while (0)

[[gnu::nonnull]] void freecl(void *);
[[gnu::nonnull]] void fclosecl(FILE **);
[[gnu::nonnull]] void closedircl(DIR **);
