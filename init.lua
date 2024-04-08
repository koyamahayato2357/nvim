require('colorscheme')

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
	'vim-jp/vimdoc-ja',
	{ 'windwp/nvim-autopairs', config = true, keys = { { "U", mode = "n", }, }, },
	{ 'github/copilot.vim', keys = { { "C", mode = "c" }, }, },
})

local o = vim.o

o.autoread = true
o.backspace = ""
o.cmdheight = 0
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
o.listchars = "tab:│ ,trail:×,extends:>,precedes:<,nbsp:+"
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

local map = vim.keymap.set

map("n", "<Esc>", function() Smart_esc() end)
map("n", "<BS>", "<C-b>")
map("n", "<Delete>", "<C-f>")
map('n', '<C-S-e>', '5<C-e>')
map('n', '<C-S-y>', '5<C-y>')
map('n', 'x', '<Nop>')
map('n', 'X', 'd^')
map('n', 'S', 'c^')
map("n", "xd", "<cmd>bd<CR>")
map("n", "xb", "<cmd>b#<CR>")
map("n", "xe", "<cmd>Explore<CR>")
map('n', 'xq', '<cmd>make | cw<CR>')
map('n', 'ga', '<cmd>HopAnywhere<CR>')
map('n', 'gL', '<cmd>HopLine<CR>')
map("n", "gw", "<cmd>HopWord<CR>")
map('n', '<Space><Space>', 'gg=G<C-o>')
map('n', 's', require("substitute").operator, { noremap = true })
map('n', 'ss', require("substitute").line, { noremap = true })
map('n', 'S', require("substitute").eol, { noremap = true })
map('x', 's', require("substitute").visual, { noremap = true })
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
map('n', 'ge', 'G')
map("n", "Q", "q")
map("n", "q", "ZZ")
map("n", "K", "25k")
map("n", "J", "25j")
map('n', '^s', '<cmd>set spell!<CR>')
map('n', '^r', '<cmd>set relativenumber!<CR>')
map('n', 'zh', '<C-w>h')
map('n', 'zj', '<C-w>j')
map('n', 'zk', '<C-w>k')
map('n', 'zl', '<C-w>l')
map('n', 'zw', '<C-w>w')
map('n', 'zo', '<C-o>')
map('n', 'zi', '<C-i>')
map("n", "zs", "m'")
map('n', '<Space>', '<Nop>')
map('n', '<CR>', '<Nop>')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map({ 'o', 'v' }, 'K', '5k')
map({ 'o', 'v' }, 'J', '5j')
map({ "n", "v", "o" }, "L", "5l")
map({ "n", "v", "o" }, "H", "5h")
map({ "n", "v", "o" }, "gl", "$l")
map({ "n", "v", "o" }, "gh", "^")

map('i', "<S-Tab>", 'v:lua.Smart_tab()', { expr = true, noremap = true })
map('i', '<Esc>', '<Right><Esc>')
map('i', '<C-e>', '<C-x><C-e>')
map('i', '<C-y>', '<C-x><C-y>')
map('i', '<C-f>', '<C-x><C-f>')
map('i', 'e', 'pumvisible() ? "<C-e>" : "e"', { expr = true, noremap = true })
map('i', 'y', 'pumvisible() ? "<C-y>" : "y"', { expr = true, noremap = true })
map('i', 'n', 'pumvisible() ? "<C-n>" : "n"', { expr = true, noremap = true })
map('i', 'p', 'pumvisible() ? "<C-p>" : "p"', { expr = true, noremap = true })

map('v', '<C-k>', ":m '<-2<CR>gv=gv")
map('v', '<C-j>', ":m '>+1<CR>gv=gv")
map('v', 'v', "<C-v>")
map('v', 'aa', 'VggoG')

map('o', '2', 'i"')
map('o', '7', "i'")
map('o', '9', 'i(')
map('o', ']', 'i]')
map('o', '}', 'i}')
map('o', '.', 'i>')

vim.cmd[[
cab nvimrc ~/.config/nvim/init.lua
iab #b /******************************************
iab # <Space>*<Space>
iab #e <Space>******************************************/
set cpoptions+=$Iv
]]

vim.g.netrw_liststyle = 3
vim.g.copilot_filetypes = { gitcommit = true, taml = true, markdown = true }

function Smart_tab()
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

local gitlens = require('gitlens')
map('n', 'gb', function() gitlens.blameVirtText() end)
function Smart_esc()
	gitlens.clearBlameVirtText()
	vim.cmd('nohl')
end

function Lsp_setup()
	local filetype = vim.bo.filetype
	if filetype == "c" or filetype == "cpp" then
		require('lspconfig').clangd.setup{}
	elseif filetype == "python" then
		require('lspconfig').pylyzer.setup{}
	elseif filetype == "javascript" or filetype == "typescript" then
		require('lspconfig').tsserver.setup{}
	elseif filetype == "rust" then
		require('lspconfig').rust_analyzer.setup{}
	elseif filetype == "lua" then
		require('lspconfig').lua_ls.setup{
			settings = {
				Lua = {
					diagnostics = {
						globals = {
							'vim'
						}
					}
				}
			}
		}
	elseif filetype == "tex" then
		require('lspconfig').texlab.setup{}
	elseif filetype == "asm" then
		require('lspconfig').asm_lsp.setup{}
	elseif filetype == "verilog" then
		require('lspconfig').svls.setup{}
	elseif filetype == "make" or filetype == "cmake" then
		require('lspconfig').neocmake.setup{}
	end
end


vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	callback = function() Lsp_setup() end
})

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	command = "hi CursorLine gui=underline | hi CursorLineNr gui=underline"
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	command = "hi CursorLine gui=none | hi CursorLineNr gui=none"
})

