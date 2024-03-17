local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node

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

