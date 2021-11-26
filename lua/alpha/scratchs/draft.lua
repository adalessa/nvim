local api = vim.api

function GlobalFunction()
    local position_params = vim.lsp.util.make_position_params()
    P(position_params)

    vim.lsp.buf_request(0, "textDocument/completion", position_params, function(err, result)
        if vim.tbl_isempty(result or {}) then return end

        local textEdit = result.items[1].additionalTextEdits;

        local bufnr = vim.api.nvim_get_current_buf()
        vim.lsp.util.apply_text_edits(textEdit, bufnr)
    end)
end
