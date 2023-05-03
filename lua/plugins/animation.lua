return {
  "anuvyklack/animation.nvim",
  dependencies = {
    "anuvyklack/middleclass",
  },
  keys = {
    {"<leader>aa", function ()
      require("alpha.animations").redraw_buffer()
    end}
  },
}
