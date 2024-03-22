local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.add_snippets("c", {
  s("inc", {
    t("#include <"), 
    i(1),
    t({".h>", ""}),
    i(0),
  }),

  s("def", {
      t('#define '),
      i(1, 'DEFNAME'),
      t(' '),
      i(2, 'VALUE'),
      i(0),
  }),

  s("if", {
      t("if ("),
      i(1, "expr"),
      t({") {", "    "}),
      i(2),
      t({"", "}"}),
      i(0)
  }),

  s("eli", {
      t("else if ("),
      i(1, "expr"),
      t({") {", "    "}),
      i(2),
      t({"", "}"}),
      i(0),
  }),

  s("els", {
      t({"else {", "    "}),
      i(1),
      t({"", "}"}),
      i(0),
  }),

  s("for", {
      t("for ("),
      i(1, "initalize"),
      t("; "),
      i(2, "expr"),
      t("; "),
      i(3, "incr"),
      t({") {", "    "}),
      i(4),
      t({"", "}"}),
      i(0),
  }),

  s("switch", {
      t("switch ("),
      i(1, "expr"),
      t({") {", "    "}),
      i(2),
      t({"", "}"}),
      i(0),
  }),

  s("cas", {
      t("case "),
      i(1, "VALUE"),
      t({":", "    "}),
      i(2),
      t({";", "break;"}),
      i(0)

  }),

  s("pri", {
      t('printf("'),
      i(1, "format"),
      t('"'),
      i(2, "args..."),
      t(");"),
      i(0),
  }),

})

luasnip.add_snippets("lua", {
    s("key", {
        t("vim.keymap.set('"),
        i(1, "mode"),
        t("', '"),
        i(2, "before"),
        t("', '"),
        i(3, "after"),
        t("')"),
        i(0),
    }),

    s('if', {
        t('if '),
        i(1, 'expr'),
        t({' then', '    '}),
        i(2),
        t({'', 'end'})
    }),

    s('fun', {
        t('function '),
        i(1, 'f_name'),
        t('('),
        i(2),
        t({')', '    '}),
        i(3),
        t({'', 'end'}),
    }),

    s("s", {
        t("s('"),
        i(1, "before"),
        t({"', {", "    "}),
        i(2),
        t({"", "}),"}),
        i(0),
    }),

    s("t", {
        t("t('"),
        i(1),
        t("'),"),
        i(0),
    }),

    s("i", {
        t("i("),
        i(1),
        t("),"),
        i(0),
    }),
})

luasnip.add_snippets("python", {
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

luasnip.add_snippets("rust", {
    s('fn', {
        t('function '),
        i(1, 'fn_name'),
        t('('),
        i(2, 'arg'),
        t({') {', '    '}),
        i(3, 'statement;'),
        t('', '}', ''),
        i(0),
    }),

    s('if', {
        t('if '),
        i(1, 'expr'),
        t({' {', '    '}),
        i(2, 'statement;'),
        t({'', '}'}),
        i(0),
    }),

    s('eli', {
        t('else if '),
        i(1, 'expr'),
        t({' {', '    '}),
        i(2, 'statement;'),
        t({'', '}'}),
        i(0),
    }),

    s('els', {
        t({'else {', '    '}),
        i(1, 'statement;'),
        t({'', '}'}),
        i(0),
    }),

    s('for', {
        t('for '),
        i(1, 'i'),
        t(' in '),
        i(2, 'arrs'),
        t({' {', '    '}),
        i(3, 'statement;'),
        t({'', '}'}),
        i(0),
    }),

    s('whi', {
        t('while '),
        i(1, 'expr'),
        t({' {', '    '}),
        i(2, 'statement;'),
        t({'', '}'}),
        i(0),
    }),

    s('mat', {
        t('match '),
        i(1, 'expr'),
        t({' {', '    '}),
        i(2, 'pattern'),
        t(' => '),
        i(3, 'statement'),
        t(','),
        i(0),
    }),

    s('pat', {
        i(1, 'pattern'),
        t(' => '),
        i(2, 'statement'),
        t(','),
        i(0),
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
        i(1),
        t('}'),
        i(0),
        
    }),

    s('end', {
        t('\\end{'),
        i(1),
        t('}'),
        i(0),
        
    }),

    s('sec', {
        t('\\section{'),
        i(1),
        t('}'),
        i(0),
        
    }),

    s('sbs', {
        t('\\subsection{'),
        i(1),
        t('}'),
        i(0),
    }),

    s('equ', {
        t({'\\begin{equation}', ''}),
        i(1, 'equation'),
        t({'', '\\end{equation}'}),
        i(0),
    }),

    s('item', {
        t({'\\begin{itemize}', '    \\item{'}),
        i(1, 'Item'),
        t('}'),
        i(2),
        t({'', '\\end{itemize}'}),
        i(0),
    }),

    s('enum', {
        t({'\\begin{enumerate}', '    \\item{'}),
        i(1, 'Item'),
        t('}'),
        i(2),
        t({'', '\\end{itemize}'}),
        i(0),
    }),

    s('ite', {
        t('\\item{'),
        i(1, 'Item'),
        t('}'),
        i(0),
    }),
})

