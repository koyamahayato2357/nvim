local mysnip = {}
local filetype = vim.bo.filetype
local map = vim.keymap.set

if filetype == 'c' then
	mysnip['inc'] = '#include <$1>\n$0'
elseif filetype == 'lua' then
	mysnip['if'] = 'if $1 then\n\t$2\nend\n$0'
end

map('i', 'ŝ')
