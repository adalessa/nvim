local lsp_attach = require "alpha.lsp.attach"
local lsp_flags = require "alpha.lsp.flags"

local function phpactor_attach(_, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, "LspPhpactorReindex", function()
    vim.lsp.buf_notify(bufnr, "phpactor/index/reindex", {})
  end, {})

  vim.api.nvim_buf_create_user_command(bufnr, "LspPhpactorStatus", function()
    local results, _ = vim.lsp.buf_request_sync(bufnr, "phpactor/status", { ["return"] = true })

    local content = ""

    for _, res in pairs(results or {}) do
      if res ~= nil and res["result"] ~= nil then
        content = content .. res["result"]
      end
    end

    local Popup = require "nui.popup"
    local event = require("nui.utils.autocmd").event

    local popup = Popup {
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
    }

    -- mount/open the component
    popup:mount()

    -- unmount component when cursor leaves buffer
    popup:on(event.BufLeave, function()
      popup:unmount()
    end)
    local out = {}
    for match in string.gmatch(content, "[^\n]+") do
      table.insert(out, match)
    end

    vim.api.nvim_buf_set_option(popup.bufnr, "filetype", "markdown")
    vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, out)
  end, {})
end

return function(ops)
  return vim.tbl_extend("force", {
    on_attach = function(client, bufnr)
      lsp_attach(client, bufnr)
      phpactor_attach(client, bufnr)
    end,
    flags = lsp_flags,
    filetypes = { "php", "blade" },
    init_options = {
      ["language_server_worse_reflection.inlay_hints.enable"] = true,
      ["language_server_worse_reflection.inlay_hints.params"] = true,
      -- ["language_server_worse_reflection.inlay_hints.types"] = true,
      ["language_server_configuration.auto_config"] = false,
      ["code_transform.import_globals"] = true,
      ["language_server_phpstan.enabled"] = true,
      ["language_server_phpstan.level"] = 7,
      ["language_server_phpstan.bin"] = "phpstan",
    },
    handlers = {
      ["textDocument/inlayHint"] = function(err, result, ...)
        for _, res in ipairs(result) do
          res.label = res.label .. ": "
        end
        vim.lsp.handlers["textDocument/inlayHint"](err, result, ...)
      end,
    },
  }, ops)
end
