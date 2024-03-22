local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    { 'L3MON4D3/LuaSnip', version = 'v2.*', build = 'make install_jsregexp', config = true, event = "VeryLazy", },
    { 'folke/flash.nvim', config = true, event = "VeryLazy", },
    { 'gbprod/substitute.nvim', opts = { modifiers = nil }, event = "VeryLazy", },
    { 'kylechui/nvim-surround', config = true, event = "VeryLazy", },
    { 'neovim/nvim-lspconfig', event = "VeryLazy", },
    { 'numToStr/Comment.nvim', config = true, event = "VeryLazy", },
    { 'nvim-treesitter/nvim-treesitter', config = true, event = "VeryLazy", },
    { 'savq/melange-nvim', lazy = false },
    { 'smoka7/hop.nvim', config = true, event = "VeryLazy", },
    { 'tpope/vim-repeat', event = "VeryLazy", },
    { 'vim-jp/vimdoc-ja', event = "VeryLazy"}
    { 'windwp/nvim-autopairs', config = true, event = "VeryLazy", },
})

pcall(vim.cmd, "colorscheme melange")

local o = vim.o

o.autoread = true
o.backspace = ""
o.complete = ".,w,b,u,t,kspell"
o.completeopt = "menu,longest"
o.foldmethod = "manual"
o.gdefault = true
o.guicursor = "i:block"
o.helplang = "ja,en"
o.hidden = true
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.laststatus = 2
o.lazyredraw = true
o.matchpairs = "(:),{:},[:],<:>,=:;"
o.mouse = ""
o.number = true
o.path = ".,,,**"
o.ruler = true
o.scrolloff = 10
o.signcolumn = "yes"
o.smartcase = true
o.smartindent = true
o.statusline = "%#PmenuSel#%m%r%h%w%=%=%F%=[TYPE=%Y][POS=%l,%c,%p%%,%P][BUF=%n]"
o.termguicolors = true
o.textwidth = 79
o.tildeop = true
o.timeout = false
o.ttyfast = true
o.virtualedit = "onemore,insert"
o.wildmenu = true
o.writeany = true

vim.keymap.set("n", "<Esc>", "<cmd>nohl<CR>")
vim.keymap.set("n", "<CR>", "<C-b>")
vim.keymap.set("n", "<Space>", "<C-f>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set('n', 'ga', '<cmd>HopAnywhere<CR>')
vim.keymap.set('n', 'gL', '<cmd>HopLine<CR>')
vim.keymap.set("n", "gw", "<cmd>HopWord<CR>")
vim.keymap.set('n', 's', require("substitute").operator, { noremap = true })
vim.keymap.set('n', 'ss', require("substitute").line, { noremap = true })
vim.keymap.set('x', 's', require("substitute").visual, { noremap = true })
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set("n", "gQ", "q")
vim.keymap.set("n", "q", "ZZ")
vim.keymap.set("n", "K", "25k")
vim.keymap.set("n", "J", "25j")
vim.keymap.set('n', '^s', '<cmd>set spell!<CR>')
vim.keymap.set('n', 'zh', '<C-w>h')
vim.keymap.set('n', 'zj', '<C-w>j')
vim.keymap.set('n', 'zk', '<C-w>k')
vim.keymap.set('n', 'zl', '<C-w>l')
vim.keymap.set('n', 'zw', '<C-w>w')
vim.keymap.set('n', 'zo', '<C-w>o')
vim.keymap.set('n', 'zi', '<C-w>i')
vim.keymap.set({ 'o', 'v' }, 'K', '5k')
vim.keymap.set({ 'o', 'v' }, 'J', '5j')
vim.keymap.set({ "n", "v", "o" }, "L", "5l")
vim.keymap.set({ "n", "v", "o" }, "H", "5h")
vim.keymap.set({ "n", "v", "o" }, "gl", "$l")
vim.keymap.set({ "n", "v", "o" }, "gh", "^")

vim.keymap.set('i', '<Delete>', 'v:lua.smart_delete()', { expr = true, noremap = true })
vim.keymap.set('i', "<Tab>", 'v:lua.smart_tab()', { expr = true, noremap = true })
vim.keymap.set('i', '<Esc>', '<Right><Esc>')
vim.keymap.set('i', '<C-e>', '<C-x><C-e>')
vim.keymap.set('i', '<C-y>', '<C-x><C-y>')

vim.keymap.set('v', 'T', '<cmd>CarbonPaper<CR>')

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.cmd[[
cab nvimrc ~/.config/nvim/init.lua
iab #b /******************************************
iab # <Space>*<Space>
iab #e <Space>******************************************/
set cpoptions+=$Iv
]]

require('snippets')

function smart_delete()
    if vim.fn.pumvisible() == 0 then
        return "<Delete>"
    else
        return "<C-y>"
    end
end

function smart_tab()
    local col = vim.fn.col('.')
    if col <= 1 then
        return "\t"
    end
    local preceding_char = vim.fn.getline('.'):sub(col-1, col-1)

    if preceding_char == "\t" or preceding_char == " " then
        return "\t"
    else
        return "<C-n>"
    end
end

local lspconfig = require("lspconfig")

local ext = vim.fn.expand("%"):match("%.(%w+)$")
if ext == "c" or ext == "cpp" then
    lspconfig.clangd.setup{}
elseif ext == "py" then
    lspconfig.pyright.setup{}
elseif ext == "js" or ext == "ts" then
    lspconfig.tsserver.setup{}
elseif ext == "rs" then
    lspconfig.rust_analyzer.setup{}
end

local luasnip = require("luasnip")
vim.keymap.set({"i"}, "ŝ", function() luasnip.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "ŭ", function() luasnip.jump( 1) end, {silent = true})

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "Nontext", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", {bg = "none"})

