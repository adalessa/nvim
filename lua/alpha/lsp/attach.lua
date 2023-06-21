local telescope_mapper = require "alpha.telescope.mappings"

local filetype_attach = setmetatable({}, {
  __index = function()
    return function() end
  end,
})
return function(client, bufnr)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  -- keymaps for lsp
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "LSP Help information of symbol under the cursor" })
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { buffer = 0, desc = "LSP Rename symbol under cursor" })
  vim.keymap.set("i", "<c-h>", vim.lsp.buf.signature_help, { buffer = 0, desc = "LSP Signature help" })
  vim.keymap.set("n", "<leader>vo", ":LspRestart<cr>", { noremap = true, desc = "LSP Restart Server" })
  vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, { buffer = 0, desc = "LSP Code actions" })
  vim.keymap.set("n", "<leader>vf", function()
    return vim.lsp.buf.format {
      async = true,
      filter = function(cli)
        return cli.name ~= "lua_ls"
      end,
    }
  end, { buffer = 0, desc = "LSP format file" })

  telescope_mapper("gr", "lsp_references", { buffer = true, desc = "LSP References of symbol on cursor" })
  telescope_mapper("<leader>pv", "find_symbol", { buffer = true, desc = "LSP find symbol on the project" })
  telescope_mapper("<leader>pd", "lsp_document_symbols", { buffer = true, desc = "LSP document symbols" })
  telescope_mapper("<c-]>", "lsp_definitions", { buffer = true, desc = "LSP go to definition" })

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  vim.lsp.buf.inlay_hint(bufnr)

  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client, bufnr)
end
