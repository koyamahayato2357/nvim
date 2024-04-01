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
	{ 'neovim/nvim-lspconfig', event = "VeryLazy", },
	{ 'folke/flash.nvim', config = true, keys = { { "U", mode = "n" }, }, },
	{ 'gbprod/substitute.nvim', opts = { modifiers = nil }, keys = { { "U", mode = "n", }, }, },
	{ 'kylechui/nvim-surround', config = true, keys = { { "U", mode = "n", }, }, },
	{ 'numToStr/Comment.nvim', config = true, keys = { { "U", mode = "n", }, }, },
	{ 'nvim-treesitter/nvim-treesitter', config = true, event = "VeryLazy", },
	{ 'smoka7/hop.nvim', config = true, keys = { { "U", mode = "n", }, }, },
	{ 'tpope/vim-repeat', keys = { { "U", mode = "n", }, }, },
	'vim-jp/nvimdoc-ja',
	'vim-jp/vimdoc-ja',
	{ 'windwp/nvim-autopairs', config = true, keys = { { "U", mode = "n", }, }, },
	{ 'savq/melange-nvim', keys = { { "c", mode = "c", }, }, },
	{ 'kihachi2000/yash.nvim', keys = { { "c", mode = "c" }, }, },
})

require('colorscheme')

local o = vim.o

o.autoread = true
o.backspace = ""
o.complete = ".,w,b,u,t,kspell"
o.completeopt = "menu,longest,noselect"
o.cursorline = true
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
o.list = true
o.listchars = "tab:>-,trail:*,extends:>,precedes:<,nbsp:+"
o.matchpairs = "(:),{:},[:],<:>,=:;"
o.mouse = ""
o.number = true
o.path = ".,,,**"
o.ruler = true
o.scrolloff = 10
o.shiftwidth = 4
o.signcolumn = "yes"
o.smartcase = true
o.smartindent = true
o.statusline = "%m%r%h%w%=%=%F%=[TYPE=%Y][POS=%l,%c,%p%%,%P][BUF=%n]"
o.tabstop = 4
o.termguicolors = true
o.textwidth = 79
o.tildeop = true
o.timeout = false
o.ttyfast = true
o.virtualedit = "onemore,insert"
o.wildmenu = true
o.writeany = true

vim.keymap.set("n", "<Esc>", "<cmd>nohl<CR>")
vim.keymap.set("n", "<BS>", "<C-b>")
vim.keymap.set("n", "<Delete>", "<C-f>")
vim.keymap.set('n', '<C-S-e>', '5<C-e>')
vim.keymap.set('n', '<C-S-y>', '5<C-y>')
vim.keymap.set('n', 'x', '<Nop>')
vim.keymap.set('n', 'X', 'd^')
vim.keymap.set('n', 'S', 'c^')
vim.keymap.set("n", "xd", "<cmd>bd<CR>")
vim.keymap.set("n", "xb", "<cmd>b#<CR>")
vim.keymap.set('n', 'xq', '<cmd>make | cw<CR>')
vim.keymap.set('n', '<Space>a', '<cmd>HopAnywhere<CR>')
vim.keymap.set('n', '<Space>l', '<cmd>HopLine<CR>')
vim.keymap.set("n", "<Space>w", "<cmd>HopWord<CR>")
vim.keymap.set('n', '<Space><Space>', 'gg=G<C-o>')
vim.keymap.set('n', 's', require("substitute").operator, { noremap = true })
vim.keymap.set('n', 'ss', require("substitute").line, { noremap = true })
vim.keymap.set('x', 's', require("substitute").visual, { noremap = true })
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'ge', 'G')
vim.keymap.set("n", "gQ", "q")
vim.keymap.set("n", "q", "ZZ")
vim.keymap.set("n", "K", "25k")
vim.keymap.set("n", "J", "25j")
vim.keymap.set('n', '^s', '<cmd>set spell!<CR>')
vim.keymap.set('n', '^r', '<cmd>set relativenumber!<CR>')
vim.keymap.set('n', 'zh', '<C-w>h')
vim.keymap.set('n', 'zj', '<C-w>j')
vim.keymap.set('n', 'zk', '<C-w>k')
vim.keymap.set('n', 'zl', '<C-w>l')
vim.keymap.set('n', 'zw', '<C-w>w')
vim.keymap.set('n', 'zo', '<C-o>')
vim.keymap.set('n', 'zi', '<C-i>')
vim.keymap.set("n", "zs", "m'")
vim.keymap.set('n', '<Space>', '<Nop>')
vim.keymap.set('n', '<CR>', '<Nop>')
vim.keymap.set({ 'o', 'v' }, 'K', '5k')
vim.keymap.set({ 'o', 'v' }, 'J', '5j')
vim.keymap.set({ "n", "v", "o" }, "L", "5l")
vim.keymap.set({ "n", "v", "o" }, "H", "5h")
vim.keymap.set({ "n", "v", "o" }, "gl", "$l")
vim.keymap.set({ "n", "v", "o" }, "gh", "^")

vim.keymap.set('i', "<Tab>", 'v:lua.smart_tab()', { expr = true, noremap = true })
vim.keymap.set('i', '<Esc>', '<Right><Esc>')
vim.keymap.set('i', '<C-e>', '<C-x><C-e>')
vim.keymap.set('i', '<C-y>', '<C-x><C-y>')
vim.keymap.set('i', '<C-f>', '<C-x><C-f>')
vim.keymap.set('i', 'e', 'pumvisible() ? "<C-e>" : "e"', { expr = true, noremap = true })
vim.keymap.set('i', 'y', 'pumvisible() ? "<C-y>" : "y"', { expr = true, noremap = true })
vim.keymap.set('i', 'n', 'pumvisible() ? "<C-n>" : "n"', { expr = true, noremap = true })
vim.keymap.set('i', 'p', 'pumvisible() ? "<C-p>" : "p"', { expr = true, noremap = true })

vim.keymap.set('v', 'T', '<cmd>CarbonPaper<CR>')
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'v', "<C-v>")
vim.keymap.set('v', 'aa', 'VggoG')

vim.keymap.set('o', '2', 'i"')
vim.keymap.set('o', '7', "i'")
vim.keymap.set('o', '9', 'i(')
vim.keymap.set('o', ']', 'i]')
vim.keymap.set('o', '}', 'i}')
vim.keymap.set('o', '.', 'i>')

vim.cmd[[
cab nvimrc ~/.config/nvim/init.lua
iab #b /******************************************
iab # <Space>*<Space>
iab #e <Space>******************************************/
set cpoptions+=$Iv
highlight LineNr guifg=#83866c
highlight CursorLineNr guifg=#c5d6b9
]]

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
	lspconfig.pylyzer.setup{}
elseif ext == "js" or ext == "ts" then
	lspconfig.tsserver.setup{}
elseif ext == "rs" then
	lspconfig.rust_analyzer.setup{}
elseif ext == "lua" then
	lspconfig.lua_ls.setup{}
elseif ext == "tex" then
	lspconfig.texlab.setup{}
elseif ext == "asm" then
	lspconfig.asm_lsp.setup{}
elseif ext == "v" then
	lspconfig.svls.setup{}
end

