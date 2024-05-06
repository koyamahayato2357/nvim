vim.api.nvim_create_user_command("F",
function(opts)
	vim.cmd.edit(opts.fargs[1])
end,
{ nargs = 1, bar = true, complete = function(A)
	local items = vim.fn.systemlist({ 'fd', '.', '-t', 'f' })
	if A:len() > 0 then
		return vim.fn.matchfuzzy(items, A)
	else
		return items
	end
end })
