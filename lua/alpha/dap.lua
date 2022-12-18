local dap, dapui, dap_go = require("dap"), require("dapui"), require("dap-go")

require("nvim-dap-virtual-text").setup({})
-- dap.set_log_level('TRACE')

dap_go.setup()

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸" },
	layouts = {
		{
			elements = {
				"scopes",
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 80,
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 10,
			position = "bottom",
		},
	},
})

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "❓", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "", linehl = "", numhl = "" })

dap.adapters.php = {
	type = "executable",
	command = "php-debug-adapter",
}

dap.configurations.php = {
	{
		type = "php",
		request = "launch",
		name = "Laravel",
		port = 9003,
		pathMappings = {
			["/var/www/html"] = "${workspaceFolder}",
		},
	},
	{
		type = "php",
		request = "launch",
		name = "Symfony",
		port = 9003,
		pathMappings = {
			["/app"] = "${workspaceFolder}",
		},
	},
}

require("dap-vscode-js").setup({
	debugger_cmd = { "js-debug-adapter" },
	adapters = { "pwa-node", "pwa-chrome", "node-terminal" },
})

for _, language in ipairs({ "typescript", "javascript" }) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
	}
end

for _, language in ipairs({ "typescriptreact", "javascriptreact" }) do
	require("dap").configurations[language] = {
		{
			type = "pwa-chrome",
			name = "Attach - Remote Debugging",
			request = "attach",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			port = 9222,
			webRoot = "${workspaceFolder}",
		},
		{
			type = "pwa-chrome",
			name = "Launch Chrome",
			request = "launch",
			url = "http://localhost:3000",
		},
	}
end

-- Events Listeners
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({})
end

local hydra = require("hydra")
local hint = [[
 Nvim DAP
 _d_: Start/Continue  _j_: StepOver _k_: StepOut _l_: StepInto ^
 _bp_: Toogle Breakpoint  _bc_: Conditional Breakpoint ^
 _?_: log point ^
 _c_: Run To Cursor ^
 _h_: Show information of the variable under the cursor ^
 _x_: Stop Debbuging ^
 ^^                                                      _<Esc>_
]]

hydra({
	name = "dap",
	hint = hint,
	mode = "n",
	config = {
		color = "blue",
		invoke_on_body = true,
		hint = {
			border = "rounded",
			position = "bottom",
		},
	},
	body = "<leader>d",
	heads = {
		{ "d", dap.continue },
		{ "bp", dap.toggle_breakpoint },
		{ "l", dap.step_into },
		{ "j", dap.step_over },
		{ "k", dap.step_out },
		{ "h", dapui.eval },
		{ "c", dap.run_to_cursor },
		{
			"bc",
			function()
				vim.ui.input({ prompt = "Condition: " }, function(condition)
					dap.set_breakpoint(condition)
				end)
			end,
		},
		{
			"?",
			function()
				vim.ui.input({ prompt = "Log: " }, function(log)
					dap.set_breakpoint(nil, nil, log)
				end)
			end,
		},
		{
			"x",
			function()
				dap.terminate()
				dapui.close({})
				dap.clear_breakpoints()
			end,
		},

		{ "<Esc>", nil, { exit = true } },
	},
})
