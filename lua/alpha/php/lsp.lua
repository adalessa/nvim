local Path = require("plenary.path")

local lsp = {}

lsp.get_intelephense_buffer = function ()
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


local get_index_buffer = function ()
    local uri = vim.uri_from_fname(vim.fn.getcwd() .. "/public/index.php")
    local buff = vim.uri_to_bufnr(uri)
    vim.fn.bufload(buff)

    return buff
end


--- @param search string: fully name to search Class::method
lsp.find = function (search)
    search = vim.split(search, "::")
    local class = search[1]
    local method = search[2]

    local buffer = lsp.get_intelephense_buffer()

    if buffer == nil then
        -- TODO I want to not require this.
        -- I can load a buffer but does not start the lsp
        P("load a php buffer to load the lsp server")
        return
    end

    vim.lsp.buf_request(buffer, "workspace/symbol", { query = class }, function(err, server_result, _, _)
        if err then
            vim.api.nvim_err_writeln("Error when finding workspace symbols: " .. err.message)
            return
        end

        local locations = vim.lsp.util.symbols_to_items(server_result or {}, buffer) or {}
        if vim.tbl_isempty(locations) then
            vim.api.nvim_err_writeln("Empty response looking for class: " .. class)
            return
        end

        local class_location = locations[1]

        vim.lsp.buf_request(
            buffer,
            "workspace/symbol",
            { query = method },
            function(method_err, method_server_result, _, _)
                if err then
                    vim.api.nvim_err_writeln("Error when finding workspace symbols: " .. method_err.message)
                    return
                end

                local method_locations = vim.lsp.util.symbols_to_items(method_server_result or {}, buffer) or {}
                if vim.tbl_isempty(method_locations) then
                    P("empty response looking for method")
                    return
                end

                local method_location = nil
                for _, value in ipairs(method_locations) do
                    if value.filename == class_location.filename then
                        method_location = value
                        break
                    end
                end

                if method_location == nil then
                    return
                end

                local command = "edit"
                local filename = method_location.filename
                local row = method_location.lnum
                local col = method_location.col - 1

                if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
                    filename = Path:new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
                    pcall(vim.cmd, string.format("%s %s", command, filename))
                end

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
