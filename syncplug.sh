plugs=(
	"L3MON4D3/LuaSnip"
	"s417-lama/carbonpaper.vim"
	"github/copilot.vim"
	"folke/flash.nvim"
	"echasnovski/mini.indentscope"
	"folke/noice.nvim"
	"MunifTanjim/nui.nvim"
	"catppuccin/nvim"
	"nvim-surround"
	"nvim-tree/nvim-web-devicons"
	"vim-jp/nvimdoc-ja"
	"stevearc/oil.nvim"
	"utilyre/sentiment.nvim"
	"sidebar-nvim/sidebar.nvim"
	"gbprod/substitute.nvim"
	"akinsho/toggleterm.nvim"
	"altermo/ultimate-autopair.nvim"
	"vim-jp/vimdoc-ja"
)

plugdir="plugins/"

root=$(pwd)

[ -d "$plugdir" ] || mkdir -p "$plugdir"
cd "$plugdir"

for plugname in "${plugs[@]}"; do
	reponame=$(basename "$plugname")
	if [ -d "$plugname" ]; then
		cd "$plugname"
		git pull
		cd ..
	else
		git clone "http://github.com/$plugurl"
	fi
done

cd "$root"
