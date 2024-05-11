local o = vim.o

o.autoread = true
o.autowrite = true
o.backspace = ""
o.cmdheight = 1
o.complete = ".,w,b,u,t,kspell"
o.completeopt = "menu,longest,noselect"
vim.opt.cpoptions:append("$")
o.cursorline = true
o.foldmethod = "manual"
o.gdefault = true
o.guifont = "PlemolJP35 Console NF:h10"
o.helplang = "ja,en"
o.hidden = true
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.laststatus = 3
o.lazyredraw = true
o.list = true
o.listchars = "tab:│ ,trail:×,extends:>,precedes:<,nbsp:+"
o.matchpairs = "(:),{:},[:],<:>,=:;"
o.mouse = ""
o.number = true
o.omnifunc = "v:lua.vim.lsp.omnifunc"
o.path = ".,,,**"
o.ruler = true
o.scrolloff = 10
o.shiftwidth = 4
o.signcolumn = "yes"
o.smartcase = true
o.smartindent = true
o.statusline = "%m%r%h%w%=%=%F%=[TYPE=%Y][POS=%l,%c,%p%%,%P][BUF=%n]"
o.tabstop = 4
o.termguicolors = true
o.textwidth = 79
o.tildeop = true
o.timeout = false
o.virtualedit = "onemore"
o.wildmenu = true
o.writeany = true
o.wrap = false

vim.g.copilot_filetypes = { gitcommit = true, yaml = true, markdown = true }
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_transparency = 0.7
vim.g.transparency = 0.0
vim.g.neovide_cursor_smooth_blink = true
