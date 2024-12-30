return {
	lsp = {
		name = 'zls',
		cmd = { 'zls' }
	},
	snippet = {
		{ abbr = 'i', snip = 'if ($1) {\n    $2\n}\n$0' },
		{ abbr = 'f', snip = 'for ($1) |$2| {\n    $3\n}\n$0' },
		{ abbr = 'w', snip = 'while ($1) {\n    $2\n}\n$0' },
		{ abbr = 'fn', snip = 'fn $1($2) $3 {\n    $4\n}\n$0' },
		{ abbr = 's', snip = 'switch ($1) {\n    $2\n}\n$0' },
		{ abbr = 'p', snip = '$1 => $2,\n$0' },
		{ abbr = 't', snip = 'test "$1" {\n    $2\n}' },
	},
	callback = function()
		vim.bo.expandtab = true
		vim.bo.shiftwidth = 4
		vim.bo.tabstop = 4
	end
}
