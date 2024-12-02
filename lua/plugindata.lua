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
	['neoterm.nvim'] = {
		modname = 'neoterm',
		opts = {},
		callback = function()
			local neoterm = require 'neoterm'
			map('n', '^t', function() neoterm.toggle() end)
		end
	},
	['alpha-nvim'] = {
		modname = 'dashboard',
		callback = function()
			local startify = require 'alpha.themes.startify'
			startify.file_icons.proovider = 'devicons'
			require 'alpha'.setup(startify.config)
			vim.cmd.rshada()
		end,
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
	['ultimate-autopair.nvim'] = {
		modname = 'ultimate-autopair',
		opts = {
			fastwarp = {
				rmap = '<A-y>',
				rcmap = '<A-y>',
			},
			tabout = {
				multi = true,
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
					multiline = true,
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
		callback = function()
			vim.g.loaded_matchparen = 1
		end
	},
	['nvim-web-devicons'] = {},
	['core.nvim'] = {},
	['track.nvim'] = {
		modname = 'track',
		opts = {},
		callback = function()
			local track = require 'track'
			local markfile = vim.fn.stdpath('data') .. '/marks/mark.json'
			map('n', 'ma', track.add_mark)
			map('n', 'mA', track.add_flow)
			map('n', 'md', track.delete_mark)
			map('n', 'mD', track.delete_flow)
			map('n', 'mu', track.update_mark)
			map('n', 'mU', track.update_flow)
			map('n', 'ms', function() track.store_marks(markfile) end)
			track.restore_marks(markfile)
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
					accept = '<C-S-y>',
					next = '<C-S-n>',
					prev = '<C-S-p>',
					dismiss = '<C-S-e>',
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
	['blink.cmp'] = {
		modname = 'blink.cmp',
		opts = {},
		dependencies = {
			'friendly-snippets'
		}
	}
}
