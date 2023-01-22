return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
        require("lualine").setup(
            {
                options = {
                    theme = vim.g.alpha_lualine_color,
                    icons_enabled = true,
                    globalstatus = true,
                },
                extensions = { "quickfix", "fugitive" },
                sections = {
                    lualine_a = { { "mode", upper = true } },
                    lualine_b = { { "branch", icon = "" }, "db_ui#statusline" },
                    lualine_c = { { "filename", file_status = true, path = 1 } },
                    lualine_x = {
                        "diagnostics", "diff",
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                            color = { fg = "ff9e64" },
                        }
                    },
                    lualine_y = { "filetype" },
                    lualine_z = { "location" },
                },
                winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
            }
        )
    end,
}
