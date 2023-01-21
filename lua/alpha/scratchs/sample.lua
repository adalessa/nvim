local M = {}

local action_state = require("telescope.actions.state")
local actions = require('telescope.actions')

M.find_config = function()
    require("telescope.builtin").find_files({
        prompt_title = "< Neovim >",
        cwd = "$HOME/.config/nvim/",
    })
end

M.find_plugin = function()
    require("telescope.builtin").find_files({
        prompt_title = "< Plugins >",
        cwd = "$HOME/.config/nvim/lua/alpha/plugins/",
        attach_mappings = function(_, map)
            map("i", "<C-t>", function(prompt_bufnr)
                local new_plugin = action_state.get_current_line()
                actions.close(prompt_bufnr)
                vim.cmd(string.format("edit ~/.config/nvim/lua/alpha/plugins/%s.lua", new_plugin))
            end)

            return true
        end,
    })
end

M.find_plugin()
