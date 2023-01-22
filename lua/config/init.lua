require("config.options")
require("config.lazy")
if vim.fn.argc() == 0 then
    -- autocmds and keymaps can wait to load
    vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
        pattern = "VeryLazy",
        callback = function()
            require("config.autocmds")
            require("config.keymaps")
            require("config.diagnostic")
        end,
    })
end
