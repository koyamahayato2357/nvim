#!/bin/env nu

let plugdir = "plugins/"
mkdir $plugdir

[
	"altermo/ultimate-autopair.nvim"
	"echasnovski/mini.indentscope"
	"folke/flash.nvim"
	"gbprod/substitute.nvim"
	"kylechui/nvim-surround"
	"nvim-lua/plenary.nvim"
	"nvim-telescope/telescope.nvim"
	"nvim-tree/nvim-web-devicons"
	"s417-lama/carbonpaper.vim"
	"sidebar-nvim/sidebar.nvim"
	"stevearc/oil.nvim"
	"utilyre/sentiment.nvim"
	"vim-jp/nvimdoc-ja"
	"vim-jp/vimdoc-ja"
	"niuiic/core.nvim"
	"niuiic/track.nvim"
	"hadronized/hop.nvim"
	"koron/codic-vim"
	"zbirenbaum/copilot.lua"
	"ThePrimeagen/refactoring.nvim"
	"beauwilliams/statusline.lua"
	"nvim-treesitter/nvim-treesitter"
	"saghen/blink.cmp"
	"rafamadriz/friendly-snippets"
	"itmecho/neoterm.nvim"
	"folke/snacks.nvim"
	"SmiteshP/nvim-navic"
	"SmiteshP/nvim-navbuddy"
	"Munitanjim/nui.nvim"
	"sphamba/smear-cursor.nvim"
] | each {|plugname|
    let reponame = ($plugname | path basename)
	let repopath = $plugdir + $reponame

	if ($repopath | path exists) {
		git -C $repopath pull
	} else {
		git clone ("https://github.com/" + $plugname) $repopath --depth 1
	}
}
