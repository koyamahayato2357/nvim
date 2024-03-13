local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node

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
        t({' {', '    '}}),
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
