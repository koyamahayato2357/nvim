local au = vim.api.nvim_create_autocmd
local map = vim.keymap.set

function Lsp_config(name, cmd, root)
	vim.lsp.start({
		name = name,
		cmd = { cmd },
		root_dir = root
	})
	map('n', '=', vim.lsp.buf.format)
end

au({ "FileType" }, {
	callback = function()
		local filetype = vim.bo.filetype
		if filetype == "c" or filetype == "cpp" then
			Lsp_config("clangd", "clangd")
			vim.bo.expandtab = true
			vim.bo.shiftwidth = 2
			vim.bo.tabstop = 2
			map({ 'n', 'i' }, '<C-l>', '<C-o>A;')
		elseif filetype == "rust" then
			Lsp_config("rust", "rust-analyzer")
			map({ 'n', 'i' }, '<C-l>', '<C-o>A;')
		elseif filetype == "lua" then
			Lsp_config("lua", "lua-language-server", vim.fn.stdpath('config'))
			map({ 'n', 'i' }, '<C-l>', '<C-o>A,')
		elseif filetype == "tex" then
			Lsp_config("tex", "texlab")
		elseif filetype == "asm" then
			Lsp_config("asm", "asm-lsp")
		elseif filetype == "zsh" then
			vim.bo.filetype = "bash"
		elseif filetype == "lisp" then
			vim.bo.filetype = "commonlisp"
			vim.bo.expandtab = true
			vim.bo.shiftwidth = 2
			vim.bo.tabstop = 2
		elseif filetype == "go" then
			Lsp_config("go", "gopls")
		end
	end
})

au({ "Filetype" }, {
	pattern = 'help',
	callback = function()
		map('n', '<Space>', '<C-f>', { buffer = 0 })
		map('n', '<CR>', '<C-e>', { buffer = 0 })
		map('n', '<BS>', '<C-y>', { buffer = 0 })
		map('n', 'b', '<C-b>', { buffer = 0 })
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

au({ "BufEnter" }, {
	callback = function()
		require 'snippet'
	end
})

au({ "InsertEnter" }, {
	callback = function()
		vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
		vim.api.nvim_set_hl(0, "CursorLineNr", { underline = true })
	end
})
au({ "InsertLeave" }, {
	callback = function()
		vim.api.nvim_set_hl(0, "CursorLine", { underline = false })
		vim.api.nvim_set_hl(0, "CursorLineNr", { underline = false })
	end
})

au({ 'VimLeave' }, {
	callback = function()
		vim.cmd.wshada()
	end
})
