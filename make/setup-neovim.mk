CC = ccache clang
BUILD_TYPE = Release
PREFIX ?= ~/.local

install: plugins/neovim/neovim
	$(MAKE) -C $^ install CMAKE_C_COMPILER="$(CC)" CMAKE_BUILD_TYPE=$(BUILD_TYPE) CMAKE_INSTALL_PREFIX=$(PREFIX)
