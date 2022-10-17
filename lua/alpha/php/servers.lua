local phpactor = {}

-- TODO possible improvement look how it works underline
-- use the client directly to call, no need for the buffer
-- to find a class.
-- vim.lsp.start() should return the client

function phpactor.findclass(buffer, fqn, callback)
    local class_parts = vim.split(fqn, "\\")
    local class = class_parts[#class_parts]

    vim.lsp.buf_request(buffer, "workspace/symbol", { query = class }, function(err, server_result, _, _)
        if err then
            callback(
                nil,
                "Error when finding workspace symbols: " .. err.message
            )

            return
        end

        local locations = vim.lsp.util.symbols_to_items(server_result or {}, buffer) or {}
        if vim.tbl_isempty(locations) then
            vim.api.nvim_err_writeln("Empty response looking for class: " .. fqn)
            return
        end

    end)
end

-- getting the config I can re use the client
-- the next thing is to make the request with the client
local config = require("lspconfig").phpactor
config.root_dir = vim.fn.getcwd()
local client_id = vim.lsp.start(
    config
);

local client = vim.lsp.get_client_by_id(client_id)
P(client)
-- use client.request or request_sync
-- look for the direct of the symbol
return {
    phpactor = phpactor,
}
