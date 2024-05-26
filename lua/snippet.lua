local mysnip = {}
local filetype = vim.bo.filetype
local map = vim.keymap.set

if filetype == 'c' then
	mysnip['inc'] = '#include <$1>\n$0'
	mysnip['if'] = 'if ($1) {\n  $2\n}\n$0'
	mysnip['for'] = 'for ($1; $2; $3) {\n  $4\n}\n$0'
	mysnip['swi'] = 'switch ($1) {\n  $2\n}\n$0'
	mysnip['cas'] = 'case $1:\n  $0'
elseif filetype == 'lua' then
	mysnip['if'] = 'if $1 then\n\t$2\nend\n$0'
	mysnip['for'] = 'for $1 in $2 do\n\t$3\nend\n$0'
	mysnip['dfn'] = 'function $1($2)\n\t$3\nend\n$0'
	mysnip['fun'] = 'function($1)\n\t$2\nend\n$0'
elseif filetype == 'rust' then
	mysnip['if'] = 'if $1 {\n\t$2\n}\n$0'
	mysnip['for'] = 'for $1 in $2 {\n\t$3\n}\n$0'
	mysnip['whi'] = 'while $1 {\n\t$2\n}\n$0'
	mysnip['mat'] = 'match $1 {\n\t$2\n}\n$0'
	mysnip['pat'] = '$1 => $2,\n$0'
	mysnip['dfn'] = 'fn $1($2) {\n\t$3\n}\n$0'
	mysnip['dfnr'] = 'fn $1($2) -> $3 {\n\t$4\n}\n$0'
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
	mysnip['beg'] = '\\begin{$1}\n$0'
	mysnip['end'] = '\\end{$1}\n$0'
	mysnip['sec'] = '\\section{$1}\n$0'
	mysnip['sbs'] = '\\subsection{$1}\n$0'
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
