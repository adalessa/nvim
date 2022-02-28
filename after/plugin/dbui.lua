vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_force_echo_notifications = 1

vim.g.db_ui_table_helpers = {
    mysql = {
        Count = "select count(1) from {optional_schema}{table}",
        Explain = "EXPLAIN {last_query}"
    }
}

-- opening it in a new tab
vim.keymap.set('n', '<leader><leader>db', ':tab DBUI<cr>', {})

-- just close the tab, but context related of the keybinding
vim.keymap.set('n', '<leader><leader>tq', ':tabclose<cr>')
