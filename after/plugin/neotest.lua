local ok, neotest = pcall(require, "neotest")
if not ok then
    return
end

neotest.setup({
    adapters = {
        require("neotest-go"),
        require("neotest-rust"),
        require("neotest-plenary"),
        require("neotest-vim-test")({
            ignore_file_types = { "go", "lua", "rust", "php" },
        }),
        require("laravel.neotest"),
    },
})

local hydra = require("hydra")

local hint = [[
 NeoTest
 _n_: Near test  _f_: Current file   _s_: Toggle Summary ^
 ^ ^                                            _<Esc>_
]]

hydra({
    name = "neotest",
    hint = hint,
    mode = "n",
    config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
            border = "rounded",
            position = "bottom",
        },
    },
    body = "<C-t>",
    heads = {
        { "n", neotest.run.run },
        {
            "f",
            function()
                neotest.run.run(vim.fn.expand("%"))
            end,
        },
        { "s", neotest.summary.toggle },
        { "<Esc>", nil, { exit = true } },
    },
})
