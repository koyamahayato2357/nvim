M = {}

function M.is_exist_file_in_parent_dir(file)
	local curdir = vim.fn.getcwd()
	while curdir ~= '/' do
		local full_path = curdir .. '/' .. file
		if vim.fn.filereadable(full_path) == 1 then
			return true
		end
		curdir = vim.fn.fnamemodify(curdir, ':h')
	end
	return false
end

return M
