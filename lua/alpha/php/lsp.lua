local Path = require("plenary.path")

local lsp = {}

---Return a buffer id for the given client
---@param server_name string
---@return integer|nil
lsp.get_lsp_buffer = function(server_name)
    local clients = vim.lsp.get_active_clients({ name = server_name })
    if #clients == 0 then
        return nil
    end

    local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)

    if #buffers == 0 then
        return nil
    end

    return buffers[1]
end

--- @param search string: fully name to search Class::method
lsp.find = function(search, client)
    search = vim.split(search, "::")
    local fqn_class = search[1]
    local method = search[2]

    local buffer = lsp.get_lsp_buffer(client)

    if buffer == nil then
        -- TODO I want to not require this.
        -- I can load a buffer but does not start the lsp
        vim.api.nvim_err_writeln(string.format("No buffer available for client %s", client))
        return
    end

    local class_parts = vim.split(fqn_class, "\\")
    local class = class_parts[#class_parts]

    -- TODO phpactor does not support FQN search need to de sepparated
    -- can query get the optiosn, match the full name and type class
    -- I don't think gives the namespace
    -- So I will get the full name, not the
    -- the option is to get the class
    -- open the buffer, change in the window
    -- call the vim.lsp.buf_document_symbol({on_list = function (list) end})
    -- grab the information and move the cursor
    -- if method does not exist show error but stay in the class
    -- Can have the code extracted to work with both implementations ?
    -- Potentially could have a way to create the classes if they don't exist
    -- With the file creater action
    vim.lsp.buf_request(buffer, "workspace/symbol", { query = class }, function(err, server_result, _, _)
        if err then
            vim.api.nvim_err_writeln("Error when finding workspace symbols: " .. err.message)
            return
        end

        local locations = vim.lsp.util.symbols_to_items(server_result or {}, buffer) or {}
        if vim.tbl_isempty(locations) then
            vim.api.nvim_err_writeln("Empty response looking for class: " .. fqn_class)
            return
        end
        local class_location = nil
        for idx, location in pairs(locations) do
            if location.text == string.format("[Class] %s", fqn_class) then
                class_location = locations[idx]
                break
            end
        end

        if class_location == nil then
            P("Did not found any class: " .. class)
            return
        end

        local command = "edit"
        local filename = class_location.filename

        if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
            filename = Path:new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
            pcall(vim.cmd, string.format("%s %s", command, filename))
        end

        local params = vim.lsp.util.make_position_params(0)
        vim.lsp.buf_request(
            0,
            "textDocument/documentSymbol",
            params,
            function(method_err, method_server_result, _, _)
                if err then
                    vim.api.nvim_err_writeln("Error when finding workspace symbols: " .. method_err.message)
                    return
                end

                local method_locations = vim.lsp.util.symbols_to_items(method_server_result or {}, buffer) or {}
                if vim.tbl_isempty(method_locations) then
                    P(string.format("empty response looking for method %s", method))
                    return
                end

                local method_location = nil
                for _, value in ipairs(method_locations) do
                    if value.text == string.format("[Method] %s", method) then
                        method_location = value
                        break
                    end
                end

                if method_location == nil then
                    return
                end

                local row = method_location.lnum
                local col = method_location.col - 1

                if row and col then
                    local ok, err_msg = pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
                    if not ok then
                        vim.api.nvim_err_writeln("error seting row and col: " .. err_msg)
                    end
                    vim.cmd("normal zt")
                end
            end
        )
    end)
end

return lsp
