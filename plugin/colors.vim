fun! ColorMyPencils()
    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_bold = 0
    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    let g:gruvbox_invert_selection = '0'

    set background=dark
    colorscheme gruvbox

    " Transparency
    highlight Normal ctermbg=NONE guibg=NONE
    highlight EndOfBuffer ctermbg=NONE guibg=NONE

    highlight ColorColumn ctermbg=0 guibg=grey
    " highlight Normal guibg=none
    " highlight LineNr guifg=#ff8659
    " highlight LineNr guifg=#aed75f
    highlight LineNr guifg=#5eacd3
    highlight netrwDir guifg=#5eacd3
    highlight qfFileName guifg=#aed75f
    hi TelescopeBorder guifg=#5eacd
endfun

call ColorMyPencils()

nnoremap <leader>cc :call ColorMyPencils()<CR>
