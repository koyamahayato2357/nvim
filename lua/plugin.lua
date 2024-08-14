local au = vim.api.nvim_create_autocmd
local map = vim.keymap.set

local pluginOptions = {
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
		end,
		dependencies = {
			'nvim-web-devicons',
		}
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
		opts = {
			shortcut_type = 'number',
			config = {
				week_header = {
					enable = true
				}
			},
			change_to_vcs_root = true
		},
		callback = vim.cmd.rshada,
		dependencies = {
			'nvim-web-devicons',
		},
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
			fastwarp = {
				rmap = '<A-y>',
				rcmap = '<A-y>',
			},
			tabout = {
				enable = true,
				map = '<C-f>',
				cmap = '<C-f>',
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
			local markfile = vim.fn.stdpath('data') .. '/marks/mark.json'
			map('n', 'mm', track.toggle)
			map('n', 'md', track.remove)
			map('n', 'mk', track.jump_to_prev)
			map('n', 'mj', track.jump_to_next)
			map('n', 'me', track.edit)
			map('n', 'ms', function() track.store(markfile) end)
			track.restore(markfile)
		end,
		dependencies = {
			'plenary.nvim',
			'telescope.nvim',
			'core.nvim',
		},
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
				auto_trigger = false,
				keymap = {
					accept = '<C-y>',
					next = '<C-S-n>',
					prev = '<C-S-p>',
					dismiss = '<C-e>',
				}
			},
			filetypes = {
				gitcommit = true
			}
		},
		callback = function()
			map('n', '^a', require 'copilot.suggestion'.toggle_auto_trigger)
		end
	},
	['CopilotChat.nvim'] = {
		modname = 'CopilotChat',
		opts = {},
		dependencies = {
			'plenary.lua',
			'copilot.lua',
		},
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
}

---@param plugname string
function Load_Plugin(plugname)
	if pluginOptions[plugname] then
		local pluginpath = vim.fn.stdpath('config') .. "/plugins/"
		local modname = pluginOptions[plugname].modname
		local opts = pluginOptions[plugname].opts
		local callback = pluginOptions[plugname].callback
		local dependencies = pluginOptions[plugname].dependencies
		vim.opt.runtimepath:append(pluginpath .. plugname)
		if opts and modname then require(modname).setup(opts) end
		if callback then callback() end
		if dependencies then
			for _, depend in ipairs(dependencies) do
				Load_Plugin(depend)
			end
		end
		pluginOptions[plugname] = nil
	end
end

Load_Plugin 'statusline.lua'

if vim.fn.argc() == 0 then
	Load_Plugin 'oil.nvim'
	Load_Plugin 'dashboard-nvim'
end

au({ 'VimEnter' }, {
	callback = function()
		Load_Plugin 'flash.nvim'
		Load_Plugin 'substitute.nvim'
		Load_Plugin 'nvim-surround'
		Load_Plugin 'toggleterm.nvim'
		Load_Plugin 'oil.nvim'
		vim.loop.new_async(vim.schedule_wrap(function()
			Load_Plugin 'copilot.lua'
			Load_Plugin 'CopilotChat.nvim'
		end)):send()
	end
})

local enter_cmdline_chars = { ':', '/', '?' }
for _, enter_cmdline_char in ipairs(enter_cmdline_chars) do
	map({ 'n', 'v' }, enter_cmdline_char, function()
		require 'command'
		require 'fzf'
		Load_Plugin 'vimdoc-ja'
		Load_Plugin 'nvimdoc-ja'
		Load_Plugin 'carbonpaper.vim'
		Load_Plugin 'sidebar.nvim'
		Load_Plugin 'nui.nvim'
		Load_Plugin 'noice.nvim'
		Load_Plugin 'codic-vim'
		Load_Plugin 'refactoring.nvim'
		for _, c in ipairs(enter_cmdline_chars) do
			vim.keymap.del({ 'n', 'v' }, c)
		end
		vim.fn.feedkeys(enter_cmdline_char)
	end)
end

map('n', 'm', function()
	Load_Plugin 'track.nvim'
	vim.keymap.del('n', 'm')
	vim.fn.feedkeys 'm'
end)

au({ "InsertEnter", "CmdlineEnter" }, {
	once = true,
	callback = function()
		Load_Plugin 'ultimate-autopair.nvim'
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
