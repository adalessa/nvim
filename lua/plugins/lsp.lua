return {
    "neovim/nvim-lspconfig",
    dependencies = {
		"hrsh7th/cmp-nvim-lsp-signature-help",
        {
            "jose-elias-alvarez/null-ls.nvim",
            dependencies = {
                "adalessa/php-code-actions.nvim",
            }
        },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "j-hui/fidget.nvim",
            opts = {
                sources = {
                    ["null-ls"] = {
                        ignore = true
                    }
                }
            },
        },
    },
    event = "VeryLazy",
    config = function ()
        require("alpha.lsp")
    end
}
