local api = vim.api

function GlobalFunction()
    local position_params = vim.lsp.util.make_position_params()
    P(position_params)

    vim.lsp.buf_request(0, "textDocument/completion", position_params, function(err, result)
        if vim.tbl_isempty(result or {}) then return end

        local textEdit = result.items[1].additionalTextEdits;

        local bufnr = vim.api.nvim_get_current_buf()
        vim.lsp.util.apply_text_edits(textEdit, bufnr)
    end)
end

local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"

local get_node_text = vim.treesitter.get_node_text


local function get_root_node()
    local node = ts_utils.get_node_at_cursor()
    if node == nil then
        error("No treesitter parser found.")
    end

    local parent = node:parent()
    while (parent ~= nil) do
        node = parent
        parent = node:parent()
    end

    return node
end

-- this function allows me to retrieve all the queries or mutations
-- from the yaml file
-- next integrate with telescope to quick search
-- actions, go to the file line
-- new action open the php class on the method (lsp maybe, but the problem is not attached)
function Queries()
    vim.treesitter.set_query(
        "yaml",
        "GraphQL_endpoints",
        [[
(
    (document
        (block_node
(block_mapping
(block_mapping_pair
    value: (block_node
(block_mapping (block_mapping_pair
    value: (block_node
(block_mapping (block_mapping_pair
    value: (block_node
    (block_mapping (block_mapping_pair key: (flow_node) @name))
))))))))))
    )
)
        ]]
    )

    local query = vim.treesitter.get_query("yaml", "GraphQL_endpoints")

    local rootNode = get_root_node()
    for _, node in query:iter_captures(rootNode, 0, rootNode:start(), rootNode:end_()) do
        P(get_node_text(node, 0))
        P(node:start())
        P(node:end_())
    end
end

local function get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, '\n')
end

function GetPhpString()
    local s_start = vim.fn.getpos("'<")
    local s_end = vim.fn.getpos("'>")
    local text = get_visual_selection()
    P(text)
    local result = vim.fn.system("php -r 'echo \"" .. text .. "\";'")
    vim.api.nvim_put({result}, "", true, false)
    P(result)
    vim.api.nvim_buf_set_text(0, s_start[2] -1 , s_start[3] -1, s_end[2] -1, s_end[3], {result})
end

vim.keymap.set('n', '<leader>rrh', GetPhpString, {})
