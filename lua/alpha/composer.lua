local M = {}

M.query = function (path)
    if vim.fn.findfile("composer.json") == "" then
        P("did not found the file")
        return nil
    end

    local target = vim.fn.json_decode(vim.fn.readfile(vim.fn.getcwd() .. "/composer.json"))

    for _, part in ipairs(path) do
        target = target[part]
        if target == nil then
            return nil
        end
    end

    return target
end

return M
