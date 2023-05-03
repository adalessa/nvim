local redraw_buffer = function()
  local Animation = require "animation"
  local fps = 45 -- frames per second
  local easing = require "animation.easing"

  local buffer = 0
  local len = 0
  local place_holder = {}

  local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, true)

  for _, line in ipairs(lines) do
    len = len + string.len(line)
    table.insert(place_holder, "")
  end

  vim.api.nvim_buf_set_lines(buffer, 0, #lines, true, place_holder)

  local duration = math.ceil(len / fps * 1000)

  local i = 1
  local line_nr = 1
  local insertLine = ""

  local function callback()
    if lines[line_nr] == nil then
      return true
    end
    local char = string.sub(lines[line_nr], i, i)
    if char == nil then
      return true
    end
    insertLine = insertLine .. char
    i = i + 1
    vim.api.nvim_buf_set_lines(buffer, line_nr - 1, line_nr, true, { insertLine })

    if insertLine == lines[line_nr] then
      i = 1
      line_nr = line_nr + 1
      insertLine = ""
    end
  end

  local animation = Animation(duration, fps, easing.line, callback)
  animation:run()
end

return {
  redraw_buffer = redraw_buffer,
}
