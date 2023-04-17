return {
  "adalessa/phpactor.nvim",
  cmd = { "PhpActor" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    install = {
      bin = vim.fn.stdpath("data") .. "/mason/bin/phpactor",
    },
    lspconfig = {
      enabled = false,
    },
  },
}
