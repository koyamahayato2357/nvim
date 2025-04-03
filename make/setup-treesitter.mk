.PHONY: build install

PREFIX ?= ~/.local

all: build install

build:
	nvim -c "lua Load_plugin 'nvim-treesitter/nvim-treesitter'" -c "lua require 'nvim-treesitter'" -c "TSUpdate all" -c "q"

install:
	cp -r plugins/nvim-treesitter/nvim-treesitter/parser $(PREFIX)/lib/nvim
	cp -r plugins/nvim-treesitter/nvim-treesitter/queries $(PREFIX)/share/nvim/runtime
