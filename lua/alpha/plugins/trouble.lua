return {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    keys = { { "<leader>oo", "<cmd>TroubleToggle<cr>" } },
    config = function()
        require("trouble").setup()
    end
}
