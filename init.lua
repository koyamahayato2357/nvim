require('opt')
require('map')
require('plugin')
require('autocmd')
require('gitlens')

vim.cmd.cabbrev { "nvimrc", "~/.config/nvim/init.lua" }

vim.cmd.colorscheme'catppuccin'
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
vim.api.nvim_set_hl(0, "Error", { bg = "none" })
vim.api.nvim_set_hl(0, "ErrorMsg", { bg = "none" })
