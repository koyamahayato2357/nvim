local au = vim.api.nvim_create_autocmd

function Lsp_config(name, cmd, root)
	vim.lsp.start({
		name = name,
		cmd = { cmd },
		root_dir = root
	})
end

au({ "FileType" }, {
	callback = function()
		local filetype = vim.bo.filetype
		if filetype == "c" or filetype == "cpp" then
			Lsp_config("clangd", "clangd")
		elseif filetype == "rust" then
			Lsp_config("rust", "rust-analyzer")
		elseif filetype == "lua" then
			Lsp_config("lua", "lua-language-server", "/home/sundo/.config/nvim/")
		elseif filetype == "tex" then
			Lsp_config("tex", "texlab")
		elseif filetype == "asm" then
			Lsp_config("asm", "asm-lsp")
		elseif filetype == "zsh" then
			vim.bo.filetype = "bash"
			vim.treesitter.start()
		elseif filetype == "lisp" then
			vim.bo.filetype = "commonlisp"
			vim.treesitter.start()
		elseif filetype == "go" then
			Lsp_config("go", "gopls")
		elseif filetype == "html" then
			Lsp_config("html", "vscode-html-languageserver")
		elseif filetype == "css" then
			Lsp_config("css", "vscode-css-languageserver")
		elseif filetype == "javascript" or filetype == "typescript" then
			Lsp_config("jsts", "typescript-language-server")
		end
	end
})

au({ "BufWinEnter" }, {
	pattern = "COMMIT_EDITMSG",
	callback = function()
		vim.api.nvim_buf_set_lines(0, 0, 1, vim.fn.systemlist('git diff --cached'))
		for i, s in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
			if s[1] ~= '#' then
				vim.api.nvim_buf_set_lines(0, i, i + 1, false, { '#' .. s })
			end
		end
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
