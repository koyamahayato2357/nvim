#include "main.h"
#include "chore.h"
#include "fs.h"
#include <luajit-2.1/lauxlib.h>
#include <luajit-2.1/lua.h>
#include <luajit-2.1/lualib.h>
#include <stdlib.h>

lua_State *L;

static table_t new_table(size_t len) {
  return (table_t){malloc(len * sizeof(char *)) ?: ({
                     luaL_error(L, "Memory alloc failed");
                     nullptr;
                   }),
                   len};
}

static bool ismatch(char const *target, char const *pattern) {
  char const *tgt = iscexist(pattern, '/') ? target : basename(target);
  for (; *tgt && *pattern; tgt++) 
    pattern += *tgt == *pattern;

  return *pattern == '\0';
}

static table_t fuzfilter(table_t tbl, char const *pat) {
  table_t ret = new_table(tbl.len);
  int id = 0;
  for (int i = 0; i < tbl.len; i++)
    if (ismatch(tbl.buf[i], pat))
      ret.buf[id++] = tbl.buf[i];

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
  static luaL_Reg const funcs[] = {{"fuzpath", fuzpath},
                                   {nullptr, nullptr}};

  luaL_newlib(L, funcs);
  return 1;
}
