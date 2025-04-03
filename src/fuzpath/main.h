#pragma once
#include <stdlib.h>

typedef struct {
  char const **buf;
  int len;
} table_t;

#define droptbl ondrop(free_tbl)

static void free_tbl(table_t *tbl) {
  free(tbl->buf);
}
