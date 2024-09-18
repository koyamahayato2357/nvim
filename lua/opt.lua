local o = vim.opt

o.autoread = true
o.autowrite = true
o.clipboard = 'unnamedplus'
o.cmdheight = 1
o.complete = "w,i,d,kspell"
o.completeopt = "menu,longest,noselect,fuzzy"
o.cursorline = true
o.foldmethod = "manual"
o.fillchars = { stl = '-', stlnc = '-' }
o.gdefault = true
o.guifont = "PlemolJP35 Console NF:h8"
o.helplang = "ja,en"
o.hidden = true
o.ignorecase = true
o.hlsearch = false
o.incsearch = true
o.laststatus = 0
o.mouse = ""
o.number = false
o.path = ".,,,**"
o.ruler = false
o.scrolloff = 10
o.shada = ''
o.shiftwidth = 4
o.showcmd = false
o.showmode = false
o.signcolumn = "yes"
o.smartcase = true
o.smartindent = true
o.statusline = '-'
o.tabstop = 4
o.termguicolors = true
o.textwidth = 79
o.timeout = false
o.undodir = vim.fn.stdpath("data") .. "/undo"
o.undofile = true
o.wildmenu = true
o.wrap = false

vim.g.copilot_filetypes = { gitcommit = true, yaml = true, markdown = true }

if vim.g.neovide then
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_transparency = 0.7
	vim.g.transparency = 0.0
	vim.g.neovide_cursor_smooth_blink = true
end
