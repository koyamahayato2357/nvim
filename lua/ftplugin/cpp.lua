local lsp = {
	name = 'clangd',
	cmd = { 'clangd' }
}

local root = vim.fs.root(0, 'platformio.ini')
if root then
	table.insert(lsp[2], '--background-index')
	table.insert(lsp[2],
		'--query-driver=/home/sundo/.platformio/packages/toolchain-gccarmnoneeabi@1.90201.191206/bin/arm-none-eabi-g++')
	lsp.root_dir = root
end

return {
	lsp = lsp,
	quickeval_cmd = 'clang-repl --summary-file=',
	callback = function()
		vim.bo.expandtab = true
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
	end
}
