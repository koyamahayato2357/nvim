vim.opt.runtimepath = "~/.config/nvim,/usr/local/share/nvim/runtime,/usr/local/lib/nvim"

require 'opt'
require 'map'
require 'plugin'
require 'autocmd'
require 'gitlens'
require 'fzf'
require 'dmacro'
require 'command'

vim.cmd.cabbrev { "nvimrc", "~/.config/nvim/init.lua" }
