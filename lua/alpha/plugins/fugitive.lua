return {
    "tpope/vim-fugitive",
    keys = {
        {"<leader>ga", ":Git fetch --all -p<cr>"},
        {"<leader>gl", ":Git pull<cr>"},
    },
    cmd = { "G", "Git" },
    config = function ()
        vim.keymap.set("n", "<leader>gdh", ":diffget //2<cr>", nil)
        vim.keymap.set("n", "<leader>gdl", ":diffget //3<cr>", nil)
    end
}
