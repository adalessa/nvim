local dap, dapui, dap_go = require("dap"), require("dapui"), require("dap-go")

require("nvim-dap-virtual-text").setup()
-- dap.set_log_level('TRACE')

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸" },
	layouts = {
		{
			elements = {
				"scopes",
				"breakpoints",
				"stacks",
				"watches",
			}, size = 80,
			position = "left",
		},
		{
			elements = {
				"repl",
				-- 'console',
			},
			size = 5,
			position = "bottom",
		},
	},
})

dap_go.setup()

vim.fn.sign_define("DapBreakpoint", { text = "ß", texthl = "", linehl = "", numhl = "" })

-- TODO replace with mason for check if installed and get the path
-- the binary does not work
local php_debug_adapter = vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js"

dap.adapters.php = {
	type = "executable",
	command = "node",
	args = { php_debug_adapter },
}
dap.configurations.php = {
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
}

-- Events Listeners
-- dap.listeners.after.event_initialized["dapui_config"] = function()
-- 	dapui.open({})
-- end

local hydra = require("hydra")
local hint = [[
 Nvim DAP
 _d_: Start/Continue  _j_: StepOver _k_: StepOut _l_: StepInto ^
 _bp_: Toogle Breakpoint  _bc_: Conditional Breakpoint ^
 _c_: Run To Cursor  _tt_: Go Debug Test
 _s_: Start         _x_: Stop Debbuging
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
		{ "s", function ()
		    dap.continue()
            dapui.open({})
		end },
		{ "bp", dap.toggle_breakpoint },
		{ "l", dap.step_into },
		{ "j", dap.step_over },
		{ "k", dap.step_out },
		{ "c", dap.run_to_cursor },
		{ "tt", dap_go.debug_test },
		{
			"bc",
			function()
				vim.ui.input({ prompt = "Condition: " }, function(condition)
					dap.toggle_breakpoint(condition)
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
