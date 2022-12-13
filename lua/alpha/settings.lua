vim.g.mapleader = " "
vim.g.snippets = "luasnip"

vim.g.alpha_color = "tokyonight"
vim.g.alpha_lualine_color = "tokyonight"

local options = vim.o

options.mouse = false
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
