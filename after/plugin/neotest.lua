local ok, neotest = pcall(require, "neotest")
if not ok then
    return
end

local composer = require("composer")

neotest.setup({
    adapters = {
        require("neotest-go"),
        require("neotest-rust"),
        require("neotest-plenary"),
        require("neotest-vim-test")({
            ignore_file_types = { "go", "lua", "rust", "php" },
        }),
        require("neotest-phpunit")({
            phpunit_cmd = function()
                if composer.query({ "require-dev", "laravel/sail" }) ~= nil then
                    return { "vendor/bin/sail", "phpunit" }
                end
                return "vendor/bin/phpunit"
            end,
            path_mapping = function ()
                if composer.query({"require-dev", "laravel/sali"}) ~= nil then
                    return { ["/app"] = vim.fn.getcwd() }
                end
                return { ["/var/www/html"] = vim.fn.getcwd() }
            end
        }),
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
