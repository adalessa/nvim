return {
    "numToStr/Comment.nvim",
    keys = { { "gcc" }, { "gbc" }, { "gc", mode = "v" }, { "gb", mode = "v" } },
    config = function()
        require("Comment").setup()
    end,
}
