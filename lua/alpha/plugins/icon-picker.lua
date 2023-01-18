return {
    "ziontee113/icon-picker.nvim",
    keys = {
        { "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", mode = "n" },
        { "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", mode = "n" },
        { "<C-i>", "<cmd>IconPickerInsert<cr>", mode = "i" },
    },
    opts = { disable_legacy_commands = true }
}
