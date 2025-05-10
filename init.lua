-- overwrite superfluous paths
vim.opt.runtimepath = "~/.config/nvim,~/.local/share/nvim/runtime,~/.local/lib/nvim"

if vim.env.NVIM_PROF then require 'profile' end

local clibpath = vim.fn.stdpath('config') .. '/lib/?.so'
package.cpath = package.cpath .. ';' .. clibpath

require 'autocmd'
require 'dmacro'
require 'fcitx5'
require 'ftplugin'
require 'gitlens'
require 'goto_txtobj'
require 'opt'
require 'plugin'
require 'colorscheme'
require 'ui'
