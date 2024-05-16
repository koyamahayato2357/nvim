local au = vim.api.nvim_create_autocmd
local map = vim.keymap.set
local hi = vim.api.nvim_set_hl

---@param plugname string
local function addplug(plugname)
	local pluginpath = "/home/sundo/.config/nvim/plugins/"
	vim.opt.runtimepath:append(pluginpath .. plugname)
end

au({ 'VimEnter' }, {
	callback = function()
		addplug('flash.nvim')
		addplug('substitute.nvim')
		addplug('nvim-surround')
		addplug('nvim')
		addplug('toggleterm.nvim')
		addplug('nvim-web-devicons')
		addplug('oil.nvim')
		vim.cmd.colorscheme 'catppuccin'
		hi(0, "Normal", { bg = "none" })
		hi(0, "NormalNC", { bg = "none" })
		hi(0, "CursorLine", { bg = "none" })
		hi(0, "CursorLineNC", { bg = "none" })
		hi(0, "CursorLineNr", { bg = "none" })
		hi(0, "StatusLine", { bg = "none" })
		require 'flash'.setup {
			config = function()
				local flash = require('flash')
				map('n', 'gw', flash.remote)
				map({ 'n', 'v', 'o' }, 'gs', flash.treesitter)
				map({ 'n', 'v', 'o' }, 'gS', flash.treesitter_search)
			end
		}
		local sub = require('substitute')
		map('n', 's', sub.operator)
		map('n', 'ss', sub.line)
		map('n', 'S', sub.eol)
		map('x', 's', sub.visual)
		require 'nvim-surround'.setup()
		local oil = require('oil')
		oil.setup {
			columns = {
				'icon',
				'permission',
				'size',
				'mtime'
			},
		}
		map('n', '^o', function() oil.toggle_float() end)
		local toggleterm = require('toggleterm')
		toggleterm.setup {
			direction = "float"
		}
		map('n', '^t', function() toggleterm.toggle() end)
	end
})

au({ "CmdlineEnter" }, {
	once = true,
	callback = function()
		addplug('vimdoc-ja')
		addplug('nvimdoc-ja')
		addplug('carbonpaper.vim')
		addplug('sidebar.nvim')
		addplug('nui.nvim')
		addplug('noice.nvim')
		local sidebar = require('sidebar-nvim')
		sidebar.setup({
			open = false,
			initial_width = 20,
		})
		vim.api.nvim_create_user_command("B", sidebar.toggle, {})
		require('noice').setup {
			notify = {
				enabled = false
			},
			messages = {
				enabled = false
			},
		}
	end
})

au({ "InsertEnter" }, {
	once = true,
	callback = function()
		addplug('ultimate-autopair.nvim')
		addplug('copilot.nvim')
		addplug('LuaSnip')
		require 'ultimate-autopair'.setup()
		local ls = require('luasnip')
		require('snippets')
		map('i', 'ŝ', function() ls.expand() end)
		map('i', 'ĝ', function() ls.jump(1) end)
		map('i', 'ĉ', function() ls.jump(-1) end)
	end
})

au({ "CursorMoved" }, {
	once = true,
	callback = function()
		addplug('mini.indentscope')
		require('mini.indentscope').setup {}
	end
})
