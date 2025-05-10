/**
 * @file src/chore.c
 * @brief Define util functions
 */

#include "chore.h"
#include "exproriented.h"
#include "mathdef.h"
#include "testing.h"

/**
 * @brief Check if the decimal part is 0
 * @param[in] arg Checked double number
 * @return Is decimal part 0
 */
inline bool isInt(double arg) {
  if (isinf(arg) || isnan(arg)) return false;
  if (arg < -__LONG_MAX__ - 1L || (double)__LONG_MAX__ < arg) return false;
  return arg == (double)(long)arg;
}

test_table(
  isint, isInt, (bool, double),
  {
    { true,      5.0},
    { true,    3.000},
    { true,      100},
    { true,      -10},
    {false,      5.6},
    {false,     10.9},
    {false, 99.99999},
    {false,    -10.4}
}
)

/**
 * @brief panic alloc
 * @param[in] sz Memory size
 * @warning Unrecoverable
 */
void *palloc(size_t sz) {
  return malloc(sz) ?: p$panic(ERR_ALLOCATION_FAILURE);
}

/**
 * @brief free for drop
 */
void freecl(void *p) {
  free(*bit_cast(void **, p));
}
void fclosecl(FILE **fp) {
  fclose(*fp);
}
void closedircl(DIR **fp) {
  closedir(*fp);
}
