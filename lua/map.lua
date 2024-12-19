local map = vim.keymap.set
local submode = require 'submode'
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

local function smart_i()
	if vim.fn.empty(vim.fn.getline('.')) ~= 0 then
		vim.api.nvim_input '"_cc'
	else
		-- vim.api.nvim_input 'i' -- freeze
		vim.cmd.startinsert()
	end
end

map("n", "<BS>", "<C-b>")
map("n", "<Delete>", "<C-f>")
map('n', '<C-S-e>', '5<C-e>')
map('n', '<C-S-y>', '5<C-y>')
map('n', 'i', smart_i)
map('n', 'S', 'c^')
map("n", "Q", "ZZ", { noremap = true })
map("n", "gk", "25k")
map("n", "gj", "25j")
map('n', 'gf', smart_gf)
map("n", "gb", vim.cmd.bnext)
map('n', 'gB', vim.cmd.bprev)
map('n', '^n', function() vim.o.number = not vim.o.number end)
map('n', '^r', function() vim.o.relativenumber = not vim.o.relativenumber end)
map('n', '^s', function() vim.o.spell = not vim.o.spell end)
map('n', '<C-z>', ':w<CR><C-z>')
map({ 'n', 'v' }, 'q;', 'q:')
map({ 'n', 'o', 'v' }, 'K', '5k')
map({ 'n', 'o', 'v' }, 'J', '5j')
map({ 'n', 'v' }, "x", '"_d')
map({ 'n', 'v' }, 'X', '"_D')
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
map('o', 'i<Space>', 'iW')
map('o', 'a<Space>', 'aW')

map('t', '<C-\\>', '<C-\\><C-n>')

submode.set_submode_keymap('n', 'gt', {
	{ key = 't', callback = vim.cmd.tabn }
}, vim.cmd.tabn)
submode.set_submode_keymap('n', 'gT', {
	{ key = 'T', callback = vim.cmd.tabp }
}, vim.cmd.tabp)
