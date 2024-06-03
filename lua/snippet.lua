local mysnip = {}
local filetype = vim.bo.filetype
local map = vim.keymap.set

if filetype == 'c' then
	mysnip['in'] = '#include <$1.h>\n$0'
	mysnip['i'] = 'if ($1) {\n  $2\n}\n$0'
	mysnip['f'] = 'for ($1; $2; $3) {\n  $4\n}\n$0'
	mysnip['s'] = 'switch ($1) {\n  $2\n}\n$0'
	mysnip['c'] = 'case $1:\n  $0'
elseif filetype == 'lua' then
	mysnip['i'] = 'if $1 then\n\t$2\nend\n$0'
	mysnip['f'] = 'for $1 in $2 do\n\t$3\nend\n$0'
	mysnip['fn'] = 'function $1($2)\n\t$3\nend\n$0'
	mysnip['l'] = 'function($1)\n\t$2\nend\n$0'
elseif filetype == 'rust' then
	mysnip['i'] = 'if $1 {\n\t$2\n}\n$0'
	mysnip['f'] = 'for $1 in $2 {\n\t$3\n}\n$0'
	mysnip['w'] = 'while $1 {\n\t$2\n}\n$0'
	mysnip['m'] = 'match $1 {\n\t$2\n}\n$0'
	mysnip['p'] = '$1 => $2,\n$0'
	mysnip['fn'] = 'fn $1($2) {\n\t$3\n}\n$0'
	mysnip['fnr'] = 'fn $1($2) -> $3 {\n\t$4\n}\n$0'
elseif filetype == 'tex' then
	mysnip['!'] = [[\documentclass[uplatex, dvipdfmx, a4paper]{bxjsarticle}
\usepackage{}
\title{$1}
\author{$2}
\date{}

\begin{document}
\maketitle
\newpage
$0
\end{document}]]
	mysnip['b'] = '\\begin{$1}\n$0'
	mysnip['e'] = '\\end{$1}\n$0'
	mysnip['s'] = '\\section{$1}\n$0'
	mysnip['sb'] = '\\subsection{$1}\n$0'
end

map('n', 'sn', function()
	local snip = mysnip[vim.fn.input('Input snippet: ')]
	if snip then
		vim.snippet.expand(snip)
	else
		print('snippet not found')
	end
end)

map({ 'i', 's' }, '<Tab>', function()
	if vim.snippet.active({ direction = 1 }) then
		return '<cmd>lua vim.snippet.jump(1)<CR>'
	else
		return '<Tab>'
	end
end, { expr = true })
