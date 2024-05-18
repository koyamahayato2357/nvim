local au = vim.api.nvim_create_autocmd
local map = vim.keymap.set
local hi = vim.api.nvim_set_hl

---@param plugname string
local function addplug(plugname)
	local pluginpath = "/home/sundo/.config/nvim/plugins/"
	vim.opt.runtimepath:append(pluginpath .. plugname)
end

if vim.fn.argc() == 0 then
	addplug 'dashboard-nvim'
	require 'dashboard'.setup {}
end

au({ 'VimEnter' }, {
	callback = function()
		addplug 'flash.nvim'
		addplug 'substitute.nvim'
		addplug 'nvim-surround'
		addplug 'nvim'
		addplug 'toggleterm.nvim'
		addplug 'nvim-web-devicons'
		addplug 'oil.nvim'
		vim.cmd.colorscheme 'catppuccin'
		hi(0, "Normal", { bg = "none" })
		hi(0, "NormalNC", { bg = "none" })
		hi(0, "CursorLine", { bg = "none" })
		hi(0, "CursorLineNC", { bg = "none" })
		hi(0, "CursorLineNr", { bg = "none" })
		hi(0, "StatusLine", { bg = "none" })
		local flash = require 'flash'
		flash.setup {}
		flash.toggle(true)
		map('n', 'gw', flash.remote)
		map({ 'n', 'v', 'o' }, 'gs', flash.treesitter)
		map({ 'n', 'v', 'o' }, 'gS', flash.treesitter_search)
		local sub = require 'substitute'
		map('n', 's', sub.operator)
		map('n', 'ss', sub.line)
		map('n', 'S', sub.eol)
		map('x', 's', sub.visual)
		require 'nvim-surround'.setup()
		local oil = require 'oil'
		oil.setup {
			columns = {
				'icon',
				'permission',
				'size',
				'mtime'
			},
		}
		map('n', '^o', function() oil.toggle_float() end)
		local toggleterm = require 'toggleterm'
		toggleterm.setup {
			direction = "float"
		}
		map('n', '^t', function() toggleterm.toggle() end)
	end
})

map('n', ':', function()
	addplug 'vimdoc-ja'
	addplug 'nvimdoc-ja'
	addplug 'carbonpaper.vim'
	addplug 'sidebar.nvim'
	addplug 'nui.nvim'
	addplug 'noice.nvim'
	local sidebar = require 'sidebar-nvim'
	sidebar.setup({
		open = false,
		initial_width = 20,
	})
	vim.api.nvim_create_user_command("B", sidebar.toggle, {})
	require 'noice'.setup {
		cmdline = {
			view = "cmdline"
		},
		messages = {
			enabled = false
		},
		notify = {
			enabled = false
		}
	}
	map('n', ':', ':')
	vim.api.nvim_input ':'
end
)

au({ "InsertEnter" }, {
	once = true,
	callback = function()
		addplug 'ultimate-autopair.nvim'
		require 'snippets'
		require 'ultimate-autopair'.setup()
	end
})

au({ "CursorMoved" }, {
	once = true,
	callback = function()
		addplug 'mini.indentscope'
		addplug 'sentiment.nvim'
		require 'mini.indentscope'.setup {}
		require 'sentiment'.setup()
	end
})
