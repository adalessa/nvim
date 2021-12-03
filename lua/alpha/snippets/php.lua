local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
-- local f = ls.function_node
-- local l = require("luasnip.extras").lambda

-- visibility allows to reuse it pasing the first option to show for the
-- snippet
local visibility
visibility = function (_, _, _, initial_text)
    local possibles = {'private', 'public', 'protected'}
    local options = {}

    for _, value in pairs(possibles) do
        if value == initial_text then
            table.insert(options, 1, t(value .. ' ') )
        else
            table.insert(options, t(value .. ' '))
        end
    end

    return sn(nil, { c(1, options) })
end

local releation
releation = function (_, snip,_, type)
    local relationType = type
    local relationName = snip.captures[1]

    return sn(nil, {
        -- I would like t o auto import the relation but for now just ommit it
        -- t({"public function ".. relationName:gsub("^%u", string.lower) .. "(): " .. relationType:gsub("^%l", string.upper) , "{", ""}),
        t({"public function ".. relationName:gsub("^%u", string.lower) .. "()" , "{", ""}),
        t({"\treturn $this->".. relationType .. "(".. relationName .. "::class);", "}"}),
    })
end

local promo_property
promo_property = function()
    return sn(
        nil,
        c(1, {
            -- Order is important, sn(...) first would cause infinite loop of expansion.
            t(""),
            sn(nil, {
                t({ "", "\t" }),
                d(1, visibility, {}, "private"),
                i(2, '$var'),
                t(","),
                d(3, promo_property, {})
            }),
        })
    )
end

ls.snippets = {
    php = {
        -- variable
        s("v", {
            t({ "/**", " * @var " }),
            i(1, "types"),
            t({""," */", "private $"}),
            i(2, "name"),
            t(";", ""),
        }),

        -- __construct
        s("_c", {
            d(1, visibility, {}, "public"),
            t('function __construct('),
            c(2, {
                sn(nil, {
                    i(1, '$var'),
                    t({")", "{", "\t"}),
                    i(2, ''),
                    t({"", "}"}),
                }),
                sn(nil, {
                    d(1, promo_property, {}),
                    t({"",") {", "}"}),
                }),
            }),
        }),

        -- function
        s("fn", {
            d(1, visibility, {}, "public"),
            t("function "),
            i(2, "name"),
            t("("),
            i(3, "$arg"),
            t(")"),
            c(4, {
                sn(nil, {
                    t(': '),
                    i(1, "void"),
                }),
                t(""),
            }),
            t({"", "{", ""}),
            t("\t"), i(0, ""),
            t({"", "}"})
        }),

        -- Route
        s("ro", {
            t("Route::"),
            c(1, {
                t("get"),
                t("post"),
                t("put"),
                t("view"),
            }),
            t("('"),
            i(2, "uri"),
            t("', "),
            c(3, {
                sn(nil, {
                    t({'function () {', '\t'}),
                    i(1, ''),
                    t({'', '});'}),
                }),
                sn(nil, {
                    t('['),
                    i(1, 'Controller'),
                    t("::class, '"),
                    i(2, 'method'),
                    t("']);"),
                })
            }),
        }),
    }
}

local relationTypes = {"hasOne", "belongsTo", "hasMany", "belongsToMany"}
for _, type in pairs(relationTypes) do
    table.insert(ls.snippets.php,
        s(
            { trig= type .. "(.*)", regTrig=true },
            {
                d(1, releation, {}, type),
            }
        )
     )
end
