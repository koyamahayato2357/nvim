local au = vim.api.nvim_create_autocmd

--- evaluate code selected in visual mode
---@param cmd string[]
local function quickeval(cmd)
	local range = require 'utils'.get_visual_selection()
	local begin = range.start
	local last = range.last

	begin[1] = begin[1] - 1
	last[1] = last[1] - 1
	last[2] = last[2] + 1

	local content = vim.api.nvim_buf_get_text(0, begin[1], begin[2], last[1], last[2], {})

	local tmpfilename = '/tmp/nvim-ftplugin.' .. vim.fn.expand('%:e')
	local file = assert(io.open(tmpfilename, 'w'))
	for _, line in ipairs(content) do
		file:write(line .. '\n')
	end
	file:close()

	vim.cmd('vert term ' .. cmd .. ' '.. tmpfilename)
	vim.cmd.startinsert()
end

au("FileType", {
	buffer = 0,
	callback = function(ev)
		local ft = ev.match
		local ok, ftp = pcall(require, 'ftplugin.' .. ft)
		if not ok then return end

		if ftp.lsp then
			vim.loop.new_async(vim.schedule_wrap(function()
				vim.lsp.start(ftp.lsp)
			end)):send()
			require 'lsp'
		end
		if ftp.quickeval_cmd then
			vim.keymap.set('v', 'x', function()
				quickeval(ftp.quickeval_cmd)
			end)
		end
		if ftp.callback then
			ftp.callback()
		end
	end
})
