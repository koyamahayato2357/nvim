#pragma once
#include "main.h"
#include <stdlib.h>

#define EXPAND(...) __VA_ARGS__
#define CAT(a, b) CAT2(a, b)
#define CAT2(a, b) a##b
#define TOSTR(x) #x
#define TO2STR(x) TOSTR(x)
#define HERE __FILE__ ":" TO2STR(__LINE__)
#define lesser(lhs, rhs) (lhs) < (rhs) ? (lhs) : (rhs)
#define bigger(lhs, rhs) (lhs) > (rhs) ? (lhs) : (rhs)
#define overloadable __attribute__((overloadable))
#define ondrop(cl) __attribute__((cleanup(cl)))
#define drop ondrop(free_cl)
#define dropfile ondrop(fclose_cl)
#define dropdir ondrop(closedir_cl)
#define likely(cond) __builtin_expect(!!(cond), 1)
#define unlikely(cond) __builtin_expect(!!(cond), 0)
#define _ auto CAT(_DISCARD_, __COUNTER__) [[maybe_unused]]

#define droptbl ondrop(free_tbl)

static void free_tbl(table_t *tbl) {
  free(tbl->buf);
}
