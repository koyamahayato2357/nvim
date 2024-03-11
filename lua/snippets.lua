local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.add_snippets({"c", "cpp"}, {
  s("inc", {
    t("#include<"), 
    i(1),
    t(".h>"),
    i(0),
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
      i(1, "expr"),
      t({") {", "    "}),
      i(2),
      t({"", "}"}),
      i(0),
  }),

  s("cas", {
      t("case "),
      i(1, "value"),
      t({":", "    "}),
      i(2, "statement"),
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

luasnip.add_snippets("lua", {
    s("key", {
        t("vim.keymap.set('"),
        i(1, "mode"),
        t("', '"),
        i(2, "before"),
        t("', '"),
        i(0, "after"),
        t("')"),
    }),

    s("use", {
        t("use '"),
        i(0, "user/repository"),
        t("'"),
    }),

    s("s", {
        t("s('"),
        i(1, "before"),
        t({"', {", "    "}),
        i(0),
        t({"", "}),"})
    }),

    s("t", {
        t("t('"),
        i(0),
        t("'),"),
    }),

    s("i", {
        t("i("),
        i(0),
        t("),"),
    }),
})

luasnip.add_snippets("python", {
    s("im", {
        t('import '),
    }),

    s('if', {
        t('if '),
        i(1, 'expr'),
        t({':', '    '}),
        i(0, 'pass'),
    }),

    s('eli', {
        t('elif '),
        i(1, 'expr'),
        t({':', '    '}),
        i(0, 'pass'),
    }),

    s('els', {
        t({'else :', '    '}),
        i(0, 'pass'),
    }),

    s('for', {
        t('for '),
        i(1, 'i'),
        t(' in '),
        i(2, 'arr'),
        t({':', '    '}),
        i(0, 'pass')
    }),

    s('whi', {
        t('while '),
        i(1, 'expr'),
        t({':', '    '}),
        i(0, 'pass'),
    }),

    s('de', {
        t('def '),
        i(1, 'f_name'),
        t({':', '    '}),
        i(0, 'pass'),
    }),
})

luasnip.add_snippets("tex", {
    s('!', {
        t({'\\documentclass[uplatex, ja=standard, a4paper]{bxjsarticle}', '\\usepackage{'}),
        i(1, 'packages'),
        t({'}', '\\title{'}),
        i(2, 'title'),
        t({'}', '\\author{'}),
        i(3, 'author name'),
        t({'}', '\\date{'}),
        i(4),
        t({'}', '', '\\begin{document}', '\\maketitle', '\\newpage', '    '}),
        i(0, '% document'),
        t({'', '\\end{document}'})
    }),

    s('beg', {
        t('\\begin{'),
        i(0),
        t('}'),
    }),

    s('end', {
        t('\\end{'),
        i(0),
        t('}'),
    }),

    s('sec', {
        t('\\section{'),
        i(0),
        t('}'),
    }),

    s('sbs', {
        t('\\subsection{'),
        i(0),
        t('}'),
    }),
})

