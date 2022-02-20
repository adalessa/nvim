vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_use_nerd_fonts = 1

-- opening it in a new tab
vim.keymap.set('n', '<leader><leader>db', function ()
    vim.cmd('tabnew')
    vim.cmd("DBUI")
end, {})

-- just close the tab, but context related of the keybinding
vim.keymap.set('n', '<leader><leader>tq', ':tabclose<cr>')
