local phpactor = {}

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

return {
    phpactor = phpactor,
}
