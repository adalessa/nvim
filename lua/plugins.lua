vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    }
end)
