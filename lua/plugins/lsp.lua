return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "jose-elias-alvarez/null-ls.nvim",
      dependencies = {
        "adalessa/php-code-actions.nvim",
      },
    },
    {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          border = "rounded",
        },
      },
    },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    {
      "j-hui/fidget.nvim",
      enabled = false,
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
