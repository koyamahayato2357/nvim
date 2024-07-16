vim.opt.runtimepath = "~/.config/nvim,/usr/local/share/nvim/runtime,/usr/local/lib/nvim"

require 'autocmd'
require 'command'
require 'fzf'
require 'gitlens'
require 'map'
require 'opt'
require 'plugin'

vim.cmd.cabbrev { "nvimrc", "~/.config/nvim/init.lua" }
