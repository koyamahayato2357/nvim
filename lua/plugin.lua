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
			hi(0, "Normal", { bg = "None" })
			hi(0, "NormalNC", { bg = "None" })
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
		opts = {
			tabout = {
				enable = true,
				map = '<S-Tab>',
				cmap = '<S-Tab>',
				hopout = true,
			}
		},
	},
	['mini.indentscope'] = {
		modname = 'mini.indentscope',
		opts = {},
	},
	['sentiment.nvim'] = {
		modname = 'sentiment',
		opts = {},
	},
	['nvim-web-devicons'] = {},
	['core.nvim'] = {},
	['track.nvim'] = {
		modname = 'track',
		opts = {},
		callback = function()
			local track = require 'track'
			local markfile = vim.fn.stdpath('config') .. '/marks/mark.json'
			map('n', 'mm', track.toggle)
			map('n', 'md', track.remove)
			map('n', 'mk', track.jump_to_prev)
			map('n', 'mj', track.jump_to_next)
			map('n', 'me', track.edit)
			map('n', 'ms', function() track.store(markfile) end)
			map('n', 'mr', function() track.restore(markfile) end)
		end
	},
	['plenary.nvim'] = {},
	['telescope.nvim'] = {
		modname = 'telescope',
		opts = {},
	},
	['hop.nvim'] = {
		modname = 'hop',
		opts = {},
		callback = function()
			local hop = require 'hop'
			map('n', 'gw', hop.hint_words)
			map('n', 'ga', hop.hint_anywhere)
		end
	},
	['codic-vim'] = {
		callback = function()
			vim.cmd.source '~/.config/nvim/plugins/codic-vim/plugin/codic.vim'
		end,
	},
	['copilot.lua'] = {
		modname = 'copilot',
		opts = {
			suggestion = {
				enabled = false,
				auto_trigger = true,
				keymap = {
					accept = '<C-y>',
					next = '<C-n>',
					prev = '<C-p>',
					dismiss = '<C-e>',
				}
			},
			filetypes = {
				gitcommit = true
			}
		},
		callback = function()
			vim.cmd.luafile '~/.config/nvim/plugins/copilot.lua/plugin/copilot.lua'
		end
	}
}

---@param plugname string
local function addplug(plugname)
	if plugopts[plugname] then
		local pluginpath = vim.fn.stdpath('config') .. "/plugins/"
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
	addplug 'codic-vim'
	addplug 'copilot.lua'
	map('n', ':', ':')
	vim.fn.feedkeys ':'
end)

map('n', 'm', function()
	addplug 'plenary.nvim'
	addplug 'telescope.nvim'
	addplug 'core.nvim'
	addplug 'track.nvim'
	map('n', 'm', 'm')
	vim.fn.feedkeys 'm'
end)

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
		addplug 'hop.nvim'
	end
})
