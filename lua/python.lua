local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node

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

