local au = vim.api.nvim_create_autocmd
local map = vim.keymap.set

local pluginOptions = require 'plugindata'

---@param plugname string
function Load_plugin(plugname)
	if pluginOptions[plugname] then
		local pluginpath = vim.fn.stdpath('config') .. "/plugins/"
		local modname = pluginOptions[plugname].modname
		local opts = pluginOptions[plugname].opts
		local callback = pluginOptions[plugname].callback
		local dependencies = pluginOptions[plugname].dependencies
		if dependencies then
			for _, dep in ipairs(dependencies) do
				Load_plugin(dep)
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
	Load_plugin 'stevearc/oil.nvim'
end

au({ 'VimEnter' }, {
	callback = function()
		Load_plugin 'folke/snacks.nvim'
	end
})

au({ 'UIEnter' }, {
	callback = function()
		Load_plugin 'folke/flash.nvim'
		Load_plugin 'gbprod/substitute.nvim'
		Load_plugin 'kylechui/nvim-surround'
		Load_plugin 'andersevenrud/nvim_context_vt'
	end
})

local function Load_cmdln()
	require 'command'
	require 'fzf'
	Load_plugin 'vim-jp/vimdoc-ja'
	Load_plugin 'vim-jp/nvimdoc-ja'
	Load_plugin 'stevearc/oil.nvim'
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
	Load_plugin 'zbirenbaum/copilot.lua'
	local sug = require 'copilot.suggestion'
	map('n', '^a', sug.toggle_auto_trigger)
	sug.toggle_auto_trigger()
end)

map('n', 'g/', function()
	Load_plugin 'nvim-telescope/telescope.nvim'
	local tb = require 'telescope.builtin'
	map('n', 'g/', tb.live_grep)
	tb.live_grep()
end)

map('n', 'm', function()
	Load_plugin 'niuiic/track.nvim'
	vim.keymap.del('n', 'm')
	vim.fn.feedkeys 'm'
end)

map('n', '<A-n>', function()
	Load_plugin 'SmiteshP/nvim-navbuddy'
	map('n', '<A-n>', vim.cmd.Navbuddy)
	vim.cmd.Navbuddy()
end)

au({ "InsertEnter", "CmdlineEnter" }, {
	once = true,
	callback = function()
		if vim.bo.filetype ~= 'markdown' then Load_plugin 'altermo/ultimate-autopair.nvim' end
	end
})

au({ "CursorMoved" }, {
	once = true,
	callback = function()
		Load_plugin 'mini.indentscope'
		Load_plugin 'utilyre/sentiment.nvim'
		Load_plugin 'hadronized/hop.nvim'
		-- if not vim.g.neovide and vim.env.TERM ~= 'xterm-kitty' then
		-- 	Load_Plugin 'sphamba/smear-cursor.nvim'
		-- end
	end
})
