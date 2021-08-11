" Allows to have a .nvimrc per project folder
set exrc

" Install Vimplug if not installed
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ~/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

" Set plugin folder
call plug#begin('~/.config/nvim/plugged')

" LSP
Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'anott03/nvim-lspinstall'

" General use plugins
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-dadbod'
Plug 'airblade/vim-gitgutter'
Plug 'hashivim/vim-terraform'
Plug 'mattn/emmet-vim'

Plug 'nicwest/vim-http'

Plug 'vimwiki/vimwiki'

" Laravel specific
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'noahfrederick/vim-composer'
Plug 'noahfrederick/vim-laravel'
Plug 'jwalton512/vim-blade'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Golang
Plug 'fatih/vim-go'

" Testing
Plug 'vim-test/vim-test'

" Debug
Plug 'mfussenegger/nvim-dap'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

Plug 'gruvbox-community/gruvbox'

Plug 'fladson/vim-kitty'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'hoob3rt/lualine.nvim'

Plug 'sbdchd/neoformat'

Plug 'mbbill/undotree'

call plug#end()

syntax enable

let mapleader = ' '

inoremap <C-c> <esc>

nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>uu :UndotreeToggle<CR>

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

let g:gitgutter_map_keys = 0

" forward and backward search of current word
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>

vnoremap <leader>p "_dP

" remove whitespaces
autocmd BufWritePre * %s/\s\+$//e

augroup fmtphp
  autocmd!
  autocmd BufWritePre *.php undojoin | Neoformat
augroup END

" Has to be the last line for the .nvimrc per project
set secure
