vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require('lazy').setup({
	{ 'folke/flash.nvim', config = function()
		local flash = require('flash')
		local map = vim.keymap.set
		map('n', 'gw', flash.remote)
		map({ 'n', 'v', 'o' }, 'gs', flash.treesitter)
		map({ 'n', 'v', 'o' }, 'gS', flash.treesitter_search)
	end, event = "VeryLazy" },
	{ 'gbprod/substitute.nvim', config = function()
		local sub = require('substitute')
		local map = vim.keymap.set
		map('n', 's', sub.operator, { noremap = true })
		map('n', 'ss', sub.line, { noremap = true })
		map('n', 'S', sub.eol, { noremap = true })
		map('x', 's', sub.visual, { noremap = true })
	end, opts = { modifiers = nil }, keys = { { "s", mode = { "n", "v" } } } },
	{ 'kylechui/nvim-surround', config = true, keys = { { "s", mode = "o" } } },
	{ 'vim-jp/vimdoc-ja', keys = { { "h", mode = "c" } } },
	{ 'vim-jp/nvimdoc-ja', keys = { { "h", mode = "c" } } },
	{ "altermo/ultimate-autopair.nvim", branch = "v0.5", config = true, event = "InsertEnter" },
	{ 's417-lama/carbonpaper.vim', keys = { { "C", mode = "c" } } },
	{ 'stevearc/oil.nvim', config = true, event = "CmdlineEnter" },
	{ 'nvim-tree/nvim-web-devicons' },
	{ 'catppuccin/nvim' },
	{ 'github/copilot.vim', keys = { { "C", mode = "c" } } },
})

