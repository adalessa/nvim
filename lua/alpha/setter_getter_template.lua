local utils = require("alpha.utils")

local M = {}

local function isNullable(nullable)
    if nullable then
        return "?"
    end

    return ""
end

local function toTable(fn)
    local t = {}
    for s in fn:gmatch("[^\r\n]+") do
        table.insert(t, s)
    end

    return t
end

M.getGetter = function(property, nullable, types)
    local fn = string.format([[
    public function get%s(): %s%s
    {
        return $this->%s;
    }
    ]],
        utils.ucfirst(property),
        isNullable(nullable),
        table.concat(types, "|"),
        property
    )

    return toTable(fn)
end

M.getSetter = function(property, nullable, types)
    local fn = string.format([[
    public function set%s(%s%s $%s): self
    {
        $this->%s = $%s;

        return $this;
    }
    ]],
        utils.ucfirst(property),
        isNullable(nullable),
        table.concat(types, "|"),
        property,
        property,
        property
    )

    return toTable(fn)
end

return M
