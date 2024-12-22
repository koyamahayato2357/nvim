-- like <C-x><C-e> in emacs
vim.keymap.set('n', 'sc', function()
	function Do_nothing() end
	vim.o.operatorfunc = 'v:lua.Do_nothing'
	vim.cmd.normal 'g@ab'
	local beginpos = vim.fn.getpos("'[")
	local lastpos = vim.fn.getpos("']")

	local begin
	local last

	if lastpos[2] < beginpos[2] or lastpos[3] < beginpos[3] then
		begin = { lastpos[2] - 1, lastpos[3] - 1 }
		last = { beginpos[2] - 1, beginpos[3] }
	else
		begin = { beginpos[2] - 1, beginpos[3] - 1 }
		last = { lastpos[2] - 1, lastpos[3] }
	end

	local sexpr = vim.api.nvim_buf_get_text(0, begin[1], begin[2], last[1], last[2], {})

	local tmpfilename = '/tmp/nvim-scheme-ftplugin.scm'
	local file = assert(io.open(tmpfilename, 'w'))
	for _, line in ipairs(sexpr) do
		file:write(line .. '\n')
	end
	file:close()

	vim.cmd('vert term scheme ' .. tmpfilename)
end)
