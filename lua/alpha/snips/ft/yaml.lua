local ls = require "luasnip"

local snippet_from_nodes = ls.sn
local c = ls.choice_node
local t = ls.text_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local M = {
  str = fmt(
    [[{}:
  type: string
{}]],
    {
      i(1, ""),
      i(2, ""),
    }
  ),
  bool = fmt(
    [[{}:
  type: boolean
{}]],
    {
      i(1, ""),
      i(2, ""),
    }
  ),
  float = fmt(
    [[{}:
  type: number
  format: float
{}]],
    {
      i(1, ""),
      i(2, ""),
    }
  ),
  int = fmt(
    [[{}:
  type: integer
{}]],
    {
      i(1, ""),
      i(2, ""),
    }
  ),
  id = fmt(
    [[{}:
  type: integer
  format: int64
{}]],
    {
      i(1, ""),
      i(2, ""),
    }
  ),
  class = fmt(
    [[{}:
  $ref: '#/components/schemas/{}'
{}]],
    {
      i(1, ""),
      i(2, ""),
      i(3, ""),
    }
  ),
  date = fmt(
    [[{}:
  type: string
  format: date-time
{}]],
    {
      i(1, ""),
      i(2, ""),
    }
  ),
  arr = fmt(
    [[{}:
  type: array
  items:
    {}
{}]],
    {
      i(1, ""),
      i(2, ""),
      i(3, ""),
    }
  ),
  ref = fmt([[$ref: '#/components/schemas/{}']], { i(1, "") }),
  obj = fmt(
    [[type: object
properties:
  {}]],
    i(1, "")
  ),
  aint = fmt(
    [[{}:
  type: array
  items:
    type: int
    format: int64
{}]],
    {
      i(1, ""),
      i(2, ""),
    }
  ),
  astr = fmt(
    [[{}:
  type: array
  items:
    type: string
{}]],
    {
      i(1, ""),
      i(2, ""),
    }
  ),

  mut = fmt(
    [[{}:
    type: "{}"
    resolve: '@=mutation("App\\GraphQL\\Mutation\\{}::{}", {}, info)'
    args:
        {}
]],
    {
      i(1, ""),
      i(2, ""),
      i(3, ""),
      rep(1),
      i(5, ""),
      i(6, ""),
    }
  ),

  input = fmt(
    [[{}:
  type: input-object
  config:
    fields:
      {}
]],
    {
      i(1, ""),
      i(2, ""),
    }
  ),
  f = fmt([[{}:  {{ type: "{}" }}]], { i(1, ""), i(2, "") }),

  api = fmt(
    [[openapi: 3.0.2
info:
  title: {}
  contact:
    name: eva-team-be
  version: {}
x-bundle-apis: true
tags:
  - name: {}
    description: {}
]],
    { i(1, "my app"), i(2, "1.0.0"), i(3, "tag"), i(4, "tag description") }
  ),
  paths = fmt(
    [[paths:
  {}
]],
    { i(0, "") }
  ),
  param = fmt(
    [[parameters:
  - name: {}
    description: {}
    in: path
    required: true
    schema:
      type: integer
      format: int64
]],
    { i(1, ""), i(2, "") }
  ),
  get = fmt(
    [[get:
  operationId: {}
  description: {}
  tags: [ {} ]
  responses:
    200:
      description: Response
      content:
        application/json:
          schema:
            {}
    ]],
    { i(1, "GetOperation"), i(2, "description"), i(3, "tag"), i(4, "") }
  ),

  put = fmt(
    [[put:
  operationId: {}
  tags: [ {} ]
  description: {}
  requestBody:
    content:
      application/json:
        schema:
          {}
    required: true
  responses:
    200:
      description: {}
      content:
        application/json:
          schema:
            {}
    ]],
    { i(1, "PutOperation"), i(2, "tag"), i(3, "description"), i(4, ""), i(5, "description"), i(6, "") }
  ),
}

return M
