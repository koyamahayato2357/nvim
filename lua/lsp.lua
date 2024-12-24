M = {}

function M.lsp_start(name, cmd, root)
	vim.lsp.start({
		name = name,
		cmd = cmd,
		root_dir = root
	})
end

vim.keymap.set('n', '=', vim.lsp.buf.format)
vim.keymap.set('n', '^h', function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'grh', vim.lsp.buf.hover)

return M
