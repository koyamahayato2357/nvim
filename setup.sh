./syncplug.nu
cd plugins/blink.cmp
cargo build --release
nvim -c "lua Load_Plugin 'nvim-treesitter'" -c "lua require 'nvim-treesitter'" -c "TSInstall all"
sudo cp -r plugins/nvim-treesitter/parser /usr/local/lib/nvim
sudo cp -r plugins/nvim-treesitter/queries /usr/local/share/nvim/runtime
