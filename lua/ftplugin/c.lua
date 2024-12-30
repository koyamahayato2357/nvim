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
	snippet = {
		{ abbr = 'in', snip = '#include <$1.h>\n$0' },
		{ abbr = 'i', snip = 'if ($1) {\n  $2\n}\n$0' },
		{ abbr = 'f', snip = 'for ($1; $2; $3) {\n  $4\n}\n$0' },
		{ abbr = 's', snip = 'switch ($1) {\n  $2\n}\n$0' },
		{ abbr = 'c', snip = 'case $1:\n  $0' },
	},
	callback = function()
		vim.bo.expandtab = true
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
		vim.cmd 'iabbrev and &&'
		vim.cmd 'iabbrev or ||'
		vim.cmd 'iabbrev not !'
	end
}
