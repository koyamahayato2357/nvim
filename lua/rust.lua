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
})
