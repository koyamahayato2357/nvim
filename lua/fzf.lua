local function get_files_recursive(directory, files)
	files = files or {}
	local curdir = vim.fn.getcwd()
	local directory_files = vim.fn.readdir(directory)
	for _, file in ipairs(directory_files) do
		local full_path = directory .. '/' .. file
		if vim.fn.isdirectory(full_path) ~= 0 and file ~= '.' and file ~= '..' then
			get_files_recursive(full_path, files)
		else
			table.insert(files, string.sub(full_path, curdir:len() + 2))
		end
	end
	return files
end

vim.api.nvim_create_user_command("F",
function(opts)
	vim.cmd.edit(opts.fargs[1])
end,
{ nargs = 1, bar = true, complete = function(A)
	local items = get_files_recursive(vim.fn.getcwd())
	if A:len() > 0 then
		return vim.fn.matchfuzzy(items, A)
	else
		return items
	end
end })
