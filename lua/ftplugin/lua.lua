return {
	lsp = {
		name = 'lua-ls',
		cmd = { 'lua-language-server' },
		root_dir = vim.fn.stdpath('config')
	},
	snippet = {
		{ abbr = 'i', snip = 'if $1 then\n\t$2\nend\n$0' },
		{ abbr = 'f', snip = 'for $1 in $2 do\n\t$3\nend\n$0' },
		{ abbr = 'fn', snip = 'function $1($2)\n\t$3\nend\n$0' },
		{ abbr = 'l', snip = 'function($1)\n\t$2\nend\n$0' },
	}
}
