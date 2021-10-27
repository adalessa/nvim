" let g:compe = {}
" let g:compe.enabled = v:true
" let g:compe.autocomplete = v:true
" let g:compe.debug = v:false
" let g:compe.min_length = 1
" let g:compe.preselect = 'enable'
" let g:compe.throttle_time = 80
" let g:compe.source_timeout = 200
" let g:compe.incomplete_delay = 400
" let g:compe.max_abbr_width = 100
" let g:compe.max_kind_width = 100
" let g:compe.max_menu_width = 100
" let g:compe.documentation = v:true

" let g:compe.source = {}
" let g:compe.source.path = v:true
" let g:compe.source.buffer = v:true
" let g:compe.source.calc = v:true
" let g:compe.source.nvim_lsp = v:true
" let g:compe.source.nvim_lua = v:true
" let g:compe.source.vsnip = v:false
" let g:compe.source.luasnip = v:true

" inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

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
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end
    opts.on_attach = on_attach

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- local function setup_servers()
--     require'lspinstall'.setup()
--     local servers = require'lspinstall'.installed_servers()
--     for _, server in pairs(servers) do
--         if server == 'lua' then
--             require'lspconfig'.lua.setup {
--                 on_attach=on_attach,
--                 settings = {
--                     Lua = {
--                         diagnostics = {
--                             globals = { 'vim' }
--                         }
--                     }
--                 },
--             }
--         else
--             require'lspconfig'[server].setup{ on_attach=on_attach }
--         end
--     end
-- end

-- setup_servers()

-- require'lspinstall'.post_install_hook = function ()
--     setup_servers()
--     vim.cmd("bufdo e")
-- end

EOF
