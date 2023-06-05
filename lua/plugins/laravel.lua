return {
  "adalessa/laravel.nvim",
  dependencies = {
    "rcarriga/nvim-notify",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
  },
  cmd = { "Sail", "Artisan", "Composer", "Npm", "Laravel", "LaravelInfo" },
  keys = {
    { "<leader>la", ":Laravel artisan<cr>", desc = "Laravel Application Commands" },
    { "<leader>lr", ":Laravel routes<cr>", desc = "Laravel Application Routes" },
    {
      "<leader>lt",
      function()
        require("laravel.tinker").send_to_tinker()
      end,
      mode = "v",
      desc = "Laravel Application Routes",
    },
  },
  config = function()
    vim.g.laravel_log_level = "debug"
    require("laravel").setup({
      route_info = {
        position = "top",
      }
    })
    require("telescope").load_extension "laravel"
  end,
}
