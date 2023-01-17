return {
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
    },
    config = function ()
        require("alpha.harpoon").setup()
    end
}
