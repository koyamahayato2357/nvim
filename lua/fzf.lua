function FilesPicker(A, L, P)
	local items = vim.split(vim.fn.system({ 'fd', '.', '-t', 'f' }), '\n')
	if A:len() > 0 then
		return vim.fn.matchfuzzy(items, A)
	else
		return items
	end
end

vim.api.nvim_create_user_command("F", function(opts) vim.cmd.edit(opts.fargs[1]) end, { nargs = 1, bar = true, complete = "customlist,v:lua.FilesPicker" })
