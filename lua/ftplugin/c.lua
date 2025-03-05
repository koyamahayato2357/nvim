return {
	lsp = {
		name = 'clangd',
		cmd = { 'clangd' }
	},
	quickeval_cmd = 'clang-repl --summary-file=',
	snippet = {
		{ abbr = 'in',   snip = '#include <$1.h>\n$0' },
		{ abbr = 'i',    snip = 'if ($1) {\n  $2\n}\n$0' },
		{ abbr = 'f',    snip = 'for ($1; $2; $3) {\n  $4\n}\n$0' },
		{ abbr = 's',    snip = 'switch ($1) {\n  $2\n}\n$0' },
		{ abbr = 'c',    snip = 'case $1:\n  $0' },
		{ abbr = 'w',    snip = 'while ($1) {\n  $2\n}\n$0' },
		{ abbr = 'd',    snip = '#define $0' },
		{ abbr = 'p',    snip = 'printf("$1", $2);\n$0' },
		{ abbr = 'call', snip = '$1($2);\n$0' },
	},
	callback = function()
		vim.bo.expandtab = true
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
		vim.cmd 'iabbrev and &&'
		vim.cmd 'iabbrev or \\|\\|'
		vim.cmd 'iabbrev not !'
	end
}
