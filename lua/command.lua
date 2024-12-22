local command = vim.api.nvim_create_user_command

command('M', function(opts)
	local args = table.concat(opts.fargs, ' ')
	vim.cmd.term('man ' .. args .. '| bat -p -l man')
	vim.cmd.startinsert()
end, {
	nargs = '*',
	bar = true,
})

command('W', function(opts)
	vim.cmd.term('w3m ' .. opts.fargs[1])
	vim.cmd.startinsert()
end, {
	nargs = 1,
	bar = true
})

command('H', function(opts)
	vim.cmd('tab h ' .. opts.fargs[1])

	local winnr = vim.api.nvim_open_win(0, false, { split = 'left' })
	local winheight = vim.fn.winheight(0)
	local winbot = vim.fn.line('w$')
	local target = winbot + winheight

	vim.cmd.normal((target - vim.o.scrolloff - 2) .. 'ggzb')
	vim.o.scrollbind = true
	vim.api.nvim_tabpage_set_win(0, winnr)
	vim.o.scrollbind = true
	vim.keymap.set('n', 'Q', '<cmd>tabc<CR>', { buffer = true })
	vim.keymap.set('n', '<C-f>', '2<C-f>', { buffer = true })
	vim.keymap.set('n', '<C-b>', '2<C-b>', { buffer = true })
	vim.keymap.set('n', '<C-e>', '2<C-e>', { buffer = true })
	vim.keymap.set('n', '<C-y>', '2<C-y>', { buffer = true })
	vim.keymap.set('n', '<C-d>', '2<C-d>', { buffer = true })
	vim.keymap.set('n', '<C-u>', '2<C-u>', { buffer = true })
end, {
	nargs = 1,
	complete = "help"
})
