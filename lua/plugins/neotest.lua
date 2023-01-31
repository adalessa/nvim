return {
  "nvim-neotest/neotest",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-go",
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-vim-test",
    "anuvyklack/hydra.nvim",
  },
  config = function()
    local neotest = require "neotest"
    neotest.setup {
      adapters = {
        require "neotest-go",
        require "neotest-rust",
        require "neotest-plenary",
        require "neotest-vim-test" {
          ignore_file_types = { "go", "lua", "rust", "php" },
        },
        -- require("laravel.neotest"),
      },
    }

    local hydra = require "hydra"

    local hint = [[
         NeoTest
         _n_: Near test  _f_: Current file _l_: Last Test _m_: Run Marked _s_: Toggle Summary ^
         ^ ^                                            _<Esc>_
        ]]

    hydra {
      name = "neotest",
      hint = hint,
      mode = "n",
      config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
          border = "rounded",
          position = "bottom",
        },
      },
      body = "<C-t>",
      heads = {
        { "n", neotest.run.run },
        {
          "f",
          function()
            neotest.run.run(vim.fn.expand "%")
          end,
        },
        { "l", neotest.run.run_last },
        { "m", neotest.summary.run_marked },
        { "s", neotest.summary.toggle },
        { "<Esc>", nil, { exit = true } },
      },
    }
  end,
}
