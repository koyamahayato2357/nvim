local map = vim.keymap.set

vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require('lazy').setup({
	{ 'folke/flash.nvim', config = true, event = "VimEnter" },
	{ 'gbprod/substitute.nvim', opts = { modifiers = nil }, event = "VimEnter" },
	{ 'kylechui/nvim-surround', config = true, event = "VimEnter" },
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('nvim-treesitter.configs').setup({
				auto_install = true,
				highlight = {
					enable = true
				},
			})
		end,
		event = "VimEnter",
	},
	{ 'smoka7/hop.nvim', config = true, event = "VimEnter" },
	{ 'vim-jp/vimdoc-ja', keys = { { "h", mode = "c" } } },
	{ 'vim-jp/nvimdoc-ja', keys = { { "h", mode = "c" } } },
	{ "altermo/ultimate-autopair.nvim", branch = "v0.5", config = true, event = { "InsertEnter", "CmdlineEnter" } },
	{ 'abecodes/tabout.nvim', config = true, event = "InsertEnter" },
	{ 's417-lama/carbonpaper.vim', keys = { { "C", mode = "c" } } },
	{ 'github/copilot.vim', keys = { { "C", mode = "c" } } },
})

local sub = require('substitute')
map('n', 's', sub.operator, { noremap = true })
map('n', 'ss', sub.line, { noremap = true })
map('n', 'S', sub.eol, { noremap = true })
map('x', 's', sub.visual, { noremap = true })

