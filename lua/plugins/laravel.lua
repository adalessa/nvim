return {
  "adalessa/laravel.nvim",
  dependencies = {
    "rcarriga/nvim-notify",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
  },
  cmd = { "Sail", "Artisan", "Composer", "Npm", "Laravel", "LaravelInfo", "DockerCompose" },
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
  init = function()
    vim.g.laravel_log_level = "debug"
  end,
  config = function()
    local uid = vim.system({ "id", "-u" }, { text = true }):wait().stdout or "1000"
    local gid = vim.system({ "id", "-g" }, { text = true }):wait().stdout or "1000"

    local user_arg = string.format("%s:%s", vim.trim(uid), vim.trim(gid))

    require("laravel").setup {
      route_info = {
        position = "top",
      },
      environment = {
        environments = {
          ["ao"] = require("laravel.environment.docker_compose").setup {
            container_name = "panel-webserver",
            cmd = { "docker", "compose", "exec", "-u", user_arg, "-it", "panel-webserver" },
          },
        },
      },
    }
    require("telescope").load_extension "laravel"
  end,
}
