return {
  "mrjones2014/smart-splits.nvim",
  config = true,
  keys = {
    {
      "<A-h>",
      function()
        require("smart-splits").resize_left()
      end,
      desc = "Resize window left +10",
    },
    {
      "<A-j>",
      function()
        require("smart-splits").resize_down()
      end,
      desc = "Resize window down +10",
    },
    {
      "<A-k>",
      function()
        require("smart-splits").resize_up()
      end,
      desc = "Resize window up +10",
    },
    {
      "<A-l>",
      function()
        require("smart-splits").resize_right()
      end,
      desc = "Resize window right +10",
    },
  },
}
