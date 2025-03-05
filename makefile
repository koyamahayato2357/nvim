.PHONY: lib-build lib-clean plug-install plug-sync plug-gc plug-clean normalize-runtime setup

CC = clang

SRCDIRS = $(wildcard src/*)
TARGETS = $(patsubst src/%, lib/%.so, $(SRCDIRS))

CFLAGS := -std=c2y -Wtautological-compare -Wsign-compare -Wall -Wextra -O3 \
		  -fforce-emit-vtables -ffunction-sections -fdata-sections -fPIC \
		  -faddrsig -march=native -mtune=native -funroll-loops -fomit-frame-pointer
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
		   andersevenrud/nvim_context_vt \
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
		   sphamba/smear-cursor.nvim \
		   neovim/neovim \

# destination directory name
PLUGIN_PATHS := $(addprefix $(PLUGINDIR)/, $(PLUGINS))

# list of installed repositories
ACCOUNTS_EXIST := $(wildcard $(PLUGINDIR)/*/) # plugin/account1/ plugin/account2/ plugin/account3/ ...
REPOS_INSTALLED_PATHS := $(wildcard $(PLUGINDIR)/*/*) # plugin/account1/plug1 plugin/account2/plug1 ...
# repositories deleted from the list
# filter-out: filter listed repos ; $(filter-out a, a b c) -> b c
GARBAGE_ACCOUNTS_PATHS := $(filter-out $(dir $(PLUGINS)), $(notdir $(ACCOUNTS_EXIST))) # accountN/ accountM/ ...
GARBAGE_REPOS_PATHS := $(filter-out $(PLUGIN_PATHS), $(REPOS_INSTALLED_PATHS)) # plugin/accountN/plugN ...
GARBAGES := $(GARBAGE_REPOS_PATHS) $(GARBAGE_ACCOUNTS_PATHS)

NEOVIM_PREFIX := ~/.local

$(PLUGINDIR)/%:
	git clone --depth 1 $(GITHUB_URL)/$* $@

%/plug-sync: $(PLUGINDIR)/%
	cd $< && git pull

%/plug-rm:
	rm -rf $(PLUGINDIR)/$*

plug-install: $(PLUGIN_PATHS)

plug-sync: $(addsuffix /plug-sync, $(PLUGINS))

plug-gc:
ifneq ($(strip $(GARBAGES)),)
	rm -rf $(GARBAGES)
endif

plug-clean: $(addsuffix /plug-rm, $(PLUGINS))

plug-update:
	$(MAKE) plug-sync
	$(MAKE) -f make/setup-blink.mk
	$(MAKE) -f make/setup-treesitter.mk PREFIX=$(NEOVIM_PREFIX)
	$(MAKE) -f make/setup-neovim.mk PREFIX=$(NEOVIM_PREFIX)
	$(MAKE) normalize-runtime

# about 3ms faster startup
normalize-runtime:
	rm -rf $(NEOVIM_PREFIX)/share/nvim/runtime/plugin
	rm -rf $(NEOVIM_PREFIX)/share/nvim/runtime/pack

setup: plug-update lib-build

LLMFILE ?= llmfile.txt
FILES ?= makefile init.lua
DIRS ?= lua lua/ftplugin src/fuzpath make
FILES_IN_DIRS := $(wildcard $(addsuffix /*.*, $(DIRS)))
LIST_FILES ?= $(FILES) $(FILES_IN_DIRS)
$(LLMFILE): $(LIST_FILES) # for the LLM to read
	echo $^ | sed 's/ /\n/g' > $@
	echo >> $@ # newline
	# `head` automatically inserts the file name at the start of the file
	head -n 9999 $^ >> $@

llmfile: $(LLMFILE)
