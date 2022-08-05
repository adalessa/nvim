local artisan_config = require("alpha.laravel.artisan_config")
local make_command_directory_map = require("alpha.laravel.make_command_directory_map")

local M = {}
M.make_command = function(command)
	-- change prompt from "name" to args
	-- parse args from help
	-- parse options from help
	-- can parse as json
	-- how to present the information
	vim.ui.input({ prompt = "Name: " }, function(name)
		vim.fn.jobstart({ artisan_config.artisan_cmd, "artisan", command, name }, {
			on_exit = function()
				local directory = make_command_directory_map[vim.split(command, ":")[2]]
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

M.output_command = function(command)
    vim.cmd('vertical new')
    local new_window = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_width(new_window, 125)
    local new_buffer = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(new_window, new_buffer)
    local channel_id = vim.api.nvim_open_term(new_buffer, {})

    local function handle_output(_, data)
        vim.fn.chansend(channel_id, data)
    end

	vim.fn.jobstart({ artisan_config.artisan_cmd, "artisan", command}, {
        stdeout_buffered = true,
        on_stdout = handle_output,
        on_exit = function ()
            vim.fn.chanclose(channel_id)
            vim.cmd("startinsert")
        end,
        pty = true,
        width = 120,
	})
end

M.output_command("route:list")

return M
