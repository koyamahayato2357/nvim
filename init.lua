vim.opt.runtimepath = "~/.config/nvim,/usr/local/share/nvim/runtime,/usr/local/lib/nvim"

local clibpath = vim.fn.stdpath('config') .. '/lib/?.so'
package.cpath = package.cpath .. ';' .. clibpath

require 'autocmd'
require 'cdtrack'
require 'dmacro'
require 'fcitx5'
require 'gitlens'
require 'map'
require 'opt'
require 'plugin'
require 'rainbow'
