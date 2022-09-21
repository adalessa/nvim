local M = {}

local function get_composer_file()
    if vim.fn.findfile("composer.json") ~= "" then
        return vim.fn.json_decode(vim.fn.readfile(vim.fn.getcwd() .. "/composer.json"))
    end

    if vim.fn.findfile("master/composer.json") ~= "" then
        return vim.fn.json_decode(vim.fn.readfile(vim.fn.getcwd() .. "/master/composer.json"))
    end

    return nil
end

M.query = function (path)
    local target = get_composer_file()

    if target == nil then
        return nil
    end

    for _, part in ipairs(path) do
        target = target[part]
        if target == nil then
            return nil
        end
    end

    return target
end

return M
