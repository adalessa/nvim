vim.api.nvim_set_keymap("n", "<Leader>ss", [[ <Cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>]], {noremap = true, silent = true, expr = false})

vim.api.nvim_set_keymap("n", "<Leader>sa", [[ <Cmd>lua require("harpoon.mark").add_file()<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>su", [[ <Cmd>lua require("harpoon.ui").nav_file(1)<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>si", [[ <Cmd>lua require("harpoon.ui").nav_file(2)<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>so", [[ <Cmd>lua require("harpoon.ui").nav_file(3)<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>sp", [[ <Cmd>lua require("harpoon.ui").nav_file(4)<CR>]], {noremap = true, silent = true, expr = false})
