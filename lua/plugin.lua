local au = vim.api.nvim_create_autocmd
local map = vim.keymap.set

local pluginOptions = require 'plugindata'

---@param plugname string
function Load_Plugin(plugname)
	if pluginOptions[plugname] then
		local pluginpath = vim.fn.stdpath('config') .. "/plugins/"
		local modname = pluginOptions[plugname].modname
		local opts = pluginOptions[plugname].opts
		local callback = pluginOptions[plugname].callback
		local dependencies = pluginOptions[plugname].dependencies
		if dependencies then
			for _, dep in ipairs(dependencies) do
				Load_Plugin(dep)
			end
		end
		vim.opt.runtimepath:append(pluginpath .. plugname)
		if opts and modname then require(modname).setup(opts) end
		if callback then callback() end
		pluginOptions[plugname] = nil
	end
end

if vim.fn.argc() == 0 then
	vim.cmd.rshada()
	Load_Plugin 'stevearc/oil.nvim'
end

au({ 'VimEnter' }, {
	callback = function()
		Load_Plugin 'folke/snacks.nvim'
	end
})

au({ 'UIEnter' }, {
	callback = function()
		Load_Plugin 'folke/flash.nvim'
		Load_Plugin 'gbprod/substitute.nvim'
		Load_Plugin 'kylechui/nvim-surround'
		Load_Plugin 'nvim-treesitter/nvim-treesitter'
		Load_Plugin 'andersevenrud/nvim_context_vt'
	end
})

local function Load_cmdln()
	require 'command'
	require 'fzf'
	Load_Plugin 'vim-jp/vimdoc-ja'
	Load_Plugin 'vim-jp/nvimdoc-ja'
	Load_Plugin 'sidebar-nvim/sidebar.nvim'
	Load_Plugin 'koron/codic-vim'
	Load_Plugin 'ThePrimeagen/refactoring.nvim'
	Load_Plugin 'stevearc/oil.nvim'
end

local cmdlnc = { ':', '/', '?' }
for _, c in ipairs(cmdlnc) do
	map({ 'n', 'v', }, c, function()
		Load_cmdln()
		vim.cmd.rshada()
		for _, cc in ipairs(cmdlnc) do
			vim.keymap.del({ 'n', 'v' }, cc)
		end
		vim.fn.feedkeys(c)
	end)
end

map('n', '^a', function()
	Load_Plugin 'zbirenbaum/copilot.lua'
	require 'copilot.suggestion'.toggle_auto_trigger()
end)

map('n', 'g/', function()
	Load_Plugin 'nvim-telescope/telescope.nvim'
	map('n', 'g/', require 'telescope.builtin'.live_grep)
	vim.fn.feedkeys 'g/'
end)

map('n', 'm', function()
	Load_Plugin 'niuiic/track.nvim'
	vim.keymap.del('n', 'm')
	vim.fn.feedkeys 'm'
end)

map('n', '<A-n>', function()
	Load_Plugin 'SmiteshP/nvim-navbuddy'
	map('n', '<A-n>', vim.cmd.Navbuddy)
	vim.cmd.Navbuddy()
end)

au({ "InsertEnter", "CmdlineEnter" }, {
	once = true,
	callback = function()
		if vim.bo.filetype ~= 'markdown' then Load_Plugin 'altermo/ultimate-autopair.nvim' end
		Load_Plugin 'saghen/blink.cmp'
	end
})

au({ "CursorMoved" }, {
	once = true,
	callback = function()
		Load_Plugin 'mini.indentscope'
		Load_Plugin 'utilyre/sentiment.nvim'
		Load_Plugin 'hadronized/hop.nvim'
		if not vim.g.neovide and vim.env.TERM ~= 'xterm-kitty' then
			Load_Plugin 'sphamba/smear-cursor.nvim'
		end
	end
})
