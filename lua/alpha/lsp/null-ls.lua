local null_ls = require "null-ls"
-- local php_actions = require "php-code-actions"
-- local laravel_actions = require("laravel.code-actions")

null_ls.setup {
  sources = {
    -- null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.formatting.alejandra,
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.formatting.stylua,

    null_ls.builtins.diagnostics.yamllint,

    -- php_actions.getter_setter,
    -- php_actions.file_creator,

    -- null_ls.builtins.diagnostics.phpstan.with {
    --   to_temp_file = false,
    --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    --   -- command = "./bin/phpstan",
    --   -- condition = function ()
    --   --   return vim.fn.findfile("bin/phpstan") ~= ""
    --   -- end
    -- },
    null_ls.builtins.diagnostics.phpcs.with {
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      condition = function(utils)
        return utils.root_has_file "phpcs.xml"
      end,
    },
    null_ls.builtins.formatting.pint,
  },
}

vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, {desc = "LSP (null ls) Code actions"})
vim.keymap.set("n", "<leader>vf", function()
  return vim.lsp.buf.format { async = true }
end, {desc = "LSP (null ls) Format file"})

-- function to toogle and possible restart it
vim.api.nvim_create_user_command("NullLsToggle", function()
  local sources = vim.tbl_map(function(el)
    return el.name
  end, null_ls.get_sources())
  vim.ui.select(sources, {}, function(selected)
    if not selected then
      return
    end
    null_ls.toggle(selected)
  end)
end, {})
