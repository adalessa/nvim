return {
  "ziontee113/icon-picker.nvim",
  keys = {
    { "<Leader><Leader>i", "<cmd>IconPickerNormal nerd_font<cr>", mode = "n", desc = "IconPicker NerdFont Insert" },
    { "<Leader><Leader>y", "<cmd>IconPickerYank nerd_font<cr>", mode = "n", desc = "IconPicker NerdFont Yank" },
    { "<C-o>", "<cmd>IconPickerInsert nerd_font<cr>", mode = "i", desc = "IconPicker NerdFont Insert mode" },
  },
  opts = { disable_legacy_commands = true },
}
