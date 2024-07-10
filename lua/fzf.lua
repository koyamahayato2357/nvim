---@param directory string
---@param files table
---@return table
local function get_files_recursive(directory, files)
	local curdir = vim.env.PWD
	local directory_files = vim.fn.readdir(directory)
	local ignored_dirs = { '.', '..', '.git', 'build', 'bin', 'plugins' }
	for _, file in ipairs(directory_files) do
		local full_path = directory .. '/' .. file
		if vim.fn.isdirectory(full_path) ~= 0 and not vim.tbl_contains(ignored_dirs, file) then
			get_files_recursive(full_path, files)
		else
			table.insert(files, full_path:sub(#curdir + 2))
		end
	end
	return files
end

local file_cache = nil

vim.api.nvim_create_user_command("F",
	function(opts)
		vim.cmd.tabnew(opts.fargs[1])
	end,
	{
		nargs = 1,
		bar = true,
		complete = function(trigger)
			if not file_cache then
				file_cache = get_files_recursive(vim.env.PWD, {})
			end
			if #trigger > 0 then
				return vim.fn.matchfuzzy(file_cache, trigger)
			else
				return file_cache
			end
		end
	})
