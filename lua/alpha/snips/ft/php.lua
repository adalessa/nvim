local ls = require "luasnip"
local composer = require "composer"

local snippet_from_nodes = ls.sn
local c = ls.choice_node
local t = ls.text_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local visibility = function(position, default)
  local possibles = { "private", "protected", "public" }
  local options = {}

  for _, value in pairs(possibles) do
    if value == default then
      table.insert(options, 1, t(value))
    else
      table.insert(options, t(value))
    end
  end

  return c(position, options)
end

local var_name = function(args)
  return snippet_from_nodes(nil, {
    i(1, args[1][1]:gsub("^%u", string.lower):gsub("Interface", "")  or ""),
  })
end

local class_name = function()
  return vim.fn.expand "%:t:r"
end

local M = {}

M.v = fmt(
  [[
/**
 * @var {}
 */
{} {} ${};
]],
  {
    i(1, "type"),
    visibility(2, "private"),
    i(3, "Type"),
    i(4, "var"),
  }
)

M.class = fmt(
  [[
<?php

declare(strict_types=1);

namespace {};

class {}
{{
    {}
}}
]],
  {
    f(composer.resolve_php_namespace),
    f(class_name),
    i(0),
  }
)

M.pro = fmt([[{} {}{} ${},]], {
  visibility(1, "private"),
  c(2, {
    t "readonly ",
    t "",
  }),
  i(3, "Type"),
  d(4, var_name, { 3 }),
})

M.op = fmt(
  [[
    /**
     * @var ObjectProphecy<{}>
     */
    private ObjectProphecy ${};
]],
  {
    i(1, "Type"),
    d(2, var_name, { 1 }),
  }
)

M.iop = fmt(
  [[$this->{} = $this->prophesize({}::class);]],
  {
    i(1, ""),
    i(2, ""),
  }
)

M.arg = fmt([[{} ${}]], {
  i(1, "Type"),
  d(2, var_name, { 1 }),
})

M._c = fmt(
  [[{} function __construct({}) {{
    {}
}}]],
  {
    visibility(1, "public"),
    i(2),
    i(0),
  }
)

M._p = fmt(
  [[{} function __construct(
    {}
) {{
}}]],
  {
    visibility(1, "public"),
    i(2),
  }
)

M.strict = t "declare(strict_types=1);"

M["fn"] = fmt(
  [[{} function {}({}): {}
{{
  {}
}}]],
  { visibility(1, "public"), i(2), i(3), i(4, "void"), i(0) }
)

M["then"] = fmt(
  [[->then(
  function ({}) {{
    {}
  }}
)]],
  { i(1, ""), i(2, "") }
)

M.test = fmt(
  [[/**
 * @test
 */
public function it_{}(): void
{{
    {}
}}
]],
  { i(1, ""), i(0, "") }
)

return M
