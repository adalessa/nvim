local ls = require "luasnip"
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

local M = {
  clean = t [[Given clean stubs list]],
  all = t [[And all stubs should be matched]],
  status_code = fmt([[Then the response status code should be {}]], { i(1, "200") }),
  no_error = t [[And the JSON path expression errors should not have result]],
  feature = fmt(
    [[Feature: {}

  {}
]],
    {
      i(1, "Feature Name"),
      i(0),
    }
  ),
  scenario = fmt(
    [[Scenario: {}
  {}]],
    {
      i(1, "Scenario name"),
      i(0),
    }
  ),
  stub = fmt([[And the APIClient will send a request with a stub from "{}"]], { i(1) }),
  request = fmt(
    [[When I send the GraphQL request:
"""
{}
"""]],
    { i(1) }
  ),
  result = fmt(
    [[And the JSON path expression "data" should be equal to:
"""
{{
  "result": {{
    {}
  }}
}}
"""]],
    { i(1) }
  ),
  query = fmt(
    [[{} {{
result: {}({}) {{
  {}
}}
    }}]],
    { c(1, { t "mutation", t "query" }), i(2, "mutation"), i(3, ""), i(4) }
  ),
  access = fmt(
    [[And the Access Cache has Allowed the userId "{}" for inspectionId "{}"]],
    { i(1, "3414054"), i(2, "42") }
  ),
  branch_access = fmt([[And the Access Cache has branch "{}" for userId "{}"]], { i(1, "1"), i(2, "3414054") }),
}

return M
