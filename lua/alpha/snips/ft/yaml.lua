local ls = require("luasnip")

local snippet_from_nodes = ls.sn
local c = ls.choice_node
local t = ls.text_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local M = {
    str = fmt([[{}:
  type: string
{}]], {
            i(1, ""),
            i(2, ""),
        }),
    bool = fmt([[{}:
  type: boolean
{}]], {
            i(1, ""),
            i(2, ""),
        }),
    float = fmt([[{}:
  type: number
  format: float
{}]], {
            i(1, ""),
            i(2, "")
        }),
    int = fmt([[{}:
  type: integer
{}]], {
            i(1, ""),
            i(2, "")
        }),
    id = fmt([[{}:
  type: integer
  format: int64
{}]], {
            i(1, ""),
            i(2, "")
        }),
    class = fmt([[{}:
  $ref: '#/components/schemas/{}'
{}]], {
            i(1, ""),
            i(2, ""),
            i(3, "")
        }),
    date = fmt([[{}:
  type: string
  format: date-time
{}]], {
            i(1, ""),
            i(2, "")
        }),
    arr = fmt([[{}:
  type: array
  items:
    {}
{}]], {
            i(1, ""),
            i(2, ""),
            i(3, "")
        }),
    ref = fmt([[$ref: '#/components/schemas/{}']], {i(1, "")}),
    obj = fmt([[type: object
properties:
  {}]], i(1, "")),
    aint = fmt([[{}:
  type: array
  items:
    type: int
    format: int64
{}]], {
            i(1, ""),
            i(2, ""),
        }),
    astr = fmt([[{}:
  type: array
  items:
    type: string
{}]], {
            i(1, ""),
            i(2, ""),
        }),
}

return M
