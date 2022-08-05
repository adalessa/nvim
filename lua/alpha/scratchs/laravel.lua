local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local utils = require("telescope.utils")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local putils = require("telescope.previewers.utils")
local conf = require("telescope.config").values

if vim.fn.findfile("composer.json") == nil then
    return
end

local composer_json = vim.fn.json_decode(vim.fn.readfile(vim.fn.getcwd() .. "/composer.json"))

if composer_json["require"]["laravel/framework"] == nil then
    return
end

local artisan_command
if composer_json["require-dev"]["laravel/sail"] ~= nil then
    artisan_command = "sail"
else
    artisan_command = "php"
end

local get_artisan_command = function()
    return artisan_command
end

-- TODO review why do I have this
-- local lookup_keys = {
-- 	display = 1,
-- 	ordinal = 1,
-- 	value = 1,
-- }
-- local mt_string_entry = {
-- 	__index = function(t, k)
-- 		return rawget(t, rawget(lookup_keys, k))
-- 	end,
-- }

local function is_make_command(command)
    local command_split = vim.split(command, ":")

    return command_split[1] == "make"
end

local make_commands_map = {
    cast = "app/Casts",
    channel = "app/Broadcasting",
    command = "app/Console/Commands",
    component = "app/View/Components",
    controller = "app/Http/Controllers",
    event = "app/Events",
    exception = "app/Exceptions",
    factory = "",
    job = "app/Jobs",
    listener = "app/Listeners",
    mail = "app/Mail",
    middleware = "app/Http/Middleware",
    migration = "",
    model = "app/Models",
    notification = "app/Notifications",
    observer = "app/Observers",
    policy = "app/Policies",
    provider = "app/Providers",
    request = "app/Http/Requests",
    resource = "app/Http/Resources",
    rule = "app/Rules",
    scope = "app/Models/Scopes",
    seeder = "",
    test = "tests/Feature",
}

local function get_directory_by_command(name)
    return make_commands_map[name]
end

local function handle_make_command(command)
    -- change prompt from "name" to args
    -- parse args from help
    -- parse options from help
    -- can parse as json
    -- how to present the information
    vim.ui.input({ prompt = "Name: " }, function(name)
        vim.fn.jobstart({ get_artisan_command(), "artisan", command, name }, {
            on_exit = function()
                local directory = get_directory_by_command(vim.split(command, ":")[2])
                if directory == "" then
                    return
                end
                local filename = string.format("%s/%s.php", directory, name)
                if vim.fn.findfile(filename) then
                    local uri = vim.uri_from_fname(string.format("%s/%s", vim.fn.getcwd(), filename))
                    local buffer = vim.uri_to_bufnr(uri)
                    vim.api.nvim_win_set_buf(0, buffer)
                end
            end,
        })
    end)
end

local laravel = function(opts)
    -- TODO check if cmd == sail check if sail is running
    opts = opts or {}

    local results = utils.get_os_command_output({ get_artisan_command(), "artisan", "list", "--raw" })
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
                    local cmd = { get_artisan_command(), "artisan", entry.value, "-h" }
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
                    if is_make_command(entry.value) then
                        handle_make_command(entry.value)
                    end
                end)
                return true
            end,
        })
        :find()
end

laravel({})

-- TODO list
-- open output buffer to show result of not make commands
-- Add option to add arguments for command
-- set a key when choosing the command or config, to ask for properties as well as arguments
-- take arguments in the same input
--
-- Create Sail user command
-- Create Artisan user command

--
-- local uri = vim.uri_from_fname(vim.fn.getcwd() .. "/composer.json")
-- local buffer = vim.uri_to_bufnr(uri)
-- if not vim.api.nvim_buf_is_loaded(buffer) then
--     vim.api.nvim_buf_attach(buffer, false, {})
-- end

-- local content = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
-- local json = vim.fn.join(content)
-- local decoded_json = vim.fn.json_decode(json)
-- P(decoded_json["require-dev"]["laravel/sail"])
--

-- P(vim.fn.fnamemodify(vim.fn.findfile("composer.json"), ":p:h"))

-- local decoded_json = vim.fn.json_decode(vim.fn.readfile(vim.fn.getcwd() .. "/composer.json"))
-- P(decoded_json["require-dev"]["laravel/sail"])
-- P(decoded_json["require"]["laravel/sail"])

-- find file composer.json
-- generate base path with fnamemodify or with getcwd
-- to run the commands can use jobstart. but think this response line by line, but have on exit as well
-- I can use plenary job but not sure if makes sence

-- vim.fn.jobstart({"sail", "artisan", "make:controller", "MyController"}, {
--     stdout_buffered = true,
--     stderr_buffered = true,
--     on_exit = function ()
--         P("job ended")
--         if vim.fn.findfile("app/Http/Controllers/MyController.php") then
--             local uri = vim.uri_from_fname(vim.fn.getcwd() .. "/app/Http/Controllers/MyController.php")
--             local buffer = vim.uri_to_bufnr(uri)
--             vim.api.nvim_win_set_buf(0, buffer)
--         end
--     end,
--     -- on_stdout = function (_, data)
--     --     P("stdout")
--     --     P(data)
--     -- end,
--     -- on_stderr = function (_, data)
--     --     P("stderr")
--     --     P(data)
--     -- end,
-- })
-- local Job = require("plenary.job")
-- Job:new({
--     command = 'sail',
--     args = {'artisan', 'make:controller', 'MyController'},
--     on_exit = function (j, return_val)
--         P(return_val)
--         P(j:result())
--         P(j)
--     end
-- }):sync()
