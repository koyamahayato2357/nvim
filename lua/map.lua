local map = vim.keymap.set

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
	callback = function()
		map("n", "<BS>", "<C-b>")
		map("n", "<Delete>", "<C-f>")
		map('n', '<C-S-e>', '5<C-e>')
		map('n', '<C-S-y>', '5<C-y>')
		map('n', 'X', 'd^')
		map('n', 'S', 'c^')
		map("n", "x", vim.cmd.bdelete)
		map('n', '<Space><Space>', 'gg=G<C-o>')
		map('n', '<Space><CR>', 'a<CR><Esc>')
		map('n', 'gd', vim.lsp.buf.definition)
		map('n', 'gn', vim.lsp.buf.rename)
		map('n', 'gr', vim.lsp.buf.references)
		map('n', '[e', vim.diagnostic.goto_prev)
		map('n', ']e', vim.diagnostic.goto_next)
		map("n", "Q", "q")
		map("n", "q", "ZZ")
		map("n", "gk", "25k")
		map("n", "gj", "25j")
		map('n', 'K', '5k')
		map('n', 'J', '5j')
		map("n", "^b", function() vim.cmd.buf'#' end)
		map('n', '^s', function() vim.o.spell = not vim.o.spell end)
		map('n', '^r', function() vim.o.relativenumber = not vim.o.relativenumber end)
		map('n', 'zh', '<C-w>h')
		map('n', 'zj', '<C-w>j')
		map('n', 'zk', '<C-w>k')
		map('n', 'zl', '<C-w>l')
		map('n', 'zw', '<C-w>w')
		map('n', 'zo', '<C-o>')
		map('n', 'zi', '<C-i>')
		map("n", "zs", "m'")
		map('n', '<Space>', '<Nop>')
		map('n', '<CR>', '<Nop>')
		map('n', 'n', 'nzzzv')
		map('n', 'N', 'Nzzzv')
		map('n', ']q', vim.cmd.cnext)
		map('n', '[q', vim.cmd.cprev)
		map({ 'o', 'v' }, 'K', '5k')
		map({ 'o', 'v' }, 'J', '5j')
		map({ "n", "v", "o" }, "L", "5l")
		map({ "n", "v", "o" }, "H", "5h")
		map({ "n", "v", "o" }, "gl", "$l")
		map({ "n", "v", "o" }, "gh", "^")

		map('i', '<S-Tab>', '<C-x><C-o>')
		map('i', '<Esc>', '<Right><Esc>')
		map('i', '<C-e>', '<C-x><C-e>')
		map('i', '<C-y>', '<C-x><C-y>')
		map('i', '<C-f>', '<C-x><C-f>')

		map('v', '<C-k>', ":m '<-2<CR>gv=gv")
		map('v', '<C-j>', ":m '>+1<CR>gv=gv")
		map('v', 'v', "<C-v>")
		map('v', 'aa', 'VggoG')

		map('o', '2', 'i"')
		map('o', '7', "i'")
		map('o', '9', 'i(')
		map('o', ']', 'i]')
		map('o', '}', 'i}')
		map('o', '.', 'i>')
	end
})
