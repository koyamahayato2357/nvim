return {
	lsp = {
		name = 'zls',
		cmd = { 'zls' }
	},
	callback = function()
		vim.bo.expandtab = true
		vim.bo.shiftwidth = 4
		vim.bo.tabstop = 4
	end
}
