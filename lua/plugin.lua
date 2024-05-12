local au = vim.api.nvim_create_autocmd
local map = vim.keymap.set

local pluginpath = "/home/sundo/.local/share/nvim/plugins/"
au({ 'VimEnter' }, {
	callback = function()
		vim.opt.runtimepath:append(pluginpath .. 'flash.nvim')
		vim.opt.runtimepath:append(pluginpath .. 'substitute.nvim')
		vim.opt.runtimepath:append(pluginpath .. 'nvim-surround')
		vim.opt.runtimepath:append(pluginpath .. 'nvim')
		vim.cmd.colorscheme'catppuccin'
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
		require'flash'.setup {
			config = function()
				local flash = require('flash')
				map('n', 'gw', flash.remote)
				map({ 'n', 'v', 'o' }, 'gs', flash.treesitter)
				map({ 'n', 'v', 'o' }, 'gS', flash.treesitter_search)
			end
		}

		require'substitute'.setup {
			config = function()
				local sub = require('substitute')
				map('n', 's', sub.operator)
				map('n', 'ss', sub.line)
				map('n', 'S', sub.eol)
				map('x', 's', sub.visual)
			end,
			opts = { modifiers = nil },
		}
		require'nvim-surround'.setup()
		if vim.fn.isdirectory(vim.fn.expand('%')) == 1 then
			vim.opt.runtimepath:append(pluginpath .. 'oil.nvim')
			require'oil'.setup()
			vim.opt.runtimepath:append(pluginpath .. 'nvim-web-devicons')
		else
			au({ "CmdlineEnter" }, {
				once = true,
				callback = function()
					vim.opt.runtimepath:append(pluginpath .. 'oil.nvim')
					require'oil'.setup()
					vim.opt.runtimepath:append(pluginpath .. 'nvim-web-devicons')
				end
			})
		end
	end
})

au({ "CmdlineEnter" }, {
	once = true,
	callback = function()
		vim.opt.runtimepath:append(pluginpath .. 'vimdoc-ja')
		vim.opt.runtimepath:append(pluginpath .. 'nvimdoc-ja')
		vim.opt.runtimepath:append(pluginpath .. 'carbonpaper.vim')
	end
})

au({ "InsertEnter" }, {
	once = true,
	callback = function()
		vim.opt.runtimepath:append(pluginpath .. 'ultimate-autopair.nvim')
		vim.opt.runtimepath:append(pluginpath .. 'copilot.nvim')
		vim.opt.runtimepath:append(pluginpath .. 'LuaSnip')
		require'ultimate-autopair'.setup()
		local ls = require('luasnip')
		require('snippets')
		map('i', 'ŝ', function() ls.expand() end)
		map('i', 'ĝ', function() ls.jump(1) end)
		map('i', 'ĉ', function() ls.jump(-1) end)
	end
})

