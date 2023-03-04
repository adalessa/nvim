local dap = require("dap")

local rust_adapter = nil
local rust_adapters = { "lldb-vscode", "codelldb" }
for _, adapter in pairs(rust_adapters) do
  if vim.fn.executable(adapter) then
    rust_adapter = adapter
  end
end

if rust_adapter ~= nil then
  dap.adapters.lldb = {
    type = "executable",
    command = rust_adapter,
    name = "lldb",
  }

  dap.configurations.rust = {
    {
      name = "launch",
      type = "lldb",
      request = "launch",
      program = function()
        local dir = vim.fn.getcwd()
        return dir .. "/target/debug/" .. vim.fs.basename(dir)
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = function()
        local resp = vim.fn.input "Arguments: "
        if resp == "" then
          return {}
        end

        return vim.fn.split(resp, " ")
      end,
    },
    {
      name = "custom",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = function()
        local resp = vim.fn.input "Arguments: "
        if resp == "" then
          return {}
        end

        return vim.fn.split(resp, " ")
      end,
    },
  }
end
