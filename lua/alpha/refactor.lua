local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

local get_master_node = function()

    local node = ts_utils.get_node_at_cursor()
    if node == nil then
        error("No treesitter parser found.")
    end

    local start_row = node:start()

    local parent = node:parent()
    while (parent ~= nil and parent:start() == start_row) do
        node = parent
        parent = node:parent()
    end

    return node
end

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


M.setter_getter = function()
    local node = get_master_node()

    if node.type(node) ~= 'property_declaration' then
        error('can not work on a node that is not a property_declaration')
    end

    local bufnr = vim.api.nvim_get_current_buf()
    -- ts_utils.update_selection(bufnr, node)

    local p = {}
    for _, child in ipairs(ts_utils.get_named_children(node)) do
        -- print(vim.inspect(ts_utils.get_node_text(child, bufnr)))
        -- print(vim.inspect(child.type(child)))
        p[node.type(child)] = ts_utils.get_node_text(child, bufnr)[1]
    end

    -- for this expected to have 2 or more named childs
    -- visibility modifier
    -- type_list (optional) could have a  ?  to be nullable or could have a list
    -- property_element
    -- print(vim.inspect(p))

    local comment = ''

    if (p.type_list == 'array' or p.type_list == nil) then
        local prev = ts_utils.get_previous_node(node, false, false)
        if (node.type(prev) == 'comment') then
            comment = ts_utils.get_node_text(prev)[2]
            -- print(vim.inspect(comment))
            comment = string.match(comment, '@var (.*)')
        end
        -- print(vim.inspect(node.type(prev)))
        -- print(vim.inspect(ts_utils.get_node_text(prev)))
    end

    -- print(vim.inspect(comment))
    -- if  type_list is not present could go up and read the comment
    -- and base on a regular expression, and  get  the type
    -- if the type is array want to also read to see if is a typed array
    --
    local classNode = node:parent()
    local classEnd = classNode:end_()

    local variable = string.sub(p.property_element, 2)

    local function firstToUpper(str)
        return (str:gsub("^%l", string.upper))
    end

    local function mysplit (inputstr, sep)
        if sep == nil then
            sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
        end
        return t
    end

    local function implode(delimiter, list)
        local len = #list
        if len == 0 then
            return ""
        end
        local string = list[1]
        for i = 2, len do
            string = string .. delimiter .. list[i]
        end
        return string
    end

    local varType = p.type_list
    if (varType == nil) then
        local isNullable = false
        local types = {}
        local commentTypes = mysplit(comment, "|")
        for _, v in ipairs(commentTypes) do
            if (v == "null") then
                isNullable = true
            else
                table.insert(types, v)
            end
        end
        varType = implode("|", types)
        if (isNullable) then
            varType = "?" .. varType
        end

    end

    local insert = {}
    table.insert(insert, "")
    if (comment ~= nil and comment ~= "") then
        table.insert(insert, "    /**")
        table.insert(insert, string.format("     * @return %s", comment))
        table.insert(insert, "     */")
    end
    table.insert(insert, string.format("    public function get%s(): %s", firstToUpper(variable), varType))
    table.insert(insert, "    {")
    table.insert(insert, string.format("        return $this->%s;", variable))
    table.insert(insert, "    }")
    table.insert(insert, "")

    if (comment ~= nil and comment ~= "") then
        table.insert(insert, "    /**")
        table.insert(insert, string.format("     * @param %s %s", comment, p.property_element))
        table.insert(insert, "     *")
        table.insert(insert, "     * @return self")
        table.insert(insert, "     */")
    end
    table.insert(insert, string.format("    public function set%s(%s %s): self", firstToUpper(variable), varType, p.property_element))
    table.insert(insert, "    {")
    table.insert(insert, string.format("        $this->%s = %s;", variable, p.property_element))
    table.insert(insert, "")
    table.insert(insert, string.format("        return $this;"))
    table.insert(insert, "    }")

    vim.api.nvim_buf_set_lines(bufnr, classEnd, classEnd, false, insert)

end

-- New function the idea is to create properties quick.
-- Ask for property name
-- Don't ask visibility, just set a default, in my case private
-- Ask for type - Can I merge type for nullable, option 1 "string|nullable" "?string" "int|string" and split by the `|`
-- Ask for nullable
-- Dont Ask for comment generation - Create a new function for variable comment generation
-- Dont Ask for setter, getter generation - Just call the setter and the getter
-- To much questions is bad
--
--
-- Comment generation - variable - functions
--
-- Important is the difference between the the snippets and the shurtchut
-- Want open a class, don't want to look for the place, just add it
--
local function allowedPreviousNodes(node)
    return node:type() == "use_declaration" or node:type() == "property_declaration"
end

M.new_property = function ()
    local visibility = "private"
    -- TODO un comment
    local name = vim.fn.input("Property name: ")
    if name == nil then
        return
    end
    local type = vim.fn.input("Property type: ")
    if type == nil then
        type = ""
    end
    -- local name = "mother"
    -- local type = "string"

    local rootNode = get_root_node()
    local classNode = rootNode:child(rootNode:child_count() - 1)
    local bodyNode = classNode:child(classNode:child_count() - 1)

    local bufnr = vim.api.nvim_get_current_buf()

    local endLine = 0
    local addEmptyLineBefore = false
    local addEmptyLineAfter = false
    if bodyNode:named_child_count() == 0 then
        endLine = bodyNode:end_()
    else
        local node = bodyNode:child(1)
        local sibling = node

        if allowedPreviousNodes(node) == false then
            endLine = node:start()
            addEmptyLineAfter = true
        else
            addEmptyLineBefore = true
            while (sibling ~= nil) do
                if sibling:type() ~= "use_declaration" and sibling:type() ~= "property_declaration" then
                    endLine = node:end_() + 1
                    break
                end
                node = sibling
                sibling = node:next_sibling()
            end
        end
    end

    if endLine == 0 then
        return
    end

    local row = endLine + 1
    local insert = {}
    if addEmptyLineBefore then
        table.insert(insert, "")
        row = row + 1
    end
    local lineContent =  string.format("    %s %s $%s;", visibility, type, name)
    table.insert(insert, lineContent)
    if addEmptyLineAfter then
        table.insert(insert, "")
    end
    local column = string.len(lineContent) - string.len(name) - 1
    vim.api.nvim_buf_set_lines(bufnr, endLine, endLine, false, insert)
    vim.api.nvim_win_set_cursor(0, {row, column})
end

-- vim.keymap.set("n", "<leader>rs", M.setter_getter, {})
-- vim.keymap.set("n", "<leader>rn", M.new_property, {})

return M
