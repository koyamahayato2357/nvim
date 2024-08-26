local map = vim.keymap.set

return {
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
		opts = { symbol = '│' },
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
		dependencies = {
			'plenary.nvim',
		},
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
			'plenary.nvim',
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
	-- ['statusline.lua'] = {
	-- 	modname = 'statusline',
	-- },
}
