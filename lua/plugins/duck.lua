return {
  "tamton-aquib/duck.nvim",
  keys = {
    {
      "<leader>hh",
      function()
        require("duck").hatch("🦖", 10)
      end,
      { desc = "Spawn dinasours" },
    },
  },
}
