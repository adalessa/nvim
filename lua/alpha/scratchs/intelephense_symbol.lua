local function get_intelephense_buffer()
    local clients = vim.lsp.get_active_clients({ name = "intelephense" })
    if #clients == 0 then
        return
    end

    local intelephense = clients[1]

    local attached_buffers = intelephense.attached_buffers

    for key, val in pairs(attached_buffers) do
        if val then
            return key
        end
    end

    return nil
end

vim.keymap.set({'n'}, '<leader>pc', function ()
    local buffer = get_intelephense_buffer()

    if buffer == nil then
        return
    end

    require("telescope.builtin").lsp_workspace_symbols({ bufnr = buffer, query = vim.fn.expand("<cword>") })
end)
