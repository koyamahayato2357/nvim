local map = vim.keymap.set
vim.g.mapleader = ' '

local function smart_gf()
	local fpath = vim.fn.expand('<cfile>')
	if fpath:sub(1, 8) == 'https://' then
		vim.cmd.term('w3m ' .. fpath)
		vim.cmd.startinsert()
	else
		vim.cmd.normal 'gF'
	end
end

vim.loop.new_async(vim.schedule_wrap(function()
	map("n", "<BS>", "<C-b>")
	map("n", "<Delete>", "<C-f>")
	map('n', '<C-S-e>', '5<C-e>')
	map('n', '<C-S-y>', '5<C-y>')
	map('n', 'X', 'd^')
	map('n', 'S', 'c^')
	map("n", "x", vim.cmd.bdelete)
	map("n", "Q", "q")
	map("n", "q", "ZZ")
	map("n", "gk", "25k")
	map("n", "gj", "25j")
	map('n', 'gf', smart_gf)
	map('n', 'K', '5k')
	map('n', 'J', '5j')
	map("n", "^b", function() vim.cmd.buf '#' end)
	map('n', '^s', function() vim.o.spell = not vim.o.spell end)
	map('n', '^r', function() vim.o.relativenumber = not vim.o.relativenumber end)
	map('n', '<Space>', '<Nop>')
	map('n', '<CR>', '<Nop>')
	map('n', 'n', 'nzzzv')
	map('n', 'N', 'Nzzzv')
	map('n', '<C-z>', ':w<CR><C-z>')
	map({ 'o', 'v' }, 'K', '5k')
	map({ 'o', 'v' }, 'J', '5j')
	map({ "n", "v" }, "]]", "<C-]>")
	map({ "n", "v" }, "<Leader>y", [["+y]])
	map({ "n", "v" }, "<Leader>Y", [["+Y]])
	map({ "n", "v" }, "<Leader>d", [["_d]])
	map({ "n", "v", "o" }, "L", "5l")
	map({ "n", "v", "o" }, "H", "5h")
	map({ "n", "v", "o" }, "gl", "$l")
	map({ "n", "v", "o" }, "gh", "^")
	map({ "n", "v", "o" }, "]b", "])")
	map({ "n", "v", "o" }, "[b", "[(")
	map({ "n", "v", "o" }, "]B", "]}")
	map({ "n", "v", "o" }, "[B", "[{")

	map('i', '<Esc>', '<Right><Esc>')

	map('v', '<C-k>', ":m '<-2<CR>gv=gv")
	map('v', '<C-j>', ":m '>+1<CR>gv=gv")
	map('v', 'v', "<C-v>")
	map('v', 'aa', 'VggoG')
	map('v', '<Leader>p', [["_dP"]])

	map('o', '2', 'i"')
	map('o', '7', "i'")
	map('o', '.', 'i>')
	map('o', 'iq', "i'")
	map('o', 'iQ', 'i"')
	map('o', 'aq', "a'")
	map('o', 'aQ', 'a"')

	map('c', '<Up>', function()
		vim.cmd.rshada()
		vim.keymap.del('c', '<Up>')
		vim.api.nvim_input '<Up>'
	end)

	map('t', '<C-\\>', '<C-\\><C-n>')
end)):send()
