local api = vim.api

local function create_quickfix_entry(selection)
  local filename, linenumber = selection:match "([^:]+):(%d+)"

  return {
    filename = vim.fn.getcwd() .. "/" .. filename,
    lnum = tonumber(linenumber),
    col = 1,
    text = filename,
  }
end

local function add_selections_to_quickfix(selections)
  local quickfix_list = {}

  for _, selection in ipairs(selections) do
    local entry = create_quickfix_entry(selection)
    table.insert(quickfix_list, entry)
  end

  vim.fn.setqflist(quickfix_list, "r")
end

local function get_selections()
  local _, end_line, _, _ = unpack(vim.fn.getpos "'>")
  local _, start_line, _, _ = unpack(vim.fn.getpos "'<")
  local lines = api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  local selections = {}
  for _, line in ipairs(lines) do
    for selection in line:gmatch "%S+" do
      table.insert(selections, selection)
    end
  end

  return selections
end

local function select_to_quickfix()
  local selections = get_selections()

  if #selections > 0 then
    add_selections_to_quickfix(selections)
    print "Selections added to quickfix list"
  else
    print "No selections found"
  end
end

return {
  handle = select_to_quickfix,
}
