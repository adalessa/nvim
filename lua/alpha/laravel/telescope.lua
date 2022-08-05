local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local utils = require("telescope.utils")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local putils = require("telescope.previewers.utils")
local conf = require("telescope.config").values

local artisan_config = require("alpha.laravel.artisan_config")
local laravel_actions = require("alpha.laravel.actions")
local laravel_utils = require("alpha.laravel.utils")

local M = {}

M.picker = function(opts)
    -- TODO check if cmd == sail check if sail is running
    opts = opts or {}

    local results = utils.get_os_command_output({ artisan_config.artisan_cmd, "artisan", "list", "--raw" })
    -- do I want to change from raw to json and decode it?
    -- what advantages will I get
    -- I have group by the id like "make" the command is the same

    pickers
        .new({}, {
            prompt_title = "Artisan commands",
            finder = finders.new_table({
                results = results,
                entry_maker = function(line)
                    local artisan_cmd = vim.split(line, " ")[1]
                    return {
                        value = artisan_cmd,
                        display = artisan_cmd,
                        ordinal = artisan_cmd,
                    }
                end,
            }),
            previewer = previewers.new_buffer_previewer({
                title = "Help",
                get_buffer_by_name = function(_, entry)
                    return entry.value
                end,

                define_preview = function(self, entry)
                    local cmd = { artisan_config.artisan_cmd, "artisan", entry.value, "-h" }
                    putils.job_maker(cmd, self.state.bufnr, {
                        value = entry.value,
                        bufname = self.state.bufname,
                    })
                end,
            }),
            sorter = conf.file_sorter(),
            attach_mappings = function(_, map)
                map("i", "<cr>", function(prompt_bufnr)
                    local entry = action_state.get_selected_entry()
                    -- check if entry.value is a make
                    actions.close(prompt_bufnr)
                    -- local cmd = string.format(":!%s %s ", get_artisan_command(), entry.value)
                    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), "t", true)
                    if laravel_utils.is_make_command(entry.value) then
                        laravel_actions.make_command(entry.value)
                    else
                        laravel_actions.output_command(entry.value)
                    end
                end)
                return true
            end,
        })
        :find()
end

return M
