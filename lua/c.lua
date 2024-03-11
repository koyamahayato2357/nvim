local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.add_snippets("c", {
  s("inc", {
    t("#include<"), 
    i(1),
    t(".h>"),
    i(0),
  }),

  s("def", {
      t('#define '),
      i(1, 'DEFNAME'),
      t(' '),
      i(0, 'VALUE')
  }),

  s("if", {
      t("if("),
      i(1),
      t({") {", "    "}),
      i(2),
      t({"", "}"}),
      i(0)
  }),

  s("eli", {
      t("else if("),
      i(1),
      t({") {", "    "}),
      i(2),
      t({"", "}"}),
      i(0),
  }),

  s("els", {
      t({"else {", ""}),
      i(1),
      t({"", "}"}),
      i(0),
  }),

  s("for", {
      t("for("),
      i(1),
      t("; "),
      i(2),
      t("; "),
      i(3),
      t({") {", "    "}),
      i(4),
      t({"", "}"}),
      i(0),
  }),

  s("switch", {
      t("switch("),
      i(1, "EXPR"),
      t({") {", "    "}),
      i(2),
      t({"", "}"}),
      i(0),
  }),

  s("cas", {
      t("case "),
      i(1, "VALUE"),
      t({":", "    "}),
      i(2, "STATEMENT"),
      t({";", "break;"}),
      i(0)

  }),

  s("pri", {
      t('printf("'),
      i("1"),
      t('"'),
      i(0),
      t(");"),
  }),

})


