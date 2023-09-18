local telescope_mapper = require "alpha.telescope.mappings"

local filetype_attach = setmetatable({
  php = function(_, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspPhpactorReindex", function()
      vim.lsp.buf_notify(bufnr, "phpactor/index/reindex", {})
    end, {})

    vim.api.nvim_buf_create_user_command(bufnr, 'LspPhpactorStatus', function()
      local results, _ = vim.lsp.buf_request_sync(bufnr, "phpactor/status", {["return"]=true})

      local content = ''

      for _, res in pairs(results or {}) do
        if res ~= nil and res["result"] ~= nil then
          content = content .. res["result"]
        end
      end


      local Popup = require("nui.popup")
      local event = require("nui.utils.autocmd").event

      local popup = Popup({
        enter = true,
        focusable = true,
        border = {
          style = "rounded",
        },
        position = "50%",
        size = {
          width = "80%",
          height = "60%",
        },
      })

      -- mount/open the component
      popup:mount()

      -- unmount component when cursor leaves buffer
      popup:on(event.BufLeave, function()
        popup:unmount()
      end)
      local out = {};
      for match in string.gmatch(content, "[^\n]+") do
        table.insert(out, match);
      end

      vim.api.nvim_buf_set_option(popup.bufnr, "filetype", "markdown")
      vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, out)

    end, {})
  end,
}, {
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
  telescope_mapper("gd", "lsp_definitions", { buffer = true, desc = "LSP go to definition" })

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint(bufnr, true)
  end

  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client, bufnr)
end
