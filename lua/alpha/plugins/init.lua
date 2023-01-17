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
    {
        "ThePrimeagen/git-worktree.nvim",
        config = function()
            require("git-worktree").setup({})
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
    },
    "vim-test/vim-test",
    "rcarriga/nvim-notify",

    "Raimondi/delimitMate",
    "lukas-reineke/indent-blankline.nvim",

    "tpope/vim-surround",
    "tpope/vim-repeat",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "tpope/vim-dotenv",
    "tpope/vim-eunuch",
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "phaazon/mind.nvim",
        branch = "v2.2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    { "adalessa/laravel.nvim", dev = false },

    "adalessa/composer.nvim",
    "adalessa/php-code-actions.nvim",
}
