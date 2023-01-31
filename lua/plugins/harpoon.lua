return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
  },
  keys = require("alpha.harpoon").keymaps,
  config = function()
    require("alpha.harpoon").setup()
  end,
}
