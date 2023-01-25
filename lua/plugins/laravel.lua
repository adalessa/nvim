return {
    "adalessa/laravel.nvim",
    dependencies = {
        "rcarriga/nvim-notify",
        "nvim-telescope/telescope.nvim",
    },
    cmd = {"Sail", "Artisan", "Composer"},
    keys = {
        {"<leader>pa", ":Artisan<cr>"},
    },
    dev = require('config.utils').use_local("laravel.nvim"),
    config = function()
        require("laravel").setup()
        require("telescope").load_extension("laravel")
    end
}
