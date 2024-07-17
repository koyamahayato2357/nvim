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
			},
			bs = {
				indent_ignore = true,
			},
			space2 = {
				enable = true,
			},
			extensions = {
				fly = {
					enable = true
				},
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
			track.restore(markfile)
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
				enabled = true,
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
	},
	['CopilotChat.nvim'] = {
		modname = 'CopilotChat',
		opts = {},
	},
	['nvim-treesitter'] = {
		modname = 'nvim-treesitter',
		opts = { ensure_installed = 'all' },
	},
	['refactoring.nvim'] = {
		modname = 'refactoring.command',
		opts = {}
	},
	['statusline.lua'] = {
		modname = 'statusline',
	},
	['material.nvim'] = {
		callback = function()
			vim.cmd.colorscheme 'material-deep-ocean'
			hi(0, "SignColumn", { bg = "None" })
			hi(0, "ErrMsg", { bg = "None" })
			hi(0, "DiagnosticError", { fg = "Red", bg = "None", bold = true })
			hi(0, "DiagnosticLineNrError", { fg = "Red", bg = "None", bold = true })
			hi(0, "DiagnosticWarn", { fg = "Yellow", bg = "None", bold = true })
			hi(0, "DiagnosticLineNrWarn", { fg = "Yellow", bg = "None", bold = true })
			hi(0, "DiagnosticHint", { fg = "Yellow", bg = "None", bold = true })
			hi(0, "DiagnosticLineNrHint", { fg = "Yellow", bg = "None", bold = true })
			hi(0, "DiagnosticInfo", { fg = "Yellow", bg = "None", bold = true })
			hi(0, "DiagnosticLineNrInfo", { fg = "Yellow", bg = "None", bold = true })
			hi(0, "CursorLine", { bg = "none" })
			hi(0, "CursorLineNC", { bg = "none" })
			hi(0, "StatusLine", { bg = "none" })
			hi(0, 'LspInlayHint', { fg = 'DarkCyan' })
		end
	}
}

---@param plugname string
function Addplug(plugname)
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

Addplug 'statusline.lua'

if vim.fn.argc() == 0 then
	Addplug 'nvim-web-devicons'
	Addplug 'oil.nvim'
	Addplug 'dashboard-nvim'
end

au({ 'VimEnter' }, {
	callback = function()
		Addplug 'flash.nvim'
		Addplug 'substitute.nvim'
		Addplug 'nvim-surround'
		Addplug 'material.nvim'
		Addplug 'toggleterm.nvim'
		Addplug 'nvim-web-devicons'
		Addplug 'oil.nvim'
	end
})

map('n', ':', function()
	Addplug 'command'
	Addplug 'fzf'
	Addplug 'vimdoc-ja'
	Addplug 'nvimdoc-ja'
	Addplug 'carbonpaper.vim'
	Addplug 'sidebar.nvim'
	Addplug 'nui.nvim'
	Addplug 'noice.nvim'
	Addplug 'codic-vim'
	Addplug 'plenary.nvim'
	Addplug 'refactoring.nvim'
	vim.loop.new_async(vim.schedule_wrap(function()
		Addplug 'copilot.lua'
		Addplug 'CopilotChat.nvim'
	end)):send()
	vim.keymap.del('n', ':')
	vim.fn.feedkeys ':'
end)

map('n', 'm', function()
	Addplug 'plenary.nvim'
	Addplug 'telescope.nvim'
	Addplug 'core.nvim'
	Addplug 'track.nvim'
	vim.keymap.del('n', 'm')
	vim.fn.feedkeys 'm'
end)

au({ "InsertEnter", "CmdlineEnter" }, {
	once = true,
	callback = function()
		Addplug 'ultimate-autopair.nvim'
	end
})

au({ "CursorMoved" }, {
	once = true,
	callback = function()
		Addplug 'mini.indentscope'
		Addplug 'sentiment.nvim'
		Addplug 'hop.nvim'
	end
})
