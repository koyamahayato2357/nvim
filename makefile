.PHONY: lib-build lib-clean plug-install plug-sync plug-gc plug-clean normalize-runtime setup

CC = clang

SRCDIRS = $(wildcard src/*)
TARGETS = $(patsubst src/%, lib/%.so, $(SRCDIRS))

INCDIR = include

CFLAGS := -std=c23 -I$(INCDIR) -Wtautological-compare -Wsign-compare -Wall    \
          -Wextra -fforce-emit-vtables -ffunction-sections -fdata-sections    \
		  -faddrsig -march=native -mtune=native -funroll-loops -fomit-frame-pointer \
		  -fPIC -O3
LDFLAGS = -flto=full -fwhole-program-vtables -funroll-loops -fomit-frame-pointer \
		  -O3 -shared

lib-build: $(TARGETS)

lib/%.so: src/%
	$(CC) $</*.c $(CFLAGS) $(LDFLAGS) -o $@

lib-clean:
	rm $(TARGETS)

GITHUB_URL := https://github.com
PLUGINDIR := plugins
PLUGINS := MunifTanjim/nui.nvim \
		   SmiteshP/nvim-navbuddy \
		   SmiteshP/nvim-navic \
		   ThePrimeagen/refactoring.nvim \
		   altermo/ultimate-autopair.nvim \
		   beauwilliams/statusline.lua \
		   folke/flash.nvim \
		   folke/snacks.nvim \
		   gbprod/substitute.nvim \
		   hadronized/hop.nvim \
		   koron/codic-vim \
		   kylechui/nvim-surround \
		   niuiic/core.nvim \
		   niuiic/track.nvim \
		   nvim-lua/plenary.nvim \
		   nvim-telescope/telescope.nvim \
		   nvim-tree/nvim-web-devicons \
		   nvim-treesitter/nvim-treesitter \
		   rafamadriz/friendly-snippets \
		   saghen/blink.cmp \
		   sidebar-nvim/sidebar.nvim \
		   stevearc/oil.nvim \
		   utilyre/sentiment.nvim \
		   vim-jp/nvimdoc-ja \
		   vim-jp/vimdoc-ja \
		   zbirenbaum/copilot.lua \

# destination directory name
PLUGIN_PATHS := $(addprefix $(PLUGINDIR)/, $(PLUGINS))

# list of installed repositories
ACCOUNTS_EXIST := $(shell ls $(PLUGINDIR))
REPOS_INSTALLED := $(patsubst plugins/%, %, $(shell find $(PLUGINDIR) -mindepth 2 -maxdepth 2 -type d))
# repositories deleted from the list
# filter-out: filter listed repos ; $(filter-out a, a b c) -> b c
GARBAGE_ACCOUNTS := $(filter-out $(patsubst %/, %, $(dir $(PLUGINS))), $(ACCOUNTS_EXIST))
GARBAGE_ACCOUNTS_PATHS := $(addprefix $(PLUGINDIR)/, $(GARBAGE_ACCOUNTS))
GARBAGE_REPOS := $(filter-out $(PLUGINS), $(REPOS_INSTALLED))
GARBAGE_REPOS_PATHS := $(addprefix $(PLUGINDIR)/, $(GARBAGE_REPOS))
GARBAGES := $(GARBAGE_REPOS_PATHS) $(GARBAGE_ACCOUNTS_PATHS)

$(PLUGINDIR)/%:
	git clone --depth 1 $(GITHUB_URL)/$* $@

%.plug-sync: $(PLUGINDIR)/$*
	cd $(PLUGINDIR)/$* && git pull

%.plug-rm: $(PLUGINDIR)/$*
	rm -rf $(PLUGINDIR)/$*

plug-install: $(PLUGIN_PATHS)

plug-sync: $(addsuffix .plug-sync, $(PLUGINS))

plug-gc: $(GARBAGES)
ifneq (,$^)
	rm -rf $^
endif

plug-clean: $(addsuffix .plug-rm, $(PLUGINS))

# about 3ms faster startup
normalize-runtime:
	sudo rm -rf /usr/local/share/nvim/runtime/plugin
	sudo rm -rf /usr/local/share/nvim/runtime/pack

setup:
	$(MAKE) normalize-runtime
	$(MAKE) lib-build
	$(MAKE) plug-install
	$(MAKE) -f make/setup-blink.mk
	$(MAKE) -f make/setup-treesitter.mk
