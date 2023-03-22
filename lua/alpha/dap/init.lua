local dap, dapui, hydra = require "dap", require "dapui", require "hydra"

-- Setup Virtual Text
require("nvim-dap-virtual-text").setup {}

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/alpha/dap/configs/*.lua", true)) do
  loadfile(ft_path)()
end

-- Signs
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "❓", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "", linehl = "", numhl = "" })

-- UI structure
dapui.setup {
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
      position = "right",
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
}

-- Events Listeners
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open {}
end

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

hydra {
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
        dapui.close {}
        dap.clear_breakpoints()
      end,
    },

    { "<Esc>", nil, { exit = true } },
  },
}
