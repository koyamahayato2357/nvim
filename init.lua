vim.opt.runtimepath = "~/.config/nvim,/usr/local/nvim/share/nvim/runtime,/usr/local/nvim/lib/nvim"

require 'opt'
require 'map'
require 'plugin'
require 'autocmd'
require 'gitlens'
require 'fzf'
-- require 'dmacro'
require 'mydmacro'

vim.cmd.cabbrev { "nvimrc", "~/.config/nvim/init.lua" }
