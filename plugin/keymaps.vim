scriptencoding utf-8

vnoremap <leader>p "_dP

nnoremap Y y$

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap $ $<c-g>u
inoremap > ><c-g>u

vnoremap < <gv
vnoremap > >gv

vnoremap <leader>s :!sort<CR>

nnoremap <leader>wsv :vsp<CR>
nnoremap <leader>wsh :sp<CR>

nnoremap <leader>j :cnext<CR>zz
nnoremap <leader>k :cprev<CR>zz

nnoremap <leader>i :lnext<CR>
nnoremap <leader>o :lprev<CR>

nnoremap <leader>bd :bd!<CR>

nnoremap <expr> <leader><leader>dp ":saveas " .  expand('%')

" For moving quickly up and down,
" Goes to the first line above/below that isn't whitespace
" Thanks to: http://vi.stackexchange.com/a/213
nnoremap <silent> gj :let _=&lazyredraw<CR>:set lazyredraw<CR>/\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>
nnoremap <silent> gk :let _=&lazyredraw<CR>:set lazyredraw<CR>?\%<C-R>=virtcol(".")<CR>v\S<CR>:nohl<CR>:let &lazyredraw=_<CR>

" Run the last command
nnoremap <leader><leader>c :<up>


if has('nvim')
    " Make esc leave terminal mode
    tnoremap <leader><Esc> <C-\><C-n>
    tnoremap <Esc><Esc> <C-\><C-n>

    " Easy moving between the buffers
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l

    " Try and make sure to not mangle space items
    tnoremap <S-Space> <Space>
    tnoremap <C-Space> <Space>
endif

nnoremap <leader><leader>x :call alpha#save_and_exec()<cr>

nnoremap <leader>cc :cclose<CR>
