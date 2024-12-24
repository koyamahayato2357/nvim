local au = vim.api.nvim_create_autocmd
local map = vim.keymap.set

function Treesitter_config()
	local installed = vim.fn.readdir('/usr/local/share/nvim/runtime/queries')
	local left = 1
	local right = #installed
	while left <= right do
		local mid = math.floor((left + right) / 2)
		if installed[mid] == vim.o.filetype then
			vim.treesitter.start()
			return
		elseif installed[mid] < vim.o.filetype then
			left = mid + 1
		else
			right = mid - 1
		end
	end
end

au({ "FileType" }, {
	callback = function()
		vim.loop.new_async(vim.schedule_wrap(function()
			Treesitter_config()
		end)):send()
	end
})

au({ "TextYankPost" }, {
	callback = function ()
		if vim.v.event.regname == '' then
			vim.fn.setreg(vim.v.event.operator, vim.fn.getreg())
		end
	end
})

au({ "CmdWinEnter" }, {
	callback = function()
		map('n', '<ESC>', '<cmd>q!<CR>', { buffer = true })
		vim.bo.filetype = 'vim'
	end
})

au({ "BufWinEnter" }, {
	pattern = "COMMIT_EDITMSG",
	callback = function()
		for i, s in ipairs(vim.fn.systemlist('git diff --cached')) do
			vim.fn.append(i - 1, "# " .. s)
		end
	end
})

au({ 'VimLeave' }, {
	callback = function()
		vim.cmd.wshada()
	end
})
