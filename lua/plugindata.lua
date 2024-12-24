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
		opts = {
			keymap = {
				['<A-h>'] = { 'show', 'show_documentation', 'hide_documentation' },
				['<Tab>'] = {},
				['<S-Tab>'] = {},
			},
			sources = { cmdline = {} },
			completion = {
				menu = {
					-- auto_show = false
				},
				ghost_text = {
					enabled = true
				},
			},
		},
		callback = function()
			map('i', '<C-l>', function()
				if vim.snippet.active() then
					return '<cmd>lua vim.snippet.jump(1)<CR>'
				else
					return '<C-l>'
				end
			end)
			map('i', '<C-h>', function()
				if vim.snippet.active() then
					return '<cmd>lua vim.snippet.jump(-1)<CR>'
				else
					return '<C-h>'
				end
			end)
		end,
		dependencies = {
			'friendly-snippets'
		}
	},
	['snacks.nvim'] = {
		modname = 'snacks',
		opts = {
			indent = {
				enabled = true,
				char = "│",
			},
			dashboard = vim.fn.argc() ~= 0 and { enabled = false } or {
				width = 60,
				row = nil,                                                       -- dashboard position. nil for center
				col = nil,                                                       -- dashboard position. nil for center
				pane_gap = 4,                                                    -- empty columns between vertical panes
				autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
				-- These settings are used by some built-in sections
				preset = {
					-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
					---@type fun(cmd:string, opts:table)|nil
					pick = nil,
					-- Used by the `keys` section to show keymaps.
					-- Set your custom keymaps here.
					-- When using a function, the `items` argument are the default keymaps.
					---@type snacks.dashboard.Item[]
					keys = {
						{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
						{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
						{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
					-- Used by the `header` section
					header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
				},
				-- item field formatters
				formats = {
					icon = function(item)
						-- if item.file and item.icon == "file" or item.icon == "directory" then
						-- 	return M.icon(item.file, item.icon)
						-- end
						return { item.icon, width = 2, hl = "icon" }
					end,
					footer = { "%s", align = "center" },
					header = { "%s", align = "center" },
					file = function(item, ctx)
						local fname = vim.fn.fnamemodify(item.file, ":~")
						fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
						if #fname > ctx.width then
							local dir = vim.fn.fnamemodify(fname, ":h")
							local file = vim.fn.fnamemodify(fname, ":t")
							if dir and file then
								file = file:sub(-(ctx.width - #dir - 2))
								fname = dir .. "/…" .. file
							end
						end
						local dir, file = fname:match("^(.*)/(.+)$")
						return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or
							{ { fname, hl = "file" } }
					end,
				},
				sections = {
					{ section = "header" },
					{
						pane = 2,
						section = "terminal",
						cmd = "~/bin/colorscript -e square",
						height = 5,
						padding = 1,
					},
					{ section = "keys", gap = 1, padding = 1 },
					{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{
						pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return require 'snacks'.git.get_root() ~= nil
						end,
						cmd = "hub status --short --branch --renames",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{ section = "startup" },
				},
			}
		},
		callback = function()
			local snacks = require 'snacks'
			snacks.indent.enable()
			vim.api.nvim_create_user_command('L', function(_)
				vim.cmd.wa()
				snacks.lazygit()
			end, { nargs = 0 })
		end,
		dependencies = {
			"telescope.nvim"
		}
	},
	['nvim-navic'] = {
		modname = 'nvim-navic',
		opts = {
			lsp = { auto_attach = true },
			highlight = true
		}
	},
	['nvim-navbuddy'] = {
		modname = 'nvim-navbuddy',
		opts = {
			lsp = { auto_attach = true },
			highlight = true
		},
		dependencies = {
			'nvim-navic',
			'nui.nvim'
		}
	},
	['nui.nvim'] = {
		modname = 'nui',
	}
}
