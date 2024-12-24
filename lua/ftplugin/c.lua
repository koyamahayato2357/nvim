local fs = require 'fs'

local lsp = {
	name = 'clangd',
	cmd = { 'clangd' }
}

if fs.is_exist_file_in_parent_dir('platformio.ini') then
	table.insert(lsp[2], '--background-index')
	table.insert(lsp[2],
		'--query-driver=/home/sundo/.platformio/packages/toolchain-gccarmnoneeabi@1.90201.191206/bin/arm-none-eabi-g++')
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
