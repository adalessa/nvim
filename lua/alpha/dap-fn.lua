local dap = require("dap")
local dapui = require("dapui")
local widgets = require('dap.ui.widgets')
local ui = require('dap.ui')
local api = vim.api

local M = {}

local function new_buf()
  local buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(buf, 'modifiable', false)
  api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  api.nvim_buf_set_keymap(
    buf, "n", "<CR>", "<Cmd>lua require('dap.ui').trigger_actions({ mode = 'first' })<CR>", {})
  api.nvim_buf_set_keymap(
    buf, "n", "a", "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})
  return buf
end

local scopes = {
  refresh_listener = 'scopes',
  new_buf = function(view)
    local dap = require('dap')
    local function reset_tree()
      view.tree = nil
    end
    dap.listeners.after['event_terminated'][view] = reset_tree
    dap.listeners.after['event_exited'][view] = reset_tree
    local buf = new_buf()
    api.nvim_buf_attach(buf, false, {
      on_detach = function()
        dap.listeners.after['event_terminated'][view] = nil
        dap.listeners.after['event_exited'][view] = nil
      end
    })
    return buf
  end,
  render = function(view)
    local session = require('dap').session()
    local frame = session and session.current_frame or {}
    local tree = view.tree
    if not tree then
      local spec = vim.deepcopy(require('dap.entity').scope.tree_spec)
      spec.extra_context = { view = view }
      tree = ui.new_tree(spec)
      view.tree = tree
    end
    local layer = view.layer()
    local scopes = frame.scopes or {}
    local render
    render = function(idx, scope)
      if not scope then
        return
      end

      if scope.name ~= 'Locals' then
          return
      end

      tree.render(layer, scope, function()
        render(next(scopes, idx))
      end)
    end
    render(next(scopes))
  end,
}

M.scopes = function ()
  local a = widgets.centered_float(scopes)
  -- set cursor at top to make it easier to read
  vim.api.nvim_win_set_cursor(a.win, {1, 0})
end

M.fullscopes = function ()
  local a = widgets.centered_float(widgets.scopes)
  -- set cursor at top to make it easier to read
  vim.api.nvim_win_set_cursor(a.win, {1, 0})
end

M.stop = function ()
    dap.terminate()
    dapui.close()
    dap.clear_breakpoints()
end

return M
