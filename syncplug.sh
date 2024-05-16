plugs=(
	"https://github.com/L3MON4D3/LuaSnip"
	"https://github.com/s417-lama/carbonpaper.vim"
	"https://github.com/github/copilot.vim"
	"https://github.com/folke/flash.nvim"
	"https://github.com/echasnovski/mini.indentscope"
	"https://github.com/folke/noice.nvim"
	"https://github.com/MunifTanjim/nui.nvim"
	"https://github.com/catppuccin/nvim"
	"https://github.com/nvim-surround"
	"https://github.com/nvim-tree/nvim-web-devicons"
	"https://github.com/vim-jp/nvimdoc-ja"
	"https://github.com/stevearc/oil.nvim"
	"https://github.com/utilyre/sentiment.nvim"
	"https://github.com/sidebar-nvim/sidebar.nvim"
	"https://github.com/gbprod/substitute.nvim"
	"https://github.com/akinsho/toggleterm.nvim"
	"https://github.com/altermo/ultimate-autopair.nvim"
	"https://github.com/vim-jp/vimdoc-ja"
)

plugdir="plugins/"

root=$(pwd)

[ -d "$plugdir" ] || mkdir -p "$plugdir"
cd "$plugdir"

for plugurl in "${plugs[@]}"; do
	plugname=$(basename "$plugurl")
	if [ -d "$plugname" ]; then
		cd "$plugname"
		git pull
		cd ..
	else
		git clone "$plugurl"
	fi
done

cd "$root"
