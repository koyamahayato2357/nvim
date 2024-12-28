.PHONY: build install

all: build install

build:
	nvim -c "lua Load_Plugin 'nvim-treesitter'" -c "lua require 'nvim-treesitter'" -c "TSInstall all"

install:
	sudo cp -r plugins/nvim-treesitter/nvim-treesitter/parser /usr/local/lib/nvim
	sudo cp -r plugins/nvim-treesitter/nvim-treesitter/queries /usr/local/share/nvim/runtime
