return {
  "adalessa/laravel.nvim",
  dependencies = {
    "rcarriga/nvim-notify",
    "nvim-telescope/telescope.nvim",
  },
  cmd = { "Sail", "Artisan", "Composer", "Npm" },
  keys = {
    { "<leader>la", ":Artisan<cr>" },
    { "<leader>lr", ":Routes<cr>" },
  },
  event = { "VeryLazy" },
  config = function()
    vim.g.laravel_log_level = "debug"
    require("laravel").setup()
    require("telescope").load_extension "laravel"
  end,
}
