CC = ccache clang-20
BUILD_TYPE = Release

install: plugins/neovim/neovim
	$(MAKE) -C $^ install CMAKE_C_COMPILER="$(CC)" CMAKE_BUILD_TYPE=$(BUILD_TYPE) CMAKE_INSTALL_PREFIX=~/.local
