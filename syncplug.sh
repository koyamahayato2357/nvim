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
	"nvim-telescope/telescope.nvim"
	"nvim-lua/plenary.nvim"
	"jonarrien/telescope-cmdline.nvim"
	"folke/noice.nvim"
)

plugdir="plugins/"

githuburl="https://github.com/"

root=$(pwd)

mkdir -p "$plugdir"
cd "$plugdir" || exit

for plugname in "${plugs[@]}"; do
	reponame=$(basename "$plugname")
	if [ -d "$reponame" ]; then
		if [ "$1" = "update" ] || [ -z "$1" ]; then
			cd "$reponame"
			git pull
			cd ..
		fi
	else
		if [ "$1" = "install" ] || [ -z "$1" ]; then
			git clone "$githuburl$plugname"
		fi
	fi
done

cd "$root" || exit
