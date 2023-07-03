-- LSP configuration

local lspconfig = require "lspconfig"
local servers = require "alpha.lsp.servers"

for server, setup in pairs(servers) do
    lspconfig[server].setup(setup())
end

-- install servers and tools
require "alpha.lsp.mason"
require "alpha.lsp.null-ls"
