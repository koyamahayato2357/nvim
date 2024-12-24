local M = {}

local function b2i(bool)
	return bool and 1 or 0
end

function M.goto_head()
	vim.fn.setpos('.', vim.fn.getpos("'["))
	local p = vim.api.nvim_win_get_cursor(0)
	local line = vim.api.nvim_get_current_line()

	local isfst = p[2] <= 1
	local isend = line:len() <= p[2]
	if isfst or isend then
		local fst_nonspc = line:match("^%s*"):len()
		vim.api.nvim_win_set_cursor(0, { p[1] + b2i(isend), fst_nonspc })
	end
end

function M.goto_tail()
	vim.fn.setpos('.', vim.fn.getpos("']"))
end

vim.keymap.set({'n', 'v', 'o'}, '<Plug>(goto_txtobj-head)', '<cmd>se opfunc=v:lua.require("goto_txtobj").goto_head<CR>g@')
vim.keymap.set({'n', 'v', 'o'}, '<Plug>(goto_txtobj-tail)', '<cmd>se opfunc=v:lua.require("goto_txtobj").goto_tail<CR>g@')

vim.keymap.set({'n', 'v', 'o'}, 'gi', '<Plug>(goto_txtobj-head)i')
vim.keymap.set({'n', 'v', 'o'}, 'ga', '<Plug>(goto_txtobj-head)a')
vim.keymap.set({'n', 'v', 'o'}, 'Gi', '<Plug>(goto_txtobj-tail)i')
vim.keymap.set({'n', 'v', 'o'}, 'Ga', '<Plug>(goto_txtobj-tail)a')

return M
