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
			for _, depend in ipairs(dependencies) do
				Load_Plugin(depend)
			end
		end
		vim.opt.runtimepath:append(pluginpath .. plugname)
		if opts and modname then require(modname).setup(opts) end
		if callback then callback() end
		pluginOptions[plugname] = nil
	end
end

Load_Plugin 'statusline.lua'

if vim.fn.argc() == 0 then
	vim.cmd.rshada()
	Load_Plugin 'oil.nvim'
end

au({ 'VimEnter' }, {
	callback = function()
		Load_Plugin 'snacks.nvim'
	end
})

au({ 'UIEnter' }, {
	callback = function ()
		Load_Plugin 'flash.nvim'
		Load_Plugin 'substitute.nvim'
		Load_Plugin 'nvim-surround'
	end
})

local function Load_cmdln()
	require 'command'
	require 'fzf'
	Load_Plugin 'vimdoc-ja'
	Load_Plugin 'nvimdoc-ja'
	Load_Plugin 'carbonpaper.vim'
	Load_Plugin 'sidebar.nvim'
	Load_Plugin 'codic-vim'
	Load_Plugin 'refactoring.nvim'
	Load_Plugin 'oil.nvim'
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
	Load_Plugin 'copilot.lua'
	require 'copilot.suggestion'.toggle_auto_trigger()
end)

map('n', 'g/', function()
	Load_Plugin 'telescope.nvim'
	map('n', 'g/', require 'telescope.builtin'.live_grep)
	vim.fn.feedkeys 'g/'
end)

map('n', 'm', function()
	Load_Plugin 'track.nvim'
	vim.keymap.del('n', 'm')
	vim.fn.feedkeys 'm'
end)

map('n', '<A-n>', function()
	Load_Plugin 'nvim-navbuddy'
	map('n', '<A-n>', vim.cmd.Navbuddy)
	vim.cmd.Navbuddy()
end)

au({ "InsertEnter", "CmdlineEnter" }, {
	once = true,
	callback = function()
		if vim.bo.filetype ~= 'markdown' then Load_Plugin 'ultimate-autopair.nvim' end
		Load_Plugin 'blink.cmp'
	end
})

au({ "CursorMoved" }, {
	once = true,
	callback = function()
		Load_Plugin 'mini.indentscope'
		Load_Plugin 'sentiment.nvim'
		Load_Plugin 'hop.nvim'
	end
})
