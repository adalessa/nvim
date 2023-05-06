--- Dumps all values into pretty print
---@vararg any
---@return any
dump = function(...)
  local args = {...}

  local mapped = {}
  for _, v in ipairs(args) do
    table.insert(mapped, vim.inspect(v))
  end
  print(unpack(mapped))

  return unpack(args)
end

Reload = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  Reload(name)
  return require(name)
end
