local actions = require('telescope.actions')
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"
local conf = require("telescope.config").values
local putils = require "telescope.previewers.utils"
local action_state = require "telescope.actions.state"
local utils = require "telescope.utils"
local laravel = {}

function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

local lookup_keys = {
    display = 1,
    ordinal = 1,
    value = 1,
}

local mt_string_entry = {
    __index = function(t, k)
        return rawget(t, rawget(lookup_keys, k))
    end,
}

local function getArtisanCommand(args)
    local artCmdStr = vim.g.laravel_artisan
    if artCmdStr == nil then
        artCmdStr = "php artisan"
    end
    if type(args) ~= "table" then
        return Split(artCmdStr .. ' ' .. args, " ")
    end
    local cmd = Split(artCmdStr, ' ')
    for _, value in ipairs(args) do
        table.insert(cmd, value)
    end

    return cmd
end

laravel.artisan = function()

    local results = utils.get_os_command_output(getArtisanCommand('--raw'))

    pickers.new({}, {
        prompt_title = "Artisan commands",
        finder = finders.new_table {
            results = results,
            entry_maker = function (line)
                return setmetatable({
                    Split(line, " ")[1],
                }, mt_string_entry)
            end
        },
        previewer = previewers.new_buffer_previewer {
            title = "Help",
            get_buffer_by_name = function(_, entry)
                return entry.value
            end,

            define_preview = function(self, entry)

                local cmd = getArtisanCommand({entry.value, '-h'})

                putils.job_maker(cmd, self.state.bufnr, {
                    value = entry.value,
                    bufname = self.state.bufname,
                })
            end,
        },
        sorter = conf.file_sorter(),
        attach_mappings = function (_, map)
            map('i', '<cr>', function(prompt_bufnr)
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":Artisan " .. entry.value .. " ", true, false, true), "t", true)
            end)
            return true
        end
    }):find()
end

return laravel
