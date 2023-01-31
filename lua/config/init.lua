require "config.options"
-- autocmds and keymaps can wait to load
vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
  pattern = "VeryLazy",
  callback = function()
    require "config.autocmds"
    require "config.keymaps"
    require "config.diagnostic"
  end,
})
require "config.lazy"
