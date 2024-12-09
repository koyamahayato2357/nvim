#include "fs.h"
#include <string.h>

char const *basename(char const *path) {
  char const *last = strrchr(path, '/');
  return last ? last + 1 : path;
}

bool iscexist(char const *str, char c) {
  return strchr(str, c) != nullptr;
}
