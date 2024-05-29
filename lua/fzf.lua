---@param directory string
---@param files table
---@return table
local function get_files_recursive(directory, files)
	files = files
	local curdir = vim.env.PWD
	local directory_files = vim.fn.readdir(directory)
	for _, file in ipairs(directory_files) do
		local full_path = directory .. '/' .. file
		if vim.fn.isdirectory(full_path) ~= 0 and file ~= '.' and file ~= '..' and file ~= '.git' and file ~= 'build' and file ~= 'bin' and file ~= 'plugins' then
			get_files_recursive(full_path, files)
		else
			table.insert(files, full_path:sub(#curdir + 2))
		end
	end
	return files
end

vim.api.nvim_create_user_command("F",
	function(opts)
		vim.cmd.tabnew(opts.fargs[1])
	end,
	{
		nargs = 1,
		bar = true,
		complete = function(A)
			local items = get_files_recursive(vim.env.PWD, {})
			if #A > 0 then
				return vim.fn.matchfuzzy(items, A)
			else
				return items
			end
		end
	})
