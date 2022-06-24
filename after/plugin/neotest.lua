local ok, neotest = pcall(require, "neotest")
if not ok then
    return
end

neotest.setup({
    adapters = {
        require("neotest-go"),
        require("neotest-vim-test")({
            ignore_file_types = { "go" },
        }),
    },
})

-- Not working for behat
-- So add the leader, not ideal but for now is the best
vim.keymap.set("n", "<leader>t<C-n>", function()
    neotest.run.run()
end, { silent = true, noremap = true })

vim.keymap.set("n", "<leader>t<C-f>", function()
    neotest.run.run(vim.fn.expand("%"))
end, { silent = true, noremap = true })

vim.keymap.set("n", "<leader>t<C-s>", function()
    neotest.summary.toggle()
end, { silent = true, noremap = true })
