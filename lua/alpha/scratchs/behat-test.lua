-- TODO
-- vim.cmd("vsplit")
-- winh = vim.api.nvim_get_current_win()
-- bufh = vim.api.nvim_create_buf(true, true)
-- vim.api.nvim_win_set_buf(winh, bufh)
-- vim.api.nvim_set_current_win(winh)
--
-- should get current window, switch for the buffer and get back to the buffer, that is just for the initial not all the time for every save
--


local attach_to_buffer = function (output_bufnr, command)
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("behat-auto-test", {clear = true}),
        pattern = {"*.php", "*.feature"},
        callback = function ()
            local append_data = function (_, data)
                if data then

                    vim.api.nvim_buf_set_option(output_bufnr, "modifiable", true)
                    vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
                    vim.api.nvim_buf_set_option(output_bufnr, "modifiable", false)
                end
            end

            vim.api.nvim_buf_set_option(output_bufnr, "modifiable", true)
            vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, {"Behat test output"})
            vim.api.nvim_buf_set_option(output_bufnr, "modifiable", false)
            vim.fn.jobstart(command, {
                stdout_buffered = true,
                on_stdout = append_data,
                on_stderr = append_data,
            })
        end,
    })
end

vim.api.nvim_create_user_command("Behat", function()
    local fname = vim.fn.expand("%")
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local command = vim.split(string.format("docker-compose exec -T -u 1000:1000 php-fpm bin/behat %s:%d", fname, line), " ")
    -- TODO generate dinamically
    -- local output_bufnr = 214

    local current_win = vim.api.nvim_get_current_win()
    vim.cmd("vsplit")
    winh = vim.api.nvim_get_current_win()
    bufh = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(winh, bufh)
    vim.api.nvim_set_current_win(current_win)
    vim.api.nvim_buf_set_name(bufh, string.format("Behat %s:%s", fname, line))
    vim.api.nvim_buf_set_option(bufh, "modifiable", false)
    vim.api.nvim_win_set_option(winh, "number", false)
    vim.api.nvim_win_set_option(winh, "relativenumber", false)

    attach_to_buffer(bufh, command)
end, {})

vim.api.nvim_create_user_command("BehatFile", function()
    local fname = vim.fn.expand("%")
    local command = vim.split(string.format("docker-compose exec -T -u 1000:1000 php-fpm bin/behat %s", fname), " ")
    -- TODO generate dinamically
    -- local output_bufnr = 214

    local current_win = vim.api.nvim_get_current_win()
    vim.cmd("vsplit")
    winh = vim.api.nvim_get_current_win()
    bufh = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(winh, bufh)
    vim.api.nvim_set_current_win(current_win)
    vim.api.nvim_buf_set_name(bufh, string.format("Behat Test"))
    vim.api.nvim_buf_set_option(bufh, "modifiable", false)
    vim.api.nvim_win_set_option(winh, "number", false)
    vim.api.nvim_win_set_option(winh, "relativenumber", false)

    attach_to_buffer(bufh, command)
end, {})

vim.api.nvim_create_user_command("BehatStop", function()
    vim.api.nvim_del_augroup_by_name("behat-auto-test")
end, {})
