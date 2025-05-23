/**
 * @file src/gene.c
 * @brief Define generic functions
 */

#include "gene.h"
#include "mathdef.h"
#include "testing.h"

constexpr double eps = 1e-5;

static bool doubleEq(double a, double b) {
  if (fabs(b) < eps) return fabs(a) < eps; // prevent 0-div when b is near 0
  if (a < 0 != b < 0) return false;        // mis signed
  return fabs(a / b - 1.0) < eps;          // cmp based on ratios
}
static bool complexEq(comp a, comp b) {
  return doubleEq(creal(a), creal(b)) && doubleEq(cimag(a), cimag(b));
}

test_table(
  double_eq, doubleEq, (bool, double, double),
  {
    { true,      1.0,          1.0},
    { true,    1e-10,            0},
    { true,    1e100, 1e100 + 1e10},
    {false,        0,            1},
    {false,      NAN,          NAN},
    {false,      NAN,         1e10},
    {false, INFINITY,     INFINITY},
    {false, INFINITY,        1e100},
}
)
test_table(
  complex_eq, complexEq, (bool, comp, comp),
  {
    { true,                0,          0},
    { true,           1 + 3i, 1.0 + 3.0i},
    { true, 1.0 + 1e-10 + 3i,     1 + 3i},
    {false,                0,          1},
    {false,           3 + 5i,    -1 + 3i},
}
)

#pragma clang attribute push(overloadable, apply_to = function)
void printany(int x) {
  printf("%d", x);
}
void printany(size_t x) {
  printf("%zu", x);
}
void printany(double x) {
  printf("%lf", x);
}
void printany(char *x) {
  printf("%s", x);
}
void printany(char x) {
  printf("%c", x);
}
void printany(bool x) {
  printf(x ? "`true`" : "`false`");
}
void printany(long x) {
  printf("%ld", x);
}
void printany(long long x) {
  printf("%lld", x);
}
void printany(void *x) {
  if (x) printf("0x%p", x);
  else printf("`nullptr`");
}
void printanyf(int x) {
  PRINT(x);
}
void printanyf(size_t x) {
  PRINT(x, "LU");
}
void printanyf(double x) {
  PRINT(x);
}
void printanyf(char *x) {
  PRINT("\"", x, "\"");
}
void printanyf(char x) {
  PRINT("'", x, "'");
}
void printanyf(bool x) {
  PRINT(x);
}
void printanyf(long x) {
  PRINT(x, "L");
}
void printanyf(long long x) {
  PRINT(x, "LL");
}
void printanyf(void *x) {
  PRINT(x);
}

#define EQ_DIRECTLY(T) \
  bool eq(T x, T y) { \
    return x == y; \
  }
MAP(EQ_DIRECTLY, int, size_t, char, bool, void *)

bool eq(double x, double y) {
  return doubleEq(x, y);
}
bool eq(comp x, comp y) {
  return complexEq(x, y);
}
bool eq(char *x, char *y) {
  return !strcmp(x, y);
}
#pragma clang attribute pop
