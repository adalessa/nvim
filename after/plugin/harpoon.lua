local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end

harpoon.setup {}

vim.keymap.set('n', '<leader>ss', require("harpoon.ui").toggle_quick_menu, {noremap = true, silent = true, expr = false})
vim.keymap.set('n', '<leader>sa', require("harpoon.mark").add_file, {noremap = true, silent = true, expr = false})

for i = 1, 5 do
    vim.keymap.set(
        'n',
        string.format("<leader>%s", i),
        function ()
            require("harpoon.ui").nav_file(i)
        end,
        {noremap = true, silent = true, expr = false}
    )
end
