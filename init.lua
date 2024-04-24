local au = vim.api.nvim_create_autocmd
local o = vim.o
local gitlens = require('gitlens')
local map = vim.keymap.set

require('colorscheme')

vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require('lazy').setup({
	{ 'neovim/nvim-lspconfig' },
	{ 'folke/flash.nvim', config = true, event = "CursorMoved" },
	{ 'gbprod/substitute.nvim', opts = { modifiers = nil }, event = "CursorMoved" },
	{ 'kylechui/nvim-surround', config = true, event = "CursorMoved" },
	{ 'numToStr/Comment.nvim', config = true, event = "CursorMoved" },
	{ 'nvim-treesitter/nvim-treesitter', build = "TSUpdate" },
	{ 'smoka7/hop.nvim', config = true, event = "CursorMoved" },
	{ 'vim-jp/vimdoc-ja' },
	{ 'windwp/nvim-autopairs', config = true, event = "CursorMoved" },
	{ 's417-lama/carbonpaper.vim' },
	{ 'github/copilot.vim', keys = { { "C", mode = "c" } } },
})

o.autoread = true
o.autowrite = true
o.backspace = ""
o.cmdheight = 1
o.complete = ".,w,b,u,t,kspell"
o.completeopt = "menu,longest,noselect"
vim.opt.cpoptions:append("$v")
o.cursorline = true
o.foldmethod = "manual"
o.gdefault = true
o.guicursor = "i:block"
o.guifont = "IBM Plex Mono,CaskaydiaCove Nerd Font Mono:h10"
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
o.omnifunc = "v:lua.vim.lsp.omnifunc"
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
o.wrap = false

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
map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>')
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
map('n', 'M', ':w<CR>:make|cw<CR>')
map('n', ']q', ':cn<CR>')
map('n', '[q', ':cp<CR>')
map({ 'o', 'v' }, 'K', '5k')
map({ 'o', 'v' }, 'J', '5j')
map({ "n", "v", "o" }, "L", "5l")
map({ "n", "v", "o" }, "H", "5h")
map({ "n", "v", "o" }, "gl", "$l")
map({ "n", "v", "o" }, "gh", "^")

map('i', "<S-Tab>", '<C-x><C-o>' )
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
]]

vim.g.netrw_liststyle = 3
vim.g.copilot_filetypes = { gitcommit = true, taml = true, markdown = true }
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_transparency = 0.7
vim.g.transparency = 0.0
vim.g.neovide_cursor_smooth_blink = true

map('n', 'gb', function() gitlens.blameVirtText() end)
function Smart_esc()
	gitlens.clearBlameVirtText()
	vim.cmd('nohl')
end

au({ "BufEnter", "BufWinEnter" }, {
	callback = function()
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
		elseif filetype == "make" or filetype == "cmake" then
			require('lspconfig').neocmake.setup{}
		end
	end
})

au({ "BufWinEnter" }, {
	pattern = "COMMIT_EDITMSG",
	callback = function()
		vim.cmd[[r!git diff --cached]]
		vim.cmd[[%s/^[^#]/#\0]]
	end
})

au({ "InsertEnter" }, {
	callback = function()
		vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
		vim.api.nvim_set_hl(0, "CursorLineNr", { underline = true })
	end
})
au({ "InsertLeave" }, {
	callback = function()
		vim.api.nvim_set_hl(0, "CursorLine", { underline = false })
		vim.api.nvim_set_hl(0, "CursorLineNr", { underline = false })
	end
})

