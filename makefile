.PHONY: lib-build lib-clean plug-install plug-sync plug-gc plug-clean

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
PLUGINS := MunifTanjim/nui.nvim.git \
		   SmiteshP/nvim-navbuddy.git \
		   SmiteshP/nvim-navic.git \
		   ThePrimeagen/refactoring.nvim.git \
		   altermo/ultimate-autopair.nvim.git \
		   beauwilliams/statusline.lua.git \
		   folke/flash.nvim.git \
		   folke/snacks.nvim.git \
		   gbprod/substitute.nvim.git \
		   hadronized/hop.nvim.git \
		   koron/codic-vim.git \
		   kylechui/nvim-surround.git \
		   niuiic/core.nvim.git \
		   niuiic/track.nvim.git \
		   nvim-lua/plenary.nvim.git \
		   nvim-telescope/telescope.nvim.git \
		   nvim-tree/nvim-web-devicons.git \
		   nvim-treesitter/nvim-treesitter.git \
		   rafamadriz/friendly-snippets.git \
		   s417-lama/carbonpaper.vim.git \
		   saghen/blink.cmp.git \
		   sidebar-nvim/sidebar.nvim.git \
		   stevearc/oil.nvim.git \
		   utilyre/sentiment.nvim.git \
		   vim-jp/nvimdoc-ja.git \
		   vim-jp/vimdoc-ja.git \
		   zbirenbaum/copilot.lua.git \

# extract repository name from PLUGINS
# basename: remove .git (suffix) ; $(basename account/repo.git) -> account/repo
# notdir:   remove account name  ; $(notdir account/repo)       -> repo
REPONAME := $(notdir $(basename $@))
REPONAMES := $(notdir $(basename $(PLUGINS)))

# destination directory name
PLUGIN_PATH := $(PLUGINDIR)/$(REPONAME)

# list of installed repositories
PLUGIN_INSTALLED := $(shell ls $(PLUGINDIR))

# repositories deleted from the list
# filter-out: filter listed repos ; $(filter-out a, a b c) -> b c
GARBAGES := $(filter-out $(REPONAMES), $(PLUGIN_INSTALLED))
GARBAGE_PATHS := $(addprefix $(PLUGIN_PATH)/, $(GARBAGES))

%.git:
	[ -d $(PLUGIN_PATH) ] || git clone --depth 1 $(GITHUB_URL)/$@ $(PLUGIN_PATH)

%.git-sync: %.git
	cd $(PLUGIN_PATH) && git pull

%.git-rm:
	[ -d $(PLUGIN_PATH) ] && rm -rf $(PLUGIN_PATH)

plug-install: $(PLUGINS)

plug-sync: $(addsuffix -sync, $(PLUGINS))

plug-gc: $(GARBAGE_PATHS)
ifneq (,$^)
	rm -rf $^
else
	@echo "gc: nothing to do"
endif

plug-clean: $(addsuffix -rm, $(PLUGINS))
