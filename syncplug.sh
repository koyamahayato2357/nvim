readonly plugs=(
	"MunifTanjim/nui.nvim"
	"akinsho/toggleterm.nvim"
	"altermo/ultimate-autopair.nvim"
	"echasnovski/mini.indentscope"
	"folke/flash.nvim"
	"folke/noice.nvim"
	"gbprod/substitute.nvim"
	"kylechui/nvim-surround"
	"nvim-lua/plenary.nvim"
	"nvim-telescope/telescope.nvim"
	"nvim-tree/nvim-web-devicons"
	"nvimdev/dashboard-nvim"
	"s417-lama/carbonpaper.vim"
	"sidebar-nvim/sidebar.nvim"
	"stevearc/oil.nvim"
	"utilyre/sentiment.nvim"
	"vim-jp/nvimdoc-ja"
	"vim-jp/vimdoc-ja"
	"niuiic/core.nvim"
	"niuiic/track.nvim"
	"hadronized/hop.nvim"
	"koron/codic-vim"
	"zbirenbaum/copilot.lua"
	"CopilotC-Nvim/CopilotChat.nvim"
	"ThePrimeagen/refactoring.nvim"
	"beauwilliams/statusline.lua"
	"zootedb0t/citruszest.nvim"
)

readonly plugdir="plugins/"

readonly ghURL="https://github.com/"

readonly rootdir=$(pwd)

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
			git clone "$ghURL$plugname"
		fi
	fi
done

cd "$rootdir" || exit
