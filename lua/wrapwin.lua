M = {}

function M.open_wrapwin()
	local curwin = vim.api.nvim_tabpage_get_win(0)
	local newwin = vim.api.nvim_open_win(0, false, { split = 'left' })
	local winheight = vim.api.nvim_win_get_height(0)
	local winbot = vim.fn.line('w$')
	local targetline = winbot + math.floor(winheight / 2) - 1

	-- scroll new window page forward
	vim.api.nvim_win_set_cursor(0, { targetline, 1 })
	vim.cmd.normal 'zz'

	-- enable scrollbind for both
	vim.o.scrollbind = true
	vim.api.nvim_tabpage_set_win(0, newwin)
	vim.o.scrollbind = true

	-- delete only new window
	vim.keymap.set('n', '<C-c>', function()
		vim.api.nvim_win_close(newwin, false)
		vim.keymap.set('n', 'Q', 'ZZ')
	end, { buffer = true })

	-- delete both of windows
	vim.keymap.set('n', 'Q', function()
		vim.api.nvim_win_close(newwin, false)
		vim.api.nvim_tabpage_set_win(0, curwin)
		vim.cmd.quit()
	end, { buffer = true })

	vim.keymap.set('n', '<C-f>', '2<C-f>', { buffer = true })
	vim.keymap.set('n', '<C-b>', '2<C-b>', { buffer = true })
	vim.keymap.set('n', '<C-d>', '<C-f>', { buffer = true })
	vim.keymap.set('n', '<C-u>', '<C-b>', { buffer = true })
end

return M
