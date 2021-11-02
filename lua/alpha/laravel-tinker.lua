local M = {}


M.runCode = function ()
    local curBuff = vim.api.nvim_get_current_buf()

    local stats = vim.api.nvim_list_uis()[1]

    local width = stats.width
    local height = stats.height

    local bufh = vim.api.nvim_create_buf(false, true)
    local winId = vim.api.nvim_open_win(bufh, true, {
        relative = "editor",
        width = width * 0.75,
        height = height * 0.75,
        col = 2,
        row = 2,
        style = "minimal",
        border = "rounded",
    })

    -- get the start and end lines of selection
    local startLine = vim.api.nvim_buf_get_mark(curBuff, "<")[1] -1
    local endLine = vim.api.nvim_buf_get_mark(curBuff, ">")[1]
    -- print("range: ", startLine, endLine)

    local code = vim.api.nvim_buf_get_lines(curBuff, startLine, endLine, false);

    -- print (vim.inspect(code))

    local codeText = vim.fn.shellescape(table.concat(code, " "))
    -- print(codeText)


    local result = vim.fn.systemlist('php artisan tinker --execute=' .. codeText)

    vim.api.nvim_buf_set_text(bufh, 0, 0, 0, 0, result)
end

M.backTerminal = function ()
    local bufh = vim.api.nvim_create_buf(false, true)
    local term = vim.api.nvim_open_term(bufh, {})

    local winId = vim.api.nvim_open_win(bufh, true, {
        relative = "editor",
        width = 80,
        height = 80,
        col = 2,
        row = 2,
        style = "minimal",
        border = "rounded",
    })

    local jobId = vim.fn.jobstart("php artisan tinker", {
        on_stdout = function (err, data)
            print(err, vim.inspect(data))
            vim.api.nvim_chan_send(term, table.concat(data, "\n"))
        end
    })

    vim.api.nvim_chan_send(jobId, "$ub = UploadBatch::find(1);\n")
    vim.api.nvim_chan_send(jobId, "dump($ub);\n")
end


return M
