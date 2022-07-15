local dap, dapui, dap_install, dap_go = require("dap"), require("dapui"), require("dap-install"), require("dap-go")

require("nvim-dap-virtual-text").setup()

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
				-- 'console',
			},
			size = 10,
			position = "bottom",
		},
	},
})

dap_go.setup()

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
	dapui.open({})
end

-- command to start debugging
-- run dap continue and enable the keybindings
-- when finish delete all keybindings

-- TODO create a hydra for debug

local bindings = {
	{ mode = "n", lhs = "<leader>dd", rhs = dap.continue },
	{ mode = "n", lhs = "<leader>dbp", rhs = dap.toggle_breakpoint },
	{ mode = "n", lhs = "<leader>dl", rhs = dap.step_into },
	{ mode = "n", lhs = "<leader>dj", rhs = dap.step_over },
	{ mode = "n", lhs = "<leader>dk", rhs = dap.step_out },
	{ mode = "n", lhs = "<leader>dc", rhs = dap.run_to_cursor },
	{ mode = "v", lhs = "<leader>dv", rhs = dapui.eval },
	{ mode = "n", lhs = "<leader>dcb", rhs = function ()
        vim.ui.input({prompt = "Condition: "}, function (condition)
            dap.toggle_breakpoint(condition)
        end)
	end },
}

vim.keymap.set("n", "<leader>dst", function()
	dap.continue()
	for _, bind in pairs(bindings) do
		vim.keymap.set(bind.mode, bind.lhs, bind.rhs, { noremap = true })
	end
end, { noremap = true })

vim.keymap.set("n", "<leader>dsp", function()
	dap.terminate()
	dapui.close({})
	dap.clear_breakpoints()

	for _, bind in pairs(bindings) do
		vim.keymap.del(bind.mode, bind.lhs)
	end
end, { noremap = true })

-- can be skipped since I can do it running the continue and promt to use the "Debug test"
vim.keymap.set("n", "<leader>dtt", dap_go.debug_test, { noremap = true })
