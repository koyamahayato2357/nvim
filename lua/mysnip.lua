local mysnip = {}
local filetype = vim.bo.filetype
local map = vim.keymap.set

if filetype == 'c' then
	mysnip['inc'] = '#include <$1>\n$0'
	mysnip['if'] = 'if ($1) {\n\t$2\n}\n$0'
	mysnip['eli'] = 'else if ($1) {\n$2\n}\n$0'
	mysnip['els'] = 'else {\n$1\n}\n$0'
	mysnip['for'] = 'for ($1; $2; $3) {\n\t$4\n}\n$0'
elseif filetype == 'lua' then
	mysnip['if'] = 'if $1 then\n\t$2\nend\n$0'
	mysnip['eli'] = 'elseif $1 then\n$0'
	mysnip['els'] = 'else\n\t$0'
	mysnip['dfn'] = 'function $1($2)\n\t$3\nend\n$0'
	mysnip['fun'] = 'function($1)\n\t$2\nend\n$0'
end

map('i', 'ŝ', function()
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
