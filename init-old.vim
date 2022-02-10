" Allows to have a .nvimrc per project folder
set exrc

syntax enable

let mapleader = ' '

inoremap <C-c> <esc>

nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

" forward and backward search of current word

" format json files
autocmd BufWritePre *stubs/**/*.json :%!jq

" augroup fmtphp
"   autocmd!
"   autocmd BufWritePre filetype php undojoin | lua vim.lsp.buf.formatting()
" augroup END

filetype plugin indent on
autocmd FileType yaml setl indentkeys-=<:>
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType cucumber setl indentkeys-=<:>
autocmd FileType cucumber setlocal ts=2 sts=2 sw=2 expandtab

autocmd BufWritePost */alpha/**.lua lua require('plenary.reload').reload_module('alpha')

lua require("alpha")

" quick duplication of files

let g:laravel_artisan = 'sail artisan'
let test#php#pest#executable = 'sail debug test'

let $NO_TTY = 1

" Has to be the last line for the .nvimrc per project
set secure
