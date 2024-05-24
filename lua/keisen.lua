local map = vim.keymap.set

local chars = {
	horizontal = '─',
	vertical = '│',
	right_upper = '┐',
	left_upper = '┌',
	right_lower = '┘',
	left_lower = '└',
	cross = '┼',
	T_shaped = '┬',
	in_T_shaped = '┴',
	TO_shaped = '├',
	in_TO_shaped = '┤'
}

---@param typed string
local function keisen(typed)
	local default_virtualedit = vim.o.virtualedit
	vim.o.virtualedit = 'insert'
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local curline = unpack(vim.api.nvim_buf_get_lines(0, row - 1, row, false))
	if typed == '<Up>' then
		local prevchar = curline[col - 1]
		local nextchar = curline[col + 1]
		if prevchar == '─' and nextchar == '─' then
			curline[col] = '┴'
		elseif prevchar == '─' and nextchar ~= '─' then
			curline[col] = '┘'
		elseif prevchar ~= '─' and nextchar == '─' then
			curline[col] = '└'
		else
			curline[col] = '│'
		end
	elseif typed == '<Down>' then
		local prevchar = curline[col - 1]
		local nextchar = curline[col + 1]
		if prevchar == '─' and nextchar == '─' then
			curline[col] = '┬'
		elseif prevchar == '─' and nextchar ~= '─' then
			curline[col] = '┐'
		elseif prevchar ~= '─' and nextchar == '─' then
			curline[col] = '┌'
		else
			curline[col] = '─'
		end
	elseif typed == '<Right>' then
		local aboveline = vim.api.nvim_buf_get_lines(0, row - 2, row, false)
		local underline = vim.api.nvim_buf_get_lines(0, row, row + 1, false)
		if aboveline[col] == '│' and underline[col] == '│' then
			curline[col] = '├'
		elseif aboveline[col] == '│' and underline[col] ~= '│' then
			curline[col] = '└'
		elseif aboveline[col] ~= '│' and underline[col] == '│' then
			curline[col] = '┌'
		end
	elseif typed == '<Left>' then
		local aboveline = vim.api.nvim_buf_get_lines(0, row - 2, row, false)
		local underline = vim.api.nvim_buf_get_lines(0, row, row + 1, false)
		if aboveline[col] == '│' and underline[col] == '│' then
			curline[col] = '┤'
		elseif aboveline[col] == '│' and underline[col] ~= '│' then
			curline[col] = '┘'
		elseif aboveline[col] ~= '│' and underline[col] == '│' then
			curline[col] = '┐'
		end
	end
	vim.api.nvim_buf_set_lines(0, row - 1, row, false, { curline })
	vim.o.virtualedit = default_virtualedit
end

map('i', '<Up>', function() keisen('<Up>') end)
map('i', '<Down>', function() keisen('<Down>') end)
map('i', '<Right>', function() keisen('<Right>') end)
map('i', '<Left>', function() keisen('<Left>') end)
