local au = vim.api.nvim_create_autocmd
local map = vim.keymap.set

function Treesitter_config()
	local prefix = '/usr/local/share/nvim/runtime/queries/'
	if vim.uv.fs_stat(prefix .. vim.o.filetype) then
		vim.treesitter.start()
	end
end

au({ "UIEnter" }, {
	callback = function()
		require 'map'
		Treesitter_config()
	end
})

au({ 'CmdLineEnter' }, {
	callback = function()
		require 'cdtrack'
	end
})

au({ "TextYankPost" }, {
	callback = function()
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

au({ 'VimLeave' }, { callback = vim.cmd.wshada })
