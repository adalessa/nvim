vim.keymap.set({ "n", "t" }, "``", function()
    vim.cmd([[FloatermToggle]])
end, {})
