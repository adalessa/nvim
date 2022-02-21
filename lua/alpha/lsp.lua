local telescope_mapper = require "alpha.telescope.mappings"

local filetype_attach = setmetatable({
  go = function(_)
    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end,
}, {
  __index = function()
    return function() end
  end,
})

local function on_attach(client)
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    -- keymaps for lsp
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set("n", "<leader>vf", vim.lsp.buf.formatting, { buffer = 0 })
    vim.keymap.set("n", "<leader>vn", vim.lsp.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set("n", "<leader>vp", vim.lsp.diagnostic.goto_prev, { buffer = 0 })

    telescope_mapper("gr", "lsp_references", nil, true)
    telescope_mapper("<leader>pv", "find_symbol", nil, true)

    vim.api.nvim_set_keymap('n', '<leader>vo', ':LspRestart<cr>', {noremap = true})

    require "lsp_signature".on_attach()

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
    -- Attach any filetype specific options to the client
    filetype_attach[filetype](client)
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

require "lspconfig".efm.setup {
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            blade = {
                {formatCommand = "blade-formatter --stdin", formatStdin = true}
            },
            json = {}
        }
    }
}
