local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.add_snippets("all", {
    s('!', {
        t({'<!DOCTYPE html>', '<html lang="en">', '<head>', '    <meta charset="UTF-8">', '    <title>'}),
        i(1, 'Document'),
        t({'</title>', '    <link rel="stylesheet" href="style.css" />', '    <script src="write.js"></script>', '</head>', '<body>', '    '}),
        i(0),
        t({'', '</body>', '</html>'}),
    }),

    s('d', {
        t('<div>'),
        i(0),
        t('</div>'),
    }),

    s('dc', {
        t('<div class="'),
        i(1, 'class-name'),
        t('">'),
        i(0),
        t('</div>'),
    }),

    s('dci', {
        t('<div class="'),
        i(1, 'class-name'),
        t('" id="'),
        i(2, 'id-name'),
        t('">'),
        i(0),
        t('</div>'),

    }),
})

