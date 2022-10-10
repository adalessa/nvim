vim.g.mapleader = " "
vim.g.snippets = "luasnip"

local options = vim.o

options.number = true
options.relativenumber = true

options.hidden = true
options.expandtab = true
options.tabstop = 4
options.softtabstop = 4
options.shiftwidth = 4
options.smartindent = true
options.errorbells = false
options.wrap = false
options.swapfile = false
options.undofile = true
options.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
options.hlsearch = false
options.incsearch = true
options.ignorecase = true
options.smartcase = true
options.termguicolors = true
options.scrolloff = 4
options.sidescrolloff = 4
options.showmode = false
options.clipboard = "unnamedplus"
-- set completeopt=menuone,noinsert,noselect
options.splitbelow = true
options.splitright = true
options.autowrite = true
options.list = true
options.listchars = "tab:\\ ,trail:-"
options.laststatus = 3
options.cmdheight = 1
options.updatetime = 50
options.signcolumn = "yes"

vim.g.neovide_transparency = 0.9
options.guifont="JetbrainsMono Nerd Font:h14"
vim.g.neovide_hide_mouse_when_typing = true
