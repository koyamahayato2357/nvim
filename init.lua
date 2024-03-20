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
    { 'smoka7/hop.nvim', config = true },
    { 'folke/flash.nvim', config = true },
    { 'kylechui/nvim-surround', config = true },
    { 'windwp/nvim-autopairs', config = true },
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x' },
    { 'numToStr/Comment.nvim', config = true },
    { 'L3MON4D3/LuaSnip', version = 'v2.*', build = 'make install_jsregexp', config = true },
    { 'gbprod/substitute.nvim', opts = { modifiers = nil } },
    { 'jonatan-branting/nvim-better-n', config = true },
    { 'nvim-treesitter/nvim-treesitter', config = true },
    { 'folke/tokyonight.nvim', lazy = false },
    { 'rebelot/kanagawa.nvim', lazy = false },
    'tpope/vim-repeat',
    'mhinz/vim-startify',
    'neovim/nvim-lspconfig', 
    'nvim-lua/plenary.nvim',
})

pcall(vim.cmd, "colorscheme kanagawa")

local opt = vim.opt

opt.number = true
opt.foldmethod = "manual"
opt.virtualedit = "all"
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.textwidth = 79
opt.expandtab = true
opt.lazyredraw = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.ruler = true
opt.smartindent = true
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.title = true
opt.wildmenu = true
opt.scrolloff = 10
opt.laststatus = 3
opt.statusline = "%F%m%r%h%w[TYPE=%Y][POS=%l,%c,%p%%,%P][BUF=%n]"
opt.complete = ".,w,b,u,t,kspell"
opt.path = ".,,,**"
opt.completeopt = "menuone,noinsert"
opt.ttyfast = true
opt.hidden = true
opt.autoread = true

vim.keymap.set("n", "<Esc>", "<cmd>nohl<CR>")
vim.keymap.set("n", "<CR>", "<C-b>")
vim.keymap.set("n", "<Space>", "<C-f>")
vim.keymap.set("n", "<BS>", '"_X')
vim.keymap.set("n", "<Delete>", '"_x')
vim.keymap.set("n", "<S-Tab>", "<C-o>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set('n', 'ga', '<cmd>HopAnywhere<CR>')
vim.keymap.set('n', 'gL', '<cmd>HopLine<CR>')
vim.keymap.set('n', 'go', '<cmd>HopChar1<CR>')
vim.keymap.set("n", "gt", "<cmd>HopChar2<CR>")
vim.keymap.set("n", "gw", "<cmd>HopWord<CR>")
vim.keymap.set('n', 's', require("substitute").operator, { noremap = true })
vim.keymap.set('n', 'ss', require("substitute").line, { noremap = true })
vim.keymap.set('n', 'S', require("substitute").eol, { noremap = true })
vim.keymap.set('x', 's', require("substitute").visual, { noremap = true })
vim.keymap.set("n", ",z", "<cmd>Telescope find_files<CR>")
vim.keymap.set('n', ',b', '<cmd>Telescope buffers<CR>')
vim.keymap.set("n", ",l", "<cmd>Telescope live_grep<CR>")
vim.keymap.set('n', ",/", "<cmd>Telescope current_buffer_fuzzy_find<CR>")
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'U', '<C-r>')
vim.keymap.set('n', "v", "<C-v>")
vim.keymap.set('n', "<C-v>", "v")
vim.keymap.set("n", "gQ", "q")
vim.keymap.set("n", "q", "ZZ")
vim.keymap.set("n", "zz", "<cmd>wqa<CR>")
vim.keymap.set('v', '"+y', '<cmd>!win32yank.exe -i --crlf<CR>')
vim.keymap.set('n', '"+p', '<cmd>r!win32yank.exe -o --lf<CR>')
vim.keymap.set("n", "K", "25k")
vim.keymap.set("n", "J", "25j")
vim.keymap.set({ 'o', 'v' }, 'K', '5k')
vim.keymap.set({ 'o', 'v' }, 'J', '5j')
vim.keymap.set({ "n", "v", "o" }, "L", "5l")
vim.keymap.set({ "n", "v", "o" }, "H", "5h")
vim.keymap.set({ "n", "v", "o" }, "gl", "$")
vim.keymap.set({ "n", "v", "o" }, "gh", "^")

vim.keymap.set('i', '<Delete>', 'v:lua.smart_delete()', { expr = true, noremap = true })
vim.keymap.set('i', "<Tab>", 'v:lua.smart_tab()', { expr = true, noremap = true })
vim.keymap.set('i', '<Esc>', 'v:lua.smart_esc()', { expr = true, noremap = true })

vim.keymap.set('v', 'T', '<cmd>CarbonPaper<CR>')

vim.cmd[[
cab nvimrc ~/.config/nvim/init.lua
cab help Telescope help_tags
set cpoptions+=$
set cpoptions+=I
set cpoptions+=v
]]

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
        -- vim.api.nvim_out_write(preceding_char)
        return "<C-n>"
    end
end

function smart_esc()
    if vim.fn.col('.') == 1 then
        return "<Esc>"
    else
        return "<Esc>l"
    end
end

local lspconfig = require("lspconfig")

local ext = vim.fn.expand("%"):match("%.(%w+)$")
if ext == "c" or ext == "cpp" then
    lspconfig.clangd.setup{}
    require('c')
elseif ext == "py" then
    lspconfig.pyright.setup{}
    require('python')
elseif ext == "html" then
    require("html")
elseif ext == "js" or ext == "ts" then
    lspconfig.tsserver.setup{}
elseif ext == "rs" then
    lspconfig.rust_analyzer.setup{}
elseif ext == "tex" then
    require('tex')
elseif ext == "hs" then
elseif ext == "lua" then
    require("lua")
end

local luasnip = require("luasnip")
vim.keymap.set({"i"}, "ŝ", function() luasnip.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "ŭ", function() luasnip.jump( 1) end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<C-J>", function() luasnip.jump(-1) end, {silent = true})

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "Nontext", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", {bg = "none"})

