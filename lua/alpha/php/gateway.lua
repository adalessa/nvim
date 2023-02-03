local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local action_state = require "telescope.actions.state"
local action_set = require "telescope.actions.set"
local actions = require "telescope.actions"
local get_node_text = vim.treesitter.get_node_text

local gateway = {}

local get_definition_buffer = function(type)
  local uri = vim.uri_from_fname(vim.fn.getcwd() .. "/config/graphql/_" .. type .. ".yaml")
  local buff = vim.uri_to_bufnr(uri)
  vim.fn.bufload(buff)

  return buff
end

local get_all_definitions = function()
  local mutations_definitions = gateway.get_graphql_definitions(get_definition_buffer "mutation")
  local queries_definitions = gateway.get_graphql_definitions(get_definition_buffer "query")
  for _, definition in ipairs(queries_definitions) do
    table.insert(mutations_definitions, definition)
  end

  return mutations_definitions
end

-- "'@=mutation(\"App\\\\GraphQL\\\\Mutations\\\\Mutation::action\", ...)'",
local open_resolver = function(resolver)
  -- need to parse to get this values
  local args = string.match(resolver, "'@=mutation%((.+)%)'")
  if args == nil then
    args = string.match(resolver, "'@=query%((.+)%)'")
  end
  if args == nil then
    P "error resolver"
    P(resolver)
    return
  end

  local args_tbl = vim.split(args, ", ")
  local fqn = string.match(args_tbl[1], '"(.+)"')
  fqn = string.gsub(fqn, "\\\\", "\\")
  -- P(fqn)

  require("alpha.php.lsp").find(fqn, "phpactor")
end

--- @param bufnr integer Buff id
gateway.get_graphql_definitions = function(bufnr)
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

  local parsers = require "nvim-treesitter.parsers"
  local parser = parsers.get_parser(bufnr)
  local tree = parser:parse()[1]

  for id, node in query:iter_captures(tree:root(), bufnr) do
    if query.captures[id] == "mutation" then
      table.insert(elements, {
        value = get_node_text(node, bufnr),
        lnum = node:start() + 1,
        buffer = bufnr,
      })
    elseif query.captures[id] == "resolver" then
      elements[#elements].resolver = get_node_text(node, bufnr)
    end
  end

  return elements
end

--- gets the graphql function defined on a given buffer
--- @param opts table: options to pass to the picker
gateway.graphql_definitions = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      promt_title = "Queries",
      finder = finders.new_table {
        results = get_all_definitions(),
        entry_maker = function(entry)
          -- buffer = 43,
          -- lnum = 82,
          -- resolver = "'@=mutation(\"App\\\\GraphQL\\\\Mutation\\\\Mutation::action\", ...)'",
          -- value = "deleteVehicleImage"
          return {
            value = entry,
            display = entry.value,
            ordinal = entry.value,
            path = vim.api.nvim_buf_get_name(entry.buffer),
            lnum = entry.lnum,
            resolver = entry.resolver,
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      previewer = conf.grep_previewer(opts),
      attach_mappings = function(prompt_bufnr, map)
        action_set.select:enhance {
          post = function()
            local selection = action_state.get_selected_entry()
            vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
          end,
        }
        map("i", "<c-o>", function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          open_resolver(selection.resolver)
        end)
        return true
      end,
    })
    :find()
end

return gateway
