#include "main.h"
#include "chore.h"
#include "fs.h"
#include <luajit-2.1/lauxlib.h>
#include <luajit-2.1/lua.h>
#include <luajit-2.1/lualib.h>
#include <stdlib.h>

lua_State *L;

#define lua_unreachable                                                        \
  ({                                                                           \
    luaL_error(L, "Memory alloc failed");                                      \
    nullptr;                                                                   \
  })

static table_t new_table(size_t len) {
  return (table_t){malloc(len * sizeof(char *)) ?: lua_unreachable, len};
}

static bool ismatch(char const *target, char const *pattern) {
  for (; *target && *pattern; target++)
    pattern += *target == *pattern;

  return *pattern == '\0';
}

static table_t fuzfilter(table_t tbl, char const *pat) {
  table_t ret = new_table(tbl.len);
  int id = 0;
  bool isfullpath = iscexist(pat, '/');
  for (int i = 0; i < tbl.len; i++) {
    char const *target = isfullpath ? tbl.buf[i] : basename(tbl.buf[i]);
    if (ismatch(target, pat))
      ret.buf[id++] = tbl.buf[i];
  }

  ret.len = id;
  return ret;
}

static int fuzpath(lua_State *arg) {
  L = arg;
  luaL_checktype(L, 1, LUA_TTABLE);
  luaL_checktype(L, 2, LUA_TSTRING);

  size_t tbl_len = lua_objlen(L, 1);

  table_t table droptbl = new_table(tbl_len);

  for (size_t i = 1; i <= tbl_len; i++) {
    lua_rawgeti(L, 1, i);
    table.buf[i - 1] = luaL_checkstring(L, -1);
    lua_pop(L, 1);
  }

  char const *pattern = luaL_checkstring(L, 2);

  table_t result droptbl = fuzfilter(table, pattern);

  lua_newtable(L);
  for (int i = 0; i < result.len; i++) {
    lua_pushstring(L, result.buf[i]);
    lua_rawseti(L, -2, i + 1);
  }
  return 1;
}

int luaopen_fuzpath(lua_State *L) {
  static luaL_Reg const funcs[] = {{"fuzpath", fuzpath}, {nullptr, nullptr}};

  luaL_newlib(L, funcs);
  return 1;
}