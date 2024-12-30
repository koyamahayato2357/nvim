local mysnip = {}
local map = vim.keymap.set
M = {}

function M.set_snip(sn)
	mysnip[sn.abbr] = sn.snip
end

function M.setup_keymap()
	map('i', '<Tab>', function()
		local curpos = vim.api.nvim_win_get_cursor(0);
		if curpos[2] == 0 then return '<Tab>' end
		local newpos = { curpos[1], curpos[2] - 1 }
		vim.api.nvim_win_set_cursor(0, newpos)
		local cword = vim.fn.expand('<cword>')
		local snip = mysnip[cword]
		if snip then
			return '<Esc>ciw<cmd>lua vim.snippet.expand"' .. snip:gsub('\n', '\\n') .. '"<CR>'
		end

		vim.api.nvim_win_set_cursor(0, curpos)
		if vim.snippet.active({ direction = 1 }) then
			return '<cmd>lua vim.snippet.jump(1)'
		else
			return '<Tab>'
		end
	end, { expr = true })

	map({ 'i', 's' }, '<S-Tab>', function()
		if vim.snippet.active({ direction = -1 }) then
			vim.snippet.jump(-1)
		else
			return '<Tab>'
		end
	end, { expr = true })
end

return M
