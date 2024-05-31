local map = vim.keymap.set

local function smart_gf()
	local fpath = vim.fn.expand('<cfile>')
	if fpath:sub(1, 8) == 'https://' then
		vim.cmd.term('w3m ' .. fpath)
		vim.cmd.startinsert()
	else
		vim.cmd.normal 'gF'
	end
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
	callback = function()
		map('n', '<C-S-e>', '5<C-e>')
		map('n', '<C-S-y>', '5<C-y>')
		map('n', 'X', 'd^')
		map('n', 'S', 'c^')
		map("n", "x", vim.cmd.bdelete)
		map("n", "gk", "25k")
		map("n", "gj", "25j")
		map('n', 'gf', smart_gf)
		map('n', 'K', '5k')
		map('n', 'J', '5j')
		map("n", "^b", function() vim.cmd.buf '#' end)
		map('n', '^s', function() vim.o.spell = not vim.o.spell end)
		map('n', '^r', function() vim.o.relativenumber = not vim.o.relativenumber end)
		map('n', 'n', 'nzzzv')
		map('n', 'N', 'Nzzzv')
		map({ 'o', 'v' }, 'K', '5k')
		map({ 'o', 'v' }, 'J', '5j')
		map({ "n", "v", "o" }, "L", "5l")
		map({ "n", "v", "o" }, "H", "5h")
		map({ "v", "o" }, "gl", "$l")
		map({ "v", "o" }, "gh", "^")

		map('i', '<S-Tab>', '<C-x><C-o>')
		map('i', '<Esc>', '<Right><Esc>')
		map('i', '<C-f>', '<C-x><C-f>')

		map('v', '<C-k>', ":m '<-2<CR>gv=gv")
		map('v', '<C-j>', ":m '>+1<CR>gv=gv")
		map('v', 'v', "<C-v>")
		map('v', 'aa', 'VggoG')

		map('o', '2', 'i"')
		map('o', '7', "i'")
		map('o', '9', 'i(')
		map('o', ']', 'i]')
		map('o', '.', 'i>')

		map('c', '<Up>', function()
			vim.cmd.rshada()
			map('c', '<Up>', '<Up>')
		end)

		map('t', '<C-\\>', '<C-\\><C-n>')
	end
})
