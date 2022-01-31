" nmap ]h <Plug>(GitGutterNextHunk)
" nmap [h <Plug>(GitGutterPrevHunk)

" nmap ghs <Plug>(GitGutterStageHunk)
" nmap ghu <Plug>(GitGutterUndoHunk)

" nmap <Leader>gs :G<CR>
nmap <Leader>gdh :diffget //2<CR>
nmap <Leader>gdl :diffget //3<CR>

nnoremap <leader>ga :Git fetch --all -p<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gpp :Git push<CR>
nnoremap <leader>gpo :Git push -u origin HEAD<CR>
