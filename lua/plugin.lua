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
		vim.cmd.colorscheme'catppuccin'
		hi(0, "Normal", { bg = "none" })
		hi(0, "NormalNC", { bg = "none" })
		hi(0, "CursorLine", { bg = "none" })
		hi(0, "CursorLineNC", { bg = "none" })
		hi(0, "CursorLineNr", { bg = "none" })
		hi(0, "StatusLine", { bg = "none" })
		require'flash'.setup {
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
		require'nvim-surround'.setup()
		if vim.fn.isdirectory(vim.fn.expand('%')) == 1 then
			addplug('oil.nvim')
			require'oil'.setup()
			addplug('nvim-web-devicons')
		else
			au({ "CmdlineEnter" }, {
				once = true,
				callback = function()
					addplug('oil.nvim')
					require'oil'.setup()
					addplug('nvim-web-devicons')
				end
			})
		end
	end
})

au({ 'CompleteDone' }, {
	callback = function()
		local comp = vim.v.completed_item

		-- check that this is an lsp completion
		if not vim.tbl_get(comp, 'user_data', 'nvim', 'lsp') then return end

		-- check that we were given a snippet
		local complete_info = comp.user_data.nvim.lsp.completion_item
		if not complete_info.insertTextFormat or complete_info.insertTextFormat == 1 then return end

		-- remove the inserted text
		local start_col = complete_info.textEdit.range.start.character+1
		vim.fn.cursor(vim.fn.line('.'), start_col)
		vim.cmd.normal{args = {"d" .. #comp.word .. "l"}}

		-- if the inserted text was the last text on the line, the deletion command will leave the cursor 1 column left
		-- of where we need to insert the snippet (because insert mode can put the cursor 1 position ahead of the last column)
		-- move the cursor back over 1
		vim.fn.cursor(vim.fn.line('.'), start_col)

		-- insert snippet
		local snip_text = vim.tbl_get(complete_info, 'textEdit', 'newText') or comp.insertText
		assert(snip_text, "Language server indicated it had a snippet, but no snippet text could be found!")
		require('luasnip').lsp_expand(snip_text)
	end
})

au({ "CmdlineEnter" }, {
	once = true,
	callback = function()
		addplug('vimdoc-ja')
		addplug('nvimdoc-ja')
		addplug('carbonpaper.vim')
	end
})

au({ "InsertEnter" }, {
	once = true,
	callback = function()
		addplug('ultimate-autopair.nvim')
		addplug('copilot.nvim')
		addplug('LuaSnip')
		require'ultimate-autopair'.setup()
		local ls = require('luasnip')
		require('snippets')
		map('i', 'ŝ', function() ls.expand() end)
		map('i', 'ĝ', function() ls.jump(1) end)
		map('i', 'ĉ', function() ls.jump(-1) end)
	end
})

