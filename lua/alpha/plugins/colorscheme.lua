return {
    "folke/tokyonight.nvim",
    config = function()
        require("tokyonight").setup({
            style = "night"
        })
        vim.cmd.colorscheme("tokyonight")
    end
}
