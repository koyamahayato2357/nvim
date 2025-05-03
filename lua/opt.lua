local o = vim.opt

o.autoread = true
o.autowrite = true
o.complete = "w,i,d,kspell"
o.completeopt = "menu,longest,noselect,fuzzy"
o.cursorline = true
o.expandtab = true
o.foldmethod = "manual"
o.fillchars = { stl = ' ', stlnc = ' ' }
o.gdefault = true
o.guifont = "PlemolJP35 Console:h8"
o.helplang = "ja,en"
o.hidden = true
o.ignorecase = true
o.hlsearch = false
o.incsearch = false
o.laststatus = 0
o.mouse = ""
o.number = false
o.path = ".,,,**"
o.ruler = false
o.scrolloff = 10
o.shada = ''
o.shell = '/bin/zsh'
o.shiftwidth = 4
o.showcmd = false
o.showmode = false
o.showtabline = 0
o.signcolumn = "yes"
o.smartcase = true
o.smartindent = true
o.statusline = ' '
o.tabstop = 4
o.termguicolors = true
o.textwidth = 0
o.timeout = false
o.undodir = vim.fn.stdpath("data") .. "/undo"
o.undofile = true
o.wildmenu = true
o.wrap = false

vim.g.copilot_filetypes = { gitcommit = true, yaml = true, markdown = true }

if vim.g.neovide then
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_opacity = 0.1
	vim.g.transparency = 0.0
	vim.g.neovide_text_gamma = 0
	vim.g.neovide_text_contrast = 0.0
	vim.g.neovide_cursor_smooth_blink = true
	vim.g.terminal_color_0  = '#171717' -- black
	vim.g.terminal_color_1  = '#d81765' -- normal red
	vim.g.terminal_color_2  = '#97d01a' -- normal green
	vim.g.terminal_color_3  = '#ffa800' -- normal yellow
	vim.g.terminal_color_4  = '#16b1fb' -- normal blue
	vim.g.terminal_color_5  = '#ff2491' -- normal magenta
	vim.g.terminal_color_6  = '#0fdcb6' -- normal cyan
	vim.g.terminal_color_7  = '#ebebeb' -- light gray
	vim.g.terminal_color_8  = '#88757c' -- dark gray
	vim.g.terminal_color_9  = '#ff0000' -- bright red
	vim.g.terminal_color_10 = '#76b639' -- bright green
	vim.g.terminal_color_11 = '#f7b125' -- bright yellow
	vim.g.terminal_color_12 = '#289cd5' -- bright blue
	vim.g.terminal_color_13 = '#ff2491' -- bright magenta
	vim.g.terminal_color_14 = '#0a9b81' -- bright cyan
	vim.g.terminal_color_15 = '#f8f8f8' -- white
end
