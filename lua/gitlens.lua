local map = vim.keymap.set
local api = vim.api

function PrintBlameText()
	local ft = vim.fn.expand('%:h:t')
	if ft == '' or ft == 'bin' then
		return
	end
	local currFile = vim.fn.expand('%')
	local line = api.nvim_win_get_cursor(0)
	local blame = vim.fn.system(string.format('git blame -c -L %d,%d %s', line[1], line[1], currFile))
	local hash = vim.split(blame, '%s')[1]
	if hash == '00000000' then
		Text = 'Not Committed Yet'
	else
		local cmd = "git show " .. hash .. " --format='%an | %ar | %s' | head -n 1"
		Text = vim.fn.system(cmd):sub(1, -2)
		if Text:find("fatal") then
			Text = 'Not Committed Yet'
		end
	end
	print(Text)
end

map('n', 'gb', PrintBlameText)
