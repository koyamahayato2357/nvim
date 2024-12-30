return {
	lsp = {
		name = 'rust-analyzer',
		cmd = { 'rust-analyzer' }
	},
	snippet = {
		{ abbr = 'i', snip = 'if $1 {\n\t$2\n}\n$0' },
		{ abbr = 'f', snip = 'for $1 in $2 {\n\t$3\n}\n$0' },
		{ abbr = 'w', snip = 'while $1 {\n\t$2\n}\n$0' },
		{ abbr = 'm', snip = 'match $1 {\n\t$2\n}\n$0' },
		{ abbr = 'p', snip = '$1 => $2,\n$0' },
		{ abbr = 'fn', snip = 'fn $1($2) {\n\t$3\n}\n$0' },
		{ abbr = 'fnr', snip = 'fn $1($2) -> $3 {\n\t$4\n}\n$0' },
	}
}
