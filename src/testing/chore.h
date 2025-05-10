/**
 * @file include/chore.h
 * @brief Define util macros
 */

#pragma once
#include "def.h"
#include <dirent.h>
#include <stdio.h>
#include <string.h>

constexpr size_t alpha_n = 'z' - 'a' + 1;

#define HERE           __FILE__ ":" TOSTR(__LINE__)
#define less(lhs, rhs) ((lhs) < (rhs) ? (lhs) : (rhs))
#define more(lhs, rhs) ((lhs) > (rhs) ? (lhs) : (rhs))
#define overloadable   [[clang::overloadable]]
#define ondrop(cl)     [[gnu::cleanup(cl)]]
#define drop           ondrop(freecl)
#define dropfile       ondrop(fclosecl)
#define dropdir        ondrop(closedircl)
#define __             CAT(_DISCARD_, __COUNTER__) [[gnu::unused]]
#define _              auto __

#define xalloc(T, size) ((T *)palloc(size * sizeof(T)))

#define nfree(p) \
  do { \
    if (p == nullptr) break; \
    free(p); \
    p = nullptr; \
  } while (0)

#define bit_cast(T, ...) \
  ({ \
    auto src = __VA_ARGS__; \
    static_assert(sizeof(T) == sizeof(src)); \
    T dst; \
    memcpy(&dst, &src, sizeof(T)); \
    dst; \
  })

[[gnu::const]] bool isInt(double);
[[gnu::returns_nonnull, nodiscard("allocation")]] void *palloc(size_t);
[[gnu::nonnull]] void freecl(void *);
[[gnu::nonnull]] void fclosecl(FILE **);
[[gnu::nonnull]] void closedircl(DIR **);
