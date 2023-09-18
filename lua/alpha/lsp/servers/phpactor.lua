local lsp_attach = require "alpha.lsp.attach"
local lsp_flags = require "alpha.lsp.flags"

return function(ops)
  return vim.tbl_extend("force", {
    on_attach = lsp_attach,
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
