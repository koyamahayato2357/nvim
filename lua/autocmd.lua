local au = vim.api.nvim_create_autocmd
local map = vim.keymap.set

function Lsp_config(name, cmd, root)
	vim.lsp.start({
		name = name,
		cmd = cmd,
		root_dir = root
	})
	map('n', '=', vim.lsp.buf.format)
	map('n', '^h', function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end)
end

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

local function is_exist_file_in_parent_dir(file)
	local curdir = vim.fn.getcwd()
	while curdir ~= '/' do
		local full_path = curdir .. '/' .. file
		if vim.fn.filereadable(full_path) == 1 then
			return true
		end
		curdir = vim.fn.fnamemodify(curdir, ':h')
	end
	return false
end

au({ "FileType" }, {
	callback = function()
		vim.loop.new_async(vim.schedule_wrap(function()
			Treesitter_config()
		end)):send()

		local filetype = vim.bo.filetype
		if filetype == "c" or filetype == "cpp" then
			if is_exist_file_in_parent_dir("platformio.ini") then
				Lsp_config("clangd", { "clangd", "--background-index",
					"--query-driver=/home/sundo/.platformio/packages/toolchain-gccarmnoneeabi@1.90201.191206/bin/arm-none-eabi-g++" })
			else
				Lsp_config("clangd", { "clangd" })
			end
			vim.bo.expandtab = true
			vim.bo.shiftwidth = 2
			vim.bo.tabstop = 2
		elseif filetype == "rust" then
			Lsp_config("rust", { "rust-analyzer" })
		elseif filetype == "lua" then
			Lsp_config("lua", { "lua-language-server" }, vim.fn.stdpath('config'))
		elseif filetype == "fish" then
			Lsp_config("fish", { "fish-lsp", "start" })
		elseif filetype == "tex" then
			Lsp_config("tex", { "texlab" })
		elseif filetype == "asm" then
			Lsp_config("asm", { "asm-lsp" })
		elseif filetype == "lisp" then
			vim.bo.filetype = "commonlisp"
			vim.bo.expandtab = true
			vim.bo.shiftwidth = 2
			vim.bo.tabstop = 2
		elseif filetype == "go" then
			Lsp_config("go", { "gopls" })
		elseif filetype == "zig" then
			Lsp_config("zig", { "zls" })
			vim.bo.expandtab = true
			vim.bo.shiftwidth = 4
			vim.bo.tabstop = 4
		end

		require 'colorscheme'
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
