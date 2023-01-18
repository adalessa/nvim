return {
    "jwalton512/vim-blade",
    { "junegunn/fzf.vim" },
    {
        "junegunn/fzf",
        build = function()
            vim.fn["fzf#install"]()
        end,
    },
    {
        "windwp/nvim-projectconfig",
        config = function()
            require("nvim-projectconfig").setup()
        end,
    },
    "Raimondi/delimitMate",
    "lukas-reineke/indent-blankline.nvim",
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "tpope/vim-rhubarb",
    "tpope/vim-dotenv",
    "tpope/vim-eunuch",
}
