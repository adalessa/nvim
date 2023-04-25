local Path = require "plenary.path"

local lsp = {}

local open_filename = function(filename)
  if vim.api.nvim_buf_get_name(0) ~= filename then
    filename = Path:new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
    pcall(vim.cmd, string.format("%s %s", "edit", filename))
  end
end

---@param server_name string
---@return table|nil, boolean
local get_client = function(server_name)
  local clients = vim.lsp.get_active_clients { name = server_name }
  local client = clients[1] or nil
  local new_instance = false

  if not client then
    local server = require("lspconfig")[server_name]
    local config = server.make_config(vim.fn.getcwd())
    local client_id = vim.lsp.start(config)
    client = vim.lsp.get_client_by_id(client_id)
    new_instance = true
  end

  return client, new_instance
end

local function go_to(client, is_new_instance, full_class, method)
  local class_parts = vim.split(full_class, "\\")
  local class = class_parts[#class_parts]

  local resp = client.request_sync("workspace/symbol", { query = class }, nil)

  local locations = vim.lsp.util.symbols_to_items(resp.result or {}, nil) or {}
  if vim.tbl_isempty(locations) then
    vim.api.nvim_err_writeln("Empty response looking for class: " .. full_class)
    if is_new_instance then
      vim.lsp.stop_client(client.id)
    end
    return
  end

  local class_location = nil
  for idx, location in pairs(locations) do
    if location.text == string.format("[Class] %s", full_class) then
      class_location = locations[idx]
      break
    end
  end

  if class_location == nil then
    vim.api.nvim_err_writeln("Could not find class for : " .. full_class)
    if is_new_instance then
      vim.lsp.stop_client(client.id)
    end
    return
  end

  open_filename(class_location.filename)

  local params = vim.lsp.util.make_position_params(0)
  if is_new_instance then
    vim.lsp.buf_attach_client(0, client.id)
  end

  vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(method_err, method_server_result, _, _)
    if method_err then
      vim.api.nvim_err_writeln("Error when finding workspace symbols: " .. method_err.message)
      if is_new_instance then
        vim.lsp.stop_client(client.id)
      end
      return
    end

    local method_locations = vim.lsp.util.symbols_to_items(method_server_result or {}, 0) or {}
    if vim.tbl_isempty(method_locations) then
      vim.api.nvim_err_writeln(string.format("empty response looking for method: %s", method or "__invoke"))
      if is_new_instance then
        vim.lsp.stop_client(client.id)
      end
      return
    end

    local method_location = nil
    for _, value in ipairs(method_locations) do
      if value.text == string.format("[Method] %s", method or "__invoke") then
        method_location = value
        break
      end
    end

    if method_location == nil then
      if is_new_instance then
        vim.lsp.stop_client(client.id)
      end
      return
    end

    local row = method_location.lnum
    local col = method_location.col - 1

    if row and col then
      local ok, err_msg = pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
      if not ok then
        vim.api.nvim_err_writeln("Erro setting row and col " .. err_msg)
      end
      vim.cmd "normal zt"
    end
    if is_new_instance then
      vim.lsp.stop_client(client.id)
    end
  end)
end

---Return a buffer id for the given client
---@param server_name string
---@return integer|nil
lsp.get_lsp_buffer = function(server_name)
  local clients = vim.lsp.get_active_clients { name = server_name }
  if #clients == 0 then
    return nil
  end

  local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)

  if #buffers == 0 then
    return nil
  end

  return buffers[1]
end

--- @param fqn string: fully name to search Class::method
lsp.find = function(fqn, server_name)
  local search = vim.split(fqn, "::")
  local fqn_class = search[1]
  local method = search[2]

  local client, is_new_instance = get_client(server_name)

  if not client then
    vim.api.nvim_err_writeln "Could not get lsp client"
    return
  end

  go_to(client, is_new_instance, fqn_class, method)
end

return lsp
