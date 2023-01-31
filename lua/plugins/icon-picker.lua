return {
  "ziontee113/icon-picker.nvim",
  keys = {
    { "<Leader><Leader>i", "<cmd>IconPickerNormal nerd_font<cr>", mode = "n" },
    { "<Leader><Leader>y", "<cmd>IconPickerYank nerd_font<cr>", mode = "n" },
    { "<C-o>", "<cmd>IconPickerInsert nerd_font<cr>", mode = "i" },
  },
  opts = { disable_legacy_commands = true },
}
