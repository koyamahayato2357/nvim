/**
 * @file src/chore.c
 * @brief Define util functions
 */

#include "chore.h"
#include <stdlib.h>

/**
 * @brief free for drop
 */
void freecl(void *p) {
  free(*(void **)p);
}
void fclosecl(FILE **fp) {
  fclose(*fp);
}
void closedircl(DIR **fp) {
  closedir(*fp);
}
