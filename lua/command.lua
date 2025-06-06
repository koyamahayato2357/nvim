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

	require 'wrapwin'.open_wrapwin()
end, {
	nargs = 1,
	complete = "help"
})

command('VS', function(_)
	require 'wrapwin'.open_wrapwin()
end, {
	nargs = 0,
})
