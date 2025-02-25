.PHONY: build install

all: build install

build:
	nvim -c "lua Load_Plugin 'nvim-treesitter/nvim-treesitter'" -c "lua require 'nvim-treesitter'" -c "TSUpdate all" -c "q"

install:
	cp -r plugins/nvim-treesitter/nvim-treesitter/parser ~/.local/lib/nvim
	cp -r plugins/nvim-treesitter/nvim-treesitter/queries ~/.local/share/nvim/runtime
