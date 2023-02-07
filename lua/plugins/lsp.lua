return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "jose-elias-alvarez/null-ls.nvim",
      dependencies = {
        "adalessa/php-code-actions.nvim",
      },
    },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    {
      "j-hui/fidget.nvim",
      opts = {
        window = {
          blend = 0,
        },
        sources = {
          ["null-ls"] = {
            ignore = true,
          },
        },
      },
    },
  },
  event = "VeryLazy",
  config = function()
    require "alpha.lsp"
  end,
}
