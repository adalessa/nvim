local null_ls = require("null-ls")
local utils = require("alpha.utils")
local ts_utils = require("nvim-treesitter.ts_utils")

local get_node_text = vim.treesitter.get_node_text

vim.treesitter.set_query(
	"php",
	"Alpha_refactor_property",
	[[
   [
        (union_type
            (primitive_type) @type
        )
        (union_type
            (named_type) @type
        )
        (property_element
            (variable_name) @name
        )
   ]
]]
)

vim.treesitter.set_query(
    "phpdoc",
    "Alpha_refactor_property_phpdoc",
    [[
    [
        (text) @types
    ]
    ]]
)

local php_setter_getter_actions = {
	method = null_ls.methods.CODE_ACTION,
	filetypes = { "php" },
	generator = {
		fn = function(context)
			local cursor_node = utils.get_master_node()
			if cursor_node.type(cursor_node) ~= "property_declaration" then
				return
			end
			return {
				{
					title = "Create Getter and Setter",
					action = function()
						local property_node = cursor_node

						local property_name
						local property_types = {}
						local query = vim.treesitter.get_query("php", "Alpha_refactor_property")
						for _, match in query:iter_matches(property_node, 0) do
							for id, subNode in pairs(match) do
								local capture_name = query.captures[id]
								if capture_name == "name" then
									property_name = string.sub(get_node_text(subNode, 0), 2)
								elseif capture_name == "type" then
									table.insert(property_types, get_node_text(subNode, 0))
								end
							end
						end

                        local comment_node = ts_utils.get_previous_node(property_node)
                        P(comment_node:type())
                        local row, column = comment_node:start()
                        local test_node = ts_utils.get_root_for_position(row, column)
						local comment_query = vim.treesitter.get_query("phpdoc", "Alpha_refactor_property_phpdoc")
						for _, match in comment_query:iter_matches(test_node, 0) do
							for _, subNode in pairs(match) do
                                P(get_node_text(subNode, 0))
							end
						end

						local insert = {}
						table.insert(insert, "")
						table.insert(
							insert,
							string.format(
								"    public function get%s(): %s",
								utils.ucfirst(property_name),
								table.concat(property_types, "|")
							)
						)
						table.insert(insert, "    {")
						table.insert(insert, string.format("        return $this->%s;", property_name))
						table.insert(insert, "    }")
						table.insert(insert, "")

						table.insert(
							insert,
							string.format(
								"    public function set%s(%s $%s): self",
								utils.ucfirst(property_name),
								table.concat(property_types, "|"),
								property_name
							)
						)
						table.insert(insert, "    {")
						table.insert(insert, string.format("        $this->%s = $%s;", property_name, property_name))
						table.insert(insert, "")
						table.insert(insert, string.format("        return $this;"))
						table.insert(insert, "    }")

                        -- this is using the last line of file mines 2
						vim.api.nvim_buf_set_lines(0, #context.content - 2, #context.content - 2, false, insert)
					end,
				},
			}
			-- context dump
			-- {
			--   bufname = "/home/alpha/.dotfiles/nvim/.config/nvim/test.php",
			--   bufnr = 90,
			--   client_id = 1,
			--   col = 20,
			--   content = { "<?php", "", "class Some", "{", "    /**", "     * @var []int", "     */", "    private array $test = 1;", "}", "" },
			--   ft = "php",
			--   lsp_method = "textDocument/codeAction",
			--   method = "NULL_LS_CODE_ACTION",
			--   range = {
			--     col = 21,
			--     end_col = 21,
			--     end_row = 8,
			--     row = 8
			--   },
			--   row = 8
			-- }
            -- una solucion manar el archivo a algo php para q lo procece

			-- P(context)
		end,
	},
}
-- uncomment when not developing this
null_ls.reset_sources()
null_ls.register(php_setter_getter_actions)
