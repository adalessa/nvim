return {
  "vim-test/vim-test",
  keys = { { "<leader>t", desc = "Open Test menu" } },
  dependencies = {
    "anuvyklack/hydra.nvim",
  },
  init = function()
    vim.g["test#strategy"] = "harpoon"
    vim.g["test#neovim#term_position"] = "vert"
    vim.g["test#harpoon_term"] = 1
    vim.g["test#preserve_screen"] = 0
    vim.g["test#harpoon#gototerminal"] = 0
    vim.g["test#php#pest#executable"] = "./vendor/bin/sail test"

    local function dockerComposeTransform(cmd)
      local uid = vim.fn.system("id -u"):gsub("%s*$", "")
      local gid = vim.fn.system("id -g"):gsub("%s*$", "")
      return string.format("docker compose exec -u %s:%s php-fpm %s", uid, gid, cmd)
    end

    vim.g["test#php#behat#executable"] = "bin/behat --colors"
    vim.g["test#custom_transformations"] = { docker = dockerComposeTransform }
  end,
  config = function()
    local behat_paths = {
      "tests/Functional/Context/**/*.php",
      "tests/Behat/Context/*.php",
      "tests/Behat/**/*.php",
      "src/Behat/**/*.php",
    }

    for _, path in ipairs(behat_paths) do
      if vim.fn.glob(path) ~= "" then
        vim.g["test#php#behat#bootstrap_directory"] = path
        vim.g["test#transformation"] = "docker"

        -- many of my projects have variables necessaries so this is required
        local env_vars = vim.fn.system "make vars"
        for _, env_var in ipairs(vim.split(env_vars, "\n")) do
          if env_var ~= "" then
            env_var = env_var:gsub("^export ", "")
            local key, value = unpack(vim.split(env_var, "="))
            vim.fn.setenv(key, value)
          end
        end
        break
      end
    end

    require "alpha.test_strategy"

    require "alpha.test_menu"
  end,
}
