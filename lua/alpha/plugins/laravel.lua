return {
    "adalessa/laravel.nvim",
    dependencies = {
        "rcarriga/nvim-notify",
        "adalessa/composer.nvim",
    },
    cmd = {"Sail", "Artisan", "Composer"},
    keys = {{"<leader>pa", function ()
        require("telescope").extensions.laravel.laravel()
    end}},
    config = function()
        local laravel = require("laravel")
        local artisan = require("laravel.artisan")
        local notify = require("notify")

        laravel.setup()

        vim.keymap.set("n", "<leader>ac", function()
            artisan.clean_cmd_list_cache()
            notify.notify("Artisan cmd list cache clean", "info", { title = "Laravel.nvim" })
        end, { noremap = true })

        require("telescope").load_extension("laravel")
    end
}
