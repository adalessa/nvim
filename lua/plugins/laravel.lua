return {
  "adalessa/laravel.nvim",
  dependencies = {
    "rcarriga/nvim-notify",
    "nvim-telescope/telescope.nvim",
  },
  cmd = { "Sail", "Artisan", "Composer", "Npm", "Laravel" },
  keys = {
    { "<leader>la", ":Laravel artisan<cr>", desc = "Laravel Application Commands" },
    { "<leader>lr", ":Laravel routes<cr>", desc = "Laravel Application Routes" },
    {
      "<leader>lt",
      function()
        require("laravel").app.sendToTinker()
      end,
      mode = "v",
      desc = "Laravel Application Routes",
    },
  },
  config = function()
    vim.g.laravel_log_level = "debug"
    require("laravel").setup()
    require("telescope").load_extension "laravel"
  end,
}
