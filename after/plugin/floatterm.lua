vim.keymap.set({ "n", "t" }, "``", function()
    vim.cmd([[FloatermToggle]])
end, {})

vim.keymap.set({ "n", "t" }, "`n", function()
    vim.cmd([[FloatermNext]])
end, {})

vim.keymap.set({ "n", "t" }, "`p", function()
    vim.cmd([[FloatermPrev]])
end, {})

vim.keymap.set({ "n", "t" }, "`c", function()
    vim.cmd([[FloatermNew]])
end, {})
