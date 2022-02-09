local function on_attach()
    -- keymaps for lsp
    vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<cr>', {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>vd', ':lua vim.lsp.buf.definition()<cr>', {noremap = true})


    vim.api.nvim_set_keymap('n', '<leader>vo', ':LspRestart<cr>', {noremap = true})

    -- diagnostics to move between info and errors
    vim.api.nvim_set_keymap('n', '<leader>vn', ':lua vim.lsp.diagnostic.goto_next()<cr>', {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>vp', ':lua vim.lsp.diagnostic.goto_prev()<cr>', {noremap = true})


    vim.api.nvim_set_keymap('n', '<leader>vca', ':lua vim.lsp.buf.code_action()<cr>', {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>vf', ':lua vim.lsp.buf.formatting()<cr>', {noremap = true})

    vim.api.nvim_set_keymap('n', '<leader>vi', ':lua vim.lsp.buf.implementation()<cr>', {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>vrn', ':lua vim.lsp.buf.rename()<cr>', {noremap = true})

    require "lsp_signature".on_attach()

    vim.cmd [[au Filetype php setl omnifunc=v:lua.vim.lsp.omnifunc]]
    vim.cmd [[autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc]]

    vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }

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
