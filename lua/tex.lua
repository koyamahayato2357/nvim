local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node

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
})

