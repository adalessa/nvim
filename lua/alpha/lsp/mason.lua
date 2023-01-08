local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()

mason_lspconfig.setup({
	ensure_installed = require('alpha.lsp.servers'),
})

require('mason-tool-installer').setup({
	ensure_installed = require('alpha.lsp.tools'),
})
