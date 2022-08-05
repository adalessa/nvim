local M = {}
M.is_make_command = function (command)
    local command_split = vim.split(command, ":")

    return command_split[1] == "make"
end

return M
