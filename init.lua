pcall(vim.cmd, "colorscheme habamax")

local opt = vim.opt
    
opt.number = true
opt.relativenumber = true
opt.foldmethod = "manual"
opt.tags="./tags;~"
opt.virtualedit = "all"
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.textwidth = 79
opt.expandtab = true
opt.lazyredraw = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.ruler = true
opt.smartindent = true
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.title = true
opt.wildmenu = true
opt.scrolloff = 10
opt.laststatus = 3
opt.statusline = "%F%m%r%h%w[TYPE=%Y][POS=%l,%c,%p%%,%P][BUF=%n]"
opt.complete = ".,w,b,u,t,kspell"
opt.path = ".,,,**"
opt.completeopt = "menuone,noinsert"

vim.keymap.set("n", "<Esc>", "<cmd>nohl<CR>")
vim.keymap.set("n", "<CR>", "<C-b>")
vim.keymap.set("n", "<Space>", "<C-f>")
vim.keymap.set("n", "<BS>", '"_X')
vim.keymap.set("n", "<Delete>", '"_x')
vim.keymap.set("n", "<S-Tab>", "<C-o>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "gw", "<Plug>(easymotion-bd-w)")
vim.keymap.set("n", "gs", "<Plug>(easymotion-s2)")
vim.keymap.set("n", "gz", "<cmd>Telescope find_files<CR>")
vim.keymap.set('n', 'gb', '<cmd>Telescope buffers<CR>')
vim.keymap.set("n", "gl", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "gh", "<cmd>Telescope help_tags<CR>")
vim.keymap.set("n", "gq", "<cmd>Telescope quickfix<CR>")
vim.keymap.set('n', "g/", "<cmd>Telescope current_buffer_fuzzy_find<CR>")
vim.keymap.set('n', "gt", "<cmd>ToggleTerm direction=float<CR>")
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'U', '<C-r>')
vim.keymap.set('n', '#', 'gt')
vim.keymap.set('n', 'S', ':%s/')
vim.keymap.set('n', "v", "<C-v>")
vim.keymap.set("n", "Q", "q")
vim.keymap.set("n", "q", "ZZ")
vim.keymap.set("n", "zz", "<cmd>wqa<CR>")
-- vim.keymap.set('v', '"+y', '<cmd>!win32yank.exe -i --crlf<CR>')
vim.keymap.set('n', '"+p', '<cmd>r!win32yank.exe -o --lf<CR>')
vim.keymap.set({ 'n', 'v' }, 'Y', '"+y')
vim.keymap.set({ "n", "v", "o" }, "L", "$l")
vim.keymap.set({ "n", "v", "o" }, "H", "^")
vim.keymap.set({ "n", "v", "o" }, "K", "5k")
vim.keymap.set({ "n", "v", "o" }, "J", "5j")

vim.keymap.set('i', "<Tab>", 'v:lua.smart_tab()', {expr = true, noremap = true})
vim.keymap.set('i', "<S-Tab>", "<C-p>")
vim.keymap.set('i', '<CR>', 'pumvisible() ? "<C-y>" : "<CR>"')

vim.keymap.set('v', 'T', '<cmd>CarbonPaper<CR>')

vim.cmd[[
cab nvimrc ~/.config/nvim/init.lua
]]

function smart_tab()
    local col = vim.fn.col('.')
    if col <= 1 then
        return "\t"
    end
    local preceding_char = vim.fn.getline('.'):sub(col-1, col-1)

    if preceding_char == "\t" or preceding_char == " " then
        return "\t"
    else
        vim.api.nvim_out_write(preceding_char)
        return "<C-n>"
    end
end

local telescope_setup, telescope = pcall(require, "telescope")
telescope.setup()
telescope.load_extension("fzf")

local autopairs_setup, autopairs = pcall(require, "nvim-autopairs")
autopairs.setup({
    check_ts = true
})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end, {silent = true})

local ext = vim.fn.expand("%"):match("%.(%w+)$")
if ext == "c" or ext == "cpp" then
    require'lspconfig'.clangd.setup{}
    require('c')
elseif ext == "py" then
    require'lspconfig'.pylsp.setup{}
    require('python')
elseif ext == "html" then
    require'lspconfig'.html.setup{
        cmd = { "vscode-html-languageserver", "--stdio" },
    }
elseif ext == "js" or ext == "ts" then
    require'lspconfig'.tsserver.setup{}
elseif ext == "rs" then
    require'lspconfig'.rust_analyzer.setup{}
elseif ext == "tex" then
    require'lspconfig'.texlab.setup{}
    require('tex')
elseif ext == "hs" then
    require'lspconfig'.hls.setup{}
elseif ext == "lua" then
    require("lua")
end

require("toggleterm").setup()
local luasnip = require("luasnip")
vim.keymap.set({"i"}, "ŝ", function() luasnip.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "ŭ", function() luasnip.jump( 1) end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<C-J>", function() luasnip.jump(-1) end, {silent = true})

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "Nontext", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", {bg = "none"})

vim.cmd([[packadd packer.nvim]])

require("packer").startup(function()
    use "wbthomason/packer.nvim"
    use "kylechui/nvim-surround"
    use "easymotion/vim-easymotion"
    use "alvan/vim-closetag"
    use "tpope/vim-repeat"
    use "nvim-lua/plenary.nvim"
    use "windwp/nvim-autopairs"
    use "kshenoy/vim-signature"
    use "mhinz/vim-startify"
    use 'neovim/nvim-lspconfig'
    use 's417-lama/carbonpaper.vim'
    use 'akinsho/toggleterm.nvim'
    use 'yutkat/history-ignore.nvim'
    use({
    	"L3MON4D3/LuaSnip",
    	tag = "v2.*", 
    	run = "make install_jsregexp"
    })
    use { 'kartikp10/noctis.nvim', requires = { 'rktjmp/lush.nvim' } }
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use { "nvim-telescope/telescope.nvim", branch = "0.1.x" }
end)

