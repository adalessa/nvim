return {
  "adalessa/phpactor.nvim",
  cmd = { "PhpActor" },
  keys = {
    { "<leader>pa", ":PhpActor context_menu<cr>", desc = "PhpActor context menu" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    install = {
      bin = vim.fn.stdpath "data" .. "/mason/bin/phpactor",
    },
    lspconfig = {
      enabled = false,
    },
  },
}
