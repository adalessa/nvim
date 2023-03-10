return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  cmd = { "Neogen" },
  keys = {{"<leader>n", ":Neogen<cr>"}},
  opts = { snippet_engine = "luasnip" },
}
