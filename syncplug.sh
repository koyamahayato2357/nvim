plugs=(
	"MunifTanjim/nui.nvim"
	"akinsho/toggleterm.nvim"
	"altermo/ultimate-autopair.nvim"
	"catppuccin/nvim"
	"echasnovski/mini.indentscope"
	"folke/flash.nvim"
	"folke/noice.nvim"
	"gbprod/substitute.nvim"
	"kylechui/nvim-surround"
	"nvim-tree/nvim-web-devicons"
	"nvimdev/dashboard-nvim"
	"s417-lama/carbonpaper.vim"
	"sidebar-nvim/sidebar.nvim"
	"stevearc/oil.nvim"
	"utilyre/sentiment.nvim"
	"vim-jp/nvimdoc-ja"
	"vim-jp/vimdoc-ja"
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
