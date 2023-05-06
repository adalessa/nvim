local M = {}

local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"

M.create_plugin = function(prompt_bufnr)
  local new_plugin = action_state.get_current_line()
  actions.close(prompt_bufnr)
  vim.cmd(string.format("edit ~/.config/nvim/lua/plugins/%s.lua", new_plugin))
end


local get_disable_stm_node = function(bufnr, tree)
  vim.treesitter.query.set(
    "lua",
    "alpha_plugin_is_disabled",
    [[
(return_statement
  (expression_list
    (table_constructor
      (field
        name: (identifier) @enabled (#eq? @enabled "enabled")
        value: (false) @is_false
        )
      )
    )
  )
        ]]
  )

  local query = vim.treesitter.query.get("lua", "alpha_plugin_is_disabled")

  for id, node in query:iter_captures(tree:root(), bufnr) do
    if query.captures[id] == "enabled" then
      return node
    end
  end

  return nil
end

local get_enabled_node = function(bufnr, tree)
  vim.treesitter.query.set(
    "lua",
    "alpha_plugin_has_enable_property",
    [[
(return_statement
  (expression_list
    (table_constructor
      (field
        name: (identifier) @enabled (#eq? @enabled "enabled")
        )
      )
    )
  )
        ]]
  )

  local query = vim.treesitter.query.get("lua", "alpha_plugin_has_enable_property")

  for id, node in query:iter_captures(tree:root(), bufnr) do
    if query.captures[id] == "enabled" then
      return node
    end
  end

  return nil
end

local get_return_node = function(bufnr, tree)
  vim.treesitter.query.set(
    "lua",
    "alpha_plugin_return_table_constructor",
    [[
(return_statement
  (expression_list
    (table_constructor) @table_constructor
    )
  )
        ]]
  )

  local query = vim.treesitter.query.get("lua", "alpha_plugin_return_table_constructor")

  for id, node in query:iter_captures(tree:root(), bufnr) do
    if query.captures[id] == "table_constructor" then
      return node
    end
  end

  return nil
end

M.disable_plugin = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local uri = vim.uri_from_fname(entry.cwd .. entry[1])
  local bufnr = vim.uri_to_bufnr(uri)
  vim.fn.bufload(bufnr)

  local parsers = require "nvim-treesitter.parsers"
  local parser = parsers.get_parser(bufnr)
  local tree = parser:parse()[1]

  local disabled_stm_node = get_disable_stm_node(bufnr, tree)
  if disabled_stm_node ~= nil then
    vim.notify("Plugin is already disable", vim.log.levels.WARN, {})
    return
  end

  local start_line
  local end_line

  local enable_node = get_enabled_node(bufnr, tree)
  if enable_node == nil then
    -- node does not exists need to assume line
    local return_node = get_return_node(bufnr, tree)

    if return_node == nil then
      vim.notify("Can determine how to diable the plugin", vim.log.levels.ERROR, {})
      return
    end

    start_line = return_node:start() + 2
    end_line = start_line
  else
    start_line = enable_node:start()
    end_line = start_line + 1
  end

  vim.api.nvim_buf_set_lines(bufnr, start_line, end_line, false, { "  enabled = false," })
  vim.notify("Plugin " .. entry[1] .. " Disabled", vim.log.levels.INFO, {})
  actions.close(prompt_bufnr)
  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd "write"
  end)
end

M.enable_plugin = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local uri = vim.uri_from_fname(entry.cwd .. entry[1])
  local bufnr = vim.uri_to_bufnr(uri)
  vim.fn.bufload(bufnr)

  local parsers = require "nvim-treesitter.parsers"
  local parser = parsers.get_parser(bufnr)

  local tree = parser:parse()[1]

  local disabled_stm_node = get_disable_stm_node(bufnr, tree)
  if disabled_stm_node == nil then
    vim.notify("Plugin is already Enable", vim.log.levels.WARN, {})
    return
  end

  local enable_line = disabled_stm_node:start()
  vim.api.nvim_buf_set_lines(bufnr, enable_line, enable_line + 1, false, {})
  vim.notify("Plugin " .. entry[1] .. " Enabled", vim.log.levels.INFO, {})
  actions.close(prompt_bufnr)
  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd "write"
  end)
end

M.create_scratch_file = function(prompt_bufnr)
  local new_scratch = action_state.get_current_line()
  actions.close(prompt_bufnr)
  vim.cmd(string.format("edit ~/.config/nvim/lua/scratchs/%s.lua", new_scratch))
end

return M
