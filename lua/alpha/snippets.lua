local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

ls.snippets = {
    php = {
        s("$", {
            t("$this->"),
        }),
        s("v", {
            t({ "/**", " * @var " }),
            i(1, "types"),
            t({""," */", "private $"}),
            i(2, "name"),
            t(";", ""),
        }),
        s("pf", {
            t("public function"), i(1, "name"), t("("), i(2, "$arg"), t(")"),
            t({"", "{"}),
            i(0, "    "),
            t({"", "}"})
        }),
    }
}
