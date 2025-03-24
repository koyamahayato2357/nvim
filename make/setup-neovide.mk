NEOVIDE_PATH ?= .

build:
	cd $(NEOVIDE_PATH) && cargo install --path .
