return {
  "mrjones2014/smart-splits.nvim",
  config = true,
  keys = {
    {
      "<A-h>",
      function()
        require("smart-splits").resize_left()
      end,
    },
    {
      "<A-j>",
      function()
        require("smart-splits").resize_down()
      end,
    },
    {
      "<A-k>",
      function()
        require("smart-splits").resize_up()
      end,
    },
    {
      "<A-l>",
      function()
        require("smart-splits").resize_right()
      end,
    },
  },
}
