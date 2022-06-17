local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local action_set = require("telescope.actions.set")
local get_node_text = vim.treesitter.get_node_text

local function getElements()
    vim.treesitter.set_query(
        "yaml",
        "GraphQL_endpoints",
        [[
    (document (block_node (block_mapping (block_mapping_pair
        value: (block_node (block_mapping (block_mapping_pair
            value: (block_node (block_mapping (block_mapping_pair
                value: (block_node (block_mapping (block_mapping_pair
                    key: (flow_node) @mutation
                    value: (block_node (block_mapping (block_mapping_pair
                         key: (flow_node) @resolve (#eq? @resolve "resolve")
                         value: (flow_node) @resolver
                     )))
                )))
            )))
        )))
    ))))
        ]]
    )

    local query = vim.treesitter.get_query("yaml", "GraphQL_endpoints")

    local elements = {}

    local parsers = require("nvim-treesitter.parsers")
    local parser = parsers.get_parser(0)
    ---@diagnostic disable-next-line: deprecated
    local tree = unpack(parser:parse())

    for id, node in query:iter_captures(tree:root(), 0) do
        if query.captures[id] == "mutation" then
            table.insert(elements, { get_node_text(node, 0), node:start() + 1 })
        end
    end

    return elements
end

function Queries(opts)
    opts = opts or {}
    pickers.new(opts, {
        promt_title = "Queries",
        finder = finders.new_table({
            results = getElements(),
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry[1],
                    ordinal = entry[1],
                    path = vim.api.nvim_buf_get_name(0),
                    lnum = entry[2],
                }
            end,
        }),
        sorter = conf.generic_sorter(opts),
        previewer = conf.grep_previewer(opts),
        attach_mappings = function()
            action_set.select:enhance({
                post = function()
                    local selection = action_state.get_selected_entry()
                    vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
                end,
            })

            return true
        end,
    }):find()
end
