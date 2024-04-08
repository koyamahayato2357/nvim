local M = {}
local api = vim.api
function M.blameVirtText()
	local ft = vim.fn.expand('%:h:t')
	if ft == '' or ft == 'bin' then
		return
	end
	api.nvim_buf_clear_namespace(0, 2, 0, -1)
	local currFile = vim.fn.expand('%')
	local line = api.nvim_win_get_cursor(0)
	local blame = vim.fn.system(string.format('git blame -c -L %d,%d %s', line[1], line[1], currFile))
	local hash = vim.split(blame, '%s')[1]
	local cmd = string.format("git show %s ", hash).."--format='%an | %ar | %s'"
	if hash == '00000000' then
		Text = 'Not Committed Yet'
	else
		Text = vim.fn.system(cmd)
		Text = vim.split(Text, '\n')[1]
		if Text:find("fatal") then
			Text = 'Not Committed Yet'
		end
	end
	api.nvim_buf_set_virtual_text(0, 2, line[1] - 1, {{ Text,'GitLens' }}, {})
end
function M.clearBlameVirtText()
	api.nvim_buf_clear_namespace(0, 2, 0, -1)
end

return M
