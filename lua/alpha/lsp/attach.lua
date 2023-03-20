local telescope_mapper = require "alpha.telescope.mappings"

local filetype_attach = setmetatable({}, {
  __index = function()
    return function() end
  end,
})
return function(client, bufnr)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  -- keymaps for lsp
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { buffer = 0 })
  vim.keymap.set("i", "<c-h>", vim.lsp.buf.signature_help, { buffer = 0 })
  vim.keymap.set("n", "<leader>vo", ":LspRestart<cr>", { noremap = true })
  vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, {})
  vim.keymap.set("n", "<leader>vf", function()
    return vim.lsp.buf.format {
      async = true,
      filter = function(cli)
        return cli.name ~= "lua_ls"
      end,
    }
  end, {})

  telescope_mapper("gr", "lsp_references", nil, true)
  telescope_mapper("<leader>pv", "find_symbol", nil, true)
  telescope_mapper("<leader>pd", "lsp_document_symbols", nil, true)
  telescope_mapper("<c-]>", "lsp_definitions", nil, true)

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client, bufnr)
end
