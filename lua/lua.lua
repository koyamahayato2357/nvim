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

