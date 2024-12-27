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

build: $(TARGETS)

lib/%.so: src/%
	$(CC) $</*.c $(CFLAGS) $(LDFLAGS) -o $@

GITHUB_URL = https://github.com
PLUGINDIR = plugins
PLUGINS = altermo/ultimate-autopair.nvim.git \
          folke/flash.nvim.git \
          gbprod/substitute.nvim.git \
          kylechui/nvim-surround.git \
          nvim-lua/plenary.nvim.git \
          nvim-telescope/telescope.nvim.git \
          nvim-tree/nvim-web-devicons.git \
          s417-lama/carbonpaper.vim.git \
          sidebar-nvim/sidebar.nvim.git \
          stevearc/oil.nvim.git \
          utilyre/sentiment.nvim.git \
          vim-jp/nvimdoc-ja.git \
          vim-jp/vimdoc-ja.git \
          niuiic/core.nvim.git \
          niuiic/track.nvim.git \
          hadronized/hop.nvim.git \
          koron/codic-vim.git \
          zbirenbaum/copilot.lua.git \
          ThePrimeagen/refactoring.nvim.git \
          beauwilliams/statusline.lua.git \
          nvim-treesitter/nvim-treesitter.git \
          saghen/blink.cmp.git \
          rafamadriz/friendly-snippets.git \
          folke/snacks.nvim.git \
          SmiteshP/nvim-navic.git \
          SmiteshP/nvim-navbuddy.git \
          MunifTanjim/nui.nvim.git

%.git:
	[ -d $(PLUGINDIR)/$(notdir $(basename $@)) ] || git clone --depth 1 $(GITHUB_URL)/$@ $(PLUGINDIR)/$(notdir $(basename $@))

%.git-sync: $(PLUGINS)
	cd $(notdir $(basename $@)) && git pull

plug-install: | $(PLUGINS)

plug-sync: | $(addsuffix -sync, $(PLUGINS))

clean:
	rm $(TARGETS)
