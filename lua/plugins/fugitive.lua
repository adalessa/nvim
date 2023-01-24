return {
    "tpope/vim-fugitive",
    enabled = false,
    keys = {
        { "<leader>ga", ":Git fetch --all -p<cr>" },
        { "<leader>gl", ":Git pull<cr>" },
        { "<leader>gdh", ":diffget //2<cr>" },
        { "<leader>gdl", ":diffget //3<cr>" },
    },
    cmd = { "G", "Git" },
}
