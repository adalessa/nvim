local ls = require("luasnip")

local snippet_from_nodes = ls.sn
local c = ls.choice_node
local t = ls.text_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

function string.starts(String, Start)
	return string.sub(String, 1, string.len(Start)) == Start
end

local newline = function(text)
	return t({ "", text })
end

local visibility = function(position, default)
	local possibles = { "private", "public" }
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

local namespace = function()
	local dir = vim.fn.expand("%:h")
	local autoloads = vim.call("composer#query", "autoload.psr-4")
	if autoloads == nil then
		return (dir:gsub("^%l", string.upper))
	end

	local globalNamespace
	for key, value in pairs(autoloads) do
		if string.starts(dir, value:sub(1, -2)) then
			globalNamespace = key:sub(1, -2)
			dir = dir:sub(#key + 1)
			break
		end
	end
	dir = dir:gsub("/", "\\")

	return string.format("%s\\%s", globalNamespace, dir)
end

local class_name = function()
	return vim.fn.expand("%:t:r")
end

local M = {
	v = fmt(
		[[
/**
 * @var {}
 */
{} ${};
]],
		{
			i(1, "type"),
			d(2, visibility, {}, "private"),
			i(3, "var"),
		}
	),
	class = fmt(
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
			f(namespace),
			f(class_name),
			i(0),
		}
	),

	pro = fmt([[{} {} ${},]], {
		visibility(1, "private"),
		i(2, "Type"),
		f(function(args)
			return args[1][1]:gsub("^%u", string.lower)
		end, { 2 }),
	}),

	_c = fmt(
[[{} function __construct({}) {{
    {}
}}]],
		{
			visibility(1, "public"),
			i(2),
			i(0),
		}
	),

	_p = fmt(
		[[{} function __construct(
    {}
) {{
}}]],
		{
			visibility(1, "public"),
			i(2),
		}
	),

	fn = {
		visibility(1, "public"),
		t(" function "),
		i(2, "name"),
		t("("),
		i(3, "$arg"),
		t(")"),
		c(4, {
			t(""),
			snippet_from_nodes(nil, {
				t(": "),
				i(1, "void"),
			}),
		}),
		newline("{"),
		newline("\t"),
		i(0, ""),
		newline("}"),
	},

	strict = t("declare(strict_types=1);"),
}

return M
