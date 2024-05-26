local command = vim.api.nvim_create_user_command

command('M', function(opts)
	local args = table.concat(opts.fargs, ' ')
	vim.cmd.term('man ' .. args .. '| bat -p -l man')
	vim.cmd.startinsert()
end, {
	nargs = '*',
	bar = true,
})
