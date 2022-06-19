local dap, dapui, dap_install = require("dap"), require("dapui"), require("dap-install")
local api = vim.api

dapui.setup({
  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 80,
      position = 'right',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
})

require("dap-go").setup()

vim.fn.sign_define("DapBreakpoint", { text = "ß", texthl = "", linehl = "", numhl = "" })

dap_install.config("php", {
	configurations = {
		{
			type = "php",
			request = "launch",
			name = "Listen for Xdebug",
			port = 9003,
			pathMappings = function()
				local sail = vim.call("composer#query", "require-dev.laravel/sail")
				if sail == "" then
					return { ["/app"] = vim.fn.getcwd() }
				end
				return { ["/var/www/html"] = vim.fn.getcwd() }
			end,
		},
	},
})

-- Events Listeners
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

local function with_win(win, fn, ...)
	local cur_win = api.nvim_get_current_win()
	api.nvim_set_current_win(win)
	local ok, err = pcall(fn, ...)
	api.nvim_set_current_win(cur_win)
	assert(ok, err)
end

local function jump_to_location(bufnr, line, column)
	-- vscode-go sends columns with 0
	-- That would cause a "Column value outside range" error calling nvim_win_set_cursor
	-- nvim-dap says "columnsStartAt1 = true" on initialize :/
	if column == 0 then
		column = 1
	end
	for _, tab in pairs(api.nvim_list_tabpages()) do
		for _, win in pairs(api.nvim_tabpage_list_wins(tab)) do
			if api.nvim_win_get_buf(win) == bufnr then
				api.nvim_win_set_cursor(win, { line, column - 1 })
				api.nvim_set_current_tabpage(tab)
				api.nvim_set_current_win(win)
				return
			end
		end
	end
	-- TODO review
	-- Buffer isn't active in any window; use the first window that is not special
	-- (Don't want to move to code in the REPL...)
	for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
		local winbuf = api.nvim_win_get_buf(win)
		if api.nvim_buf_get_option(winbuf, "buftype") == "" then
			local bufchanged, _ = pcall(api.nvim_win_set_buf, win, bufnr)
			if bufchanged then
				api.nvim_win_set_cursor(win, { line, column - 1 })
				with_win(win, api.nvim_command, "normal zv")
				return
			end
		end
	end
end

dap.listeners.after["event_stopped"]["alpha"] = function(session, body)
	if body.reason ~= "breakpoint" then
		return
	end
	if not session.current_frame then
		return
	end
	local path = session.current_frame.source.path
	local line = session.current_frame.line
	local column = session.current_frame.column

	local bufnr = vim.uri_to_bufnr(vim.uri_from_fname(path))
	vim.fn.bufload(bufnr)
	jump_to_location(bufnr, line, column)
end

vim.keymap.set("n", "<leader>dbp", require("dap").toggle_breakpoint, { noremap = true })
vim.keymap.set("n", "<leader>dd", require("dap").continue, { noremap = true })
vim.keymap.set("n", "<leader>de", require("alpha.dap-fn").stop, { noremap = true })
vim.keymap.set("n", "<leader>dl", require("dap").step_into, { noremap = true })
vim.keymap.set("n", "<leader>dj", require("dap").step_over, { noremap = true })
vim.keymap.set("n", "<leader>dk", require("dap").step_out, { noremap = true })
vim.keymap.set("n", "<leader>dt", require("dap").repl.toggle, { noremap = true })
vim.keymap.set("n", "<leader>ds", require("alpha.dap-fn").scopes, { noremap = true })
vim.keymap.set("n", "<leader>da", require("alpha.dap-fn").fullscopes, { noremap = true })
vim.keymap.set("n", "<leader>dbl", require("dap").list_breakpoints, { noremap = true })
vim.keymap.set("n", "<leader>dbc", require("dap").clear_breakpoints, { noremap = true })
vim.keymap.set("n", "<leader>dc", require("dap").run_to_cursor, { noremap = true })
vim.keymap.set("v", "<leader>dk", require("dapui").eval, { noremap = true })
-- can be skipped since I can do it running the continue and promt to use the "Debug test"
vim.keymap.set("n", "<leader>dtt", require("dap-go").debug_test, { noremap = true })
