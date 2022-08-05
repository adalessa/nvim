vim.api.nvim_create_user_command("Sailup", function ()
    vim.fn.jobstart(
        {"sail", "up", "-d"},
        {
            stdout_buffered = true,
            stderr_buffered = true,
            on_exit = function ()
                require("notify").notify("Sail up is done", "info", {})
            end,
            on_stdout = function (_, data)
                if data then
                    P(data)
                end
            end,
            on_stderr = function (_, data)
                if data then
                    P(data)
                end
            end,
        }
    )
end, {})
