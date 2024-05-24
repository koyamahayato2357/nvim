local au = vim.api.nvim_create_autocmd
local map = vim.keymap.set
local hi = vim.api.nvim_set_hl

local plugopts = {
	['flash.nvim'] = {
		modname = 'flash',
		opts = {},
		callback = function()
			local flash = require 'flash'
			flash.toggle(true)
			map('n', 'gw', flash.remote)
			map({ 'n', 'v', 'o' }, 'gs', flash.treesitter)
			map({ 'n', 'v', 'o' }, 'gS', flash.treesitter_search)
		end
	},
	['substitute.nvim'] = {
		modname = 'substitute',
		callback = function()
			local sub = require 'substitute'
			map('n', 's', sub.operator)
			map('n', 'ss', sub.line)
			map('n', 'S', sub.eol)
			map('x', 's', sub.visual)
		end
	},
	['nvim-surround'] = {
		modname = 'nvim-surround',
		opts = {},
	},
	['oil.nvim'] = {
		modname = 'oil',
		opts = {
			columns = {
				'icon',
				'permission',
				'size',
				'mtime'
			},
		},
		callback = function()
			local oil = require 'oil'
			map('n', '^o', function() oil.toggle_float() end)
		end
	},
	['nvim'] = {
		modname = 'nvim',
		callback = function()
			vim.cmd.colorscheme 'catppuccin'
			hi(0, "Normal", { bg = "none" })
			hi(0, "NormalNC", { bg = "none" })
			hi(0, "CursorLine", { bg = "none" })
			hi(0, "CursorLineNC", { bg = "none" })
			hi(0, "CursorLineNr", { bg = "none" })
			hi(0, "StatusLine", { bg = "none" })
		end
	},
	['toggleterm.nvim'] = {
		modname = 'toggleterm',
		opts = {
			direction = "float"
		},
		callback = function()
			local toggleterm = require 'toggleterm'
			map('n', '^t', function() toggleterm.toggle() end)
		end
	},
	['dashboard-nvim'] = {
		modname = 'dashboard',
		opts = {},
		callback = vim.cmd.rshada
	},
	['vimdoc-ja'] = {},
	['nvimdoc-ja'] = {},
	['carbonpaper.vim'] = {},
	['sidebar.nvim'] = {
		modname = 'sidebar-nvim',
		opts = {
			open = false,
			initial_width = 20,
		},
		callback = function()
			local sidebar = require 'sidebar-nvim'
			vim.api.nvim_create_user_command("B", sidebar.toggle, {})
		end
	},
	['nui.nvim'] = {},
	['noice.nvim'] = {
		modname = 'noice',
		opts = {
			cmdline = {
				view = "cmdline"
			},
			messages = {
				enabled = false
			},
			notify = {
				enabled = false
			}
		},
	},
	['ultimate-autopair.nvim'] = {
		modname = 'ultimate-autopair',
		opts = {},
	},
	['mini.indentscope'] = {
		modname = 'mini.indentscope',
		opts = {},
	},
	['sentiment.nvim'] = {
		modname = 'sentiment',
		opts = {},
	},
	['nvim-web-devicons'] = {}
}

---@param plugname string
local function addplug(plugname)
	if plugopts[plugname] then
		local pluginpath = "/home/sundo/.config/nvim/plugins/"
		local modname = plugopts[plugname].modname
		local opts = plugopts[plugname].opts
		local callback = plugopts[plugname].callback
		vim.opt.runtimepath:append(pluginpath .. plugname)
		if opts and modname then require(modname).setup(opts) end
		if callback then callback() end
		plugopts[plugname] = nil
	end
end

if vim.fn.argc() == 0 then
	addplug 'nvim-web-devicons'
	addplug 'oil.nvim'
	addplug 'dashboard-nvim'
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
	end
})

map('n', ':', function()
	addplug 'vimdoc-ja'
	addplug 'nvimdoc-ja'
	addplug 'carbonpaper.vim'
	addplug 'sidebar.nvim'
	addplug 'nui.nvim'
	addplug 'noice.nvim'
	map('n', ':', ':')
	vim.api.nvim_input ':'
end
)

au({ "InsertEnter" }, {
	once = true,
	callback = function()
		addplug 'ultimate-autopair.nvim'
	end
})

au({ "CursorMoved" }, {
	once = true,
	callback = function()
		addplug 'mini.indentscope'
		addplug 'sentiment.nvim'
	end
})
