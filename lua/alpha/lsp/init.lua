-- LSP configuration

-- install servers and tools
require "alpha.lsp.mason"

local lspconfig = require "lspconfig"
local servers = require "alpha.lsp.servers"


for server, setup in pairs(servers) do
    lspconfig[server].setup(setup())
end

require "alpha.lsp.null-ls"
