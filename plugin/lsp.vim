fun! LspLocationList()
    lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
endfun

augroup alpha_lsp
    autocmd!
    autocmd! BufWrite,BufEnter,InsertLeave * :call LspLocationList()
augroup END

nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>

" to test
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vf :lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>

nnoremap <leader>vo :LspRestart<CR>


au Filetype php setl omnifunc=v:lua.vim.lsp.omnifunc
autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

lua << EOF

local function on_attach()
    vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<cr>', {noremap = true})
end

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    if server.name == "emmet_ls" then
        opts.filetypes = {"html", "css", "blade"}
    end
    opts.on_attach = on_attach

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)
