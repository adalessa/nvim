return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  cmd = { "Neogen" },
  keys = { { "<leader>n", ":Neogen<cr>", desc = "Add comment to the near possible object" } },
  opts = { snippet_engine = "luasnip" },
}
