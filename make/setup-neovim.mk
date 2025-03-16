CC = ccache clang
BUILD_TYPE = Release
PREFIX ?= ~/.local

all: install normalize-runtime

install: plugins/neovim/neovim
	$(MAKE) -C $^ install CMAKE_C_COMPILER="$(CC)" CMAKE_BUILD_TYPE=$(BUILD_TYPE) CMAKE_INSTALL_PREFIX=$(PREFIX)

# about 3ms faster startup
normalize-runtime:
	rm -rf $(PREFIX)/share/nvim/runtime/plugin
	rm -rf $(PREFIX)/share/nvim/runtime/pack
