return {
  "vim-test/vim-test",
  keys = { { "<leader>t" } },
  dependencies = {
    "anuvyklack/hydra.nvim",
  },
  config = function()
    local hydra = require "hydra"

    vim.g["test#preserve_screen"] = 1

    vim.cmd [[
    let test#php#pest#executable = './vendor/bin/sail test'
    let test#strategy = 'neovim'
    let test#neovim#term_position = 'vert'
    let g:test#preserve_screen = 1
]]

    local hint = [[
 Vim Tests
 _n_: Near test  _f_: Current file   _s_: Test Suit ^
 _l_: Test Last  _g_: Visit
 ^ ^                                          _<Esc>_ ^
]]

    hydra {
      name = "vimtest",
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
      body = "<leader>t",
      heads = {
        { "n", ":TestNearest<CR>" },
        { "f", ":TestFile<CR>" },
        { "s", ":TestSuit<CR>" },
        { "l", ":TestLast<CR>" },
        { "g", ":TestVisit<CR>" },
        { "<Esc>", nil, { exit = true } },
      },
    }
  end,
}
