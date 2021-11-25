function GlobalFunction()
    local position_params = vim.lsp.util.make_position_params()

    vim.lsp.buf_request(0, "textDocument/completion", position_params, function(err, method, result)
        if method ~= nil then
            vim.lsp.util.apply_text_document_edit(method.items, 1)
        end
    end)
end
