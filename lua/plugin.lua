local au = vim.api.nvim_create_autocmd
local map = vim.keymap.set

local pluginpath = "/home/sundo/.local/share/nvim/plugins/"
vim.opt.runtimepath:append(pluginpath .. 'flash.nvim')
vim.opt.runtimepath:append(pluginpath .. 'substitute.nvim')
vim.opt.runtimepath:append(pluginpath .. 'nvim-surround')
vim.opt.runtimepath:append(pluginpath .. 'nvim')

if vim.fn.isdirectory(vim.fn.expand('%')) == 1 then
	vim.opt.runtimepath:append(pluginpath .. 'oil.nvim')
	require'oil'.setup()
	vim.opt.runtimepath:append(pluginpath .. 'nvim-web-devicons')
else
	au({ "CmdlineEnter" }, {
		once = true,
		callback = function()
			vim.opt.runtimepath:append(pluginpath .. 'oil.nvim')
			require'oil'.setup()
			vim.opt.runtimepath:append(pluginpath .. 'nvim-web-devicons')
		end
	})
end

au({ "CmdlineEnter" }, {
	once = true,
	callback = function()
		vim.opt.runtimepath:append(pluginpath .. 'vimdoc-ja')
		vim.opt.runtimepath:append(pluginpath .. 'nvimdoc-ja')
		vim.opt.runtimepath:append(pluginpath .. 'carbonpaper.vim')
	end
})

au({ "InsertEnter" }, {
	once = true,
	callback = function()
		vim.opt.runtimepath:append(pluginpath .. 'ultimate-autopair.nvim')
		vim.opt.runtimepath:append(pluginpath .. 'copilot.nvim')
		require'ultimate-autopair'.setup()
	end
})

require'flash'.setup {
	config = function()
		local flash = require('flash')
		map('n', 'gw', flash.remote)
		map({ 'n', 'v', 'o' }, 'gs', flash.treesitter)
		map({ 'n', 'v', 'o' }, 'gS', flash.treesitter_search)
	end
}

require'substitute'.setup {
	config = function()
		local sub = require('substitute')
		map('n', 's', sub.operator)
		map('n', 'ss', sub.line)
		map('n', 'S', sub.eol)
		map('x', 's', sub.visual)
	end,
	opts = { modifiers = nil },
}

require'nvim-surround'.setup()
