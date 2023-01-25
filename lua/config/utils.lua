local M = {}

M.use_local = function (name)
    return vim.fn.isdirectory(vim.fn.expand("~/code/plugins/").. name) == 1
end

return M
