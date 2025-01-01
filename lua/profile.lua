local snacks = vim.fn.stdpath('config') .. '/plugins/folke/snacks.nvim'
vim.o.rtp = vim.o.rtp .. ',' .. snacks
require 'snacks.profiler'.startup({
	startup = {
		event = 'UIEnter'
	}
})
