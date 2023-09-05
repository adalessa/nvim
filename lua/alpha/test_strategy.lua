local Job = require "plenary.job"

local function splitString(input_string)
    local parts = {}
    local in_quote = false
    local part_start = 1

    for i = 1, #input_string do
        local char = input_string:sub(i, i)

        if char == "'" then
            in_quote = not in_quote
        elseif char == " " and not in_quote then
            local part = input_string:sub(part_start, i - 1)
            -- Remove surrounding quotes if they exist
            if part:sub(1, 1) == "'" and part:sub(-1) == "'" then
                part = part:sub(2, -2)
            end
            table.insert(parts, part)
            part_start = i + 1
        end
    end

    -- Add the last part (and remove surrounding quotes if they exist)
    local part = input_string:sub(part_start)
    if part:sub(1, 1) == "'" and part:sub(-1) == "'" then
        part = part:sub(2, -2)
    end
    table.insert(parts, part)

    return parts
end

local function myStrategy(cmd)
  --convert cmd from string to table
  if type(cmd) == "string" then
    -- do not split quoted parts of the string
    cmd = splitString(cmd)
  end

  -- get first element of cmd and remove from the cmd
  local cmd_name = table.remove(cmd, 1)

  ---@diagnostic disable-next-line: missing-fields
  Job:new({
    command = cmd_name,
    args = cmd,
    on_exit = function(j, return_val)
      -- in case of result val 0 show success message
      if return_val == 0 then
        vim.notify("Test run successfully", vim.log.levels.INFO, { title = "Test" })
        return
      end
      local result = j:stderr_result() or j:stdout_result()
      -- join result in a single string
      result = table.concat(result, "\n")
      -- escape / characters
      result = result:gsub("/", "\\/")
      vim.notify(result, vim.log.levels.ERROR, { title = "Test" })
    end,
  }):start()
end

vim.g["test#custom_strategies"] = { myStrategy = myStrategy }
vim.g["test#strategy"] = "myStrategy"
