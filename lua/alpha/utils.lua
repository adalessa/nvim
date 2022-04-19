local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

M.ucfirst = function(str)
    return (str:gsub("^%l", string.upper))
end

M.get_master_node = function()
    local node = ts_utils.get_node_at_cursor()
    if node == nil then
        error("No treesitter parser found.")
    end

    local start_row = node:start()

    local parent = node:parent()
    while (parent ~= nil and parent:start() == start_row) do
        node = parent
        parent = node:parent()
    end

    return node
end

M.get_root_node = function ()
    local node = ts_utils.get_node_at_cursor()
    if node == nil then
        error("No treesitter parser found.")
    end

    local parent = node:parent()
    while (parent ~= nil) do
        node = parent
        parent = node:parent()
    end

    return node
end

return M
