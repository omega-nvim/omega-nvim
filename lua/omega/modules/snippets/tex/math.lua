---@diagnostic disable: unused-local
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet

local in_mathzone = require("omega.utils").in_mathzone

local function reuse(idx)
    return f(function(args)
        return args[1][1]
    end, { idx })
end

ls.add_snippets("tex", {
    s({ trig = "vec" }, {
        c(1, {
            sn(nil, {
                t("\\vec{"),
                i(1),
                t("}"),
                i(0),
            }),
            sn(nil, {
                t({ [[\begin{pmatrix}]], "" }),
                i(1, "a"),
                t({ [[_x\\]], "" }),
                reuse(1),
                t({ [[_y]], "" }),
                t({ [[\end{pmatrix}]] }),
            }),
            sn(nil, {
                t({ [[\begin{pmatrix}]], "" }),
                i(1, "a"),
                t({ [[\\]], "" }),
                i(2, "a"),
                t({ "", "" }),
                t({ [[\end{pmatrix}]] }),
            }),
            sn(nil, {
                t({ [[\begin{pmatrix}]], "" }),
                i(1, "a"),
                t({ [[_x\\]], "" }),
                reuse(1),
                t({ [[_y\\]], "" }),
                reuse(1),
                t({ [[_z]], "" }),
                t({ [[\end{pmatrix}]] }),
            }),
            sn(nil, {
                t({ [[\begin{pmatrix}]], "" }),
                i(1, "a"),
                t({ [[\\]], "" }),
                i(2, "a"),
                t({ [[\\]], "" }),
                i(3, "a"),
                t({ "", "" }),
                t({ [[\end{pmatrix}]] }),
            }),
        }),
    }, {
        condition = function()
            return in_mathzone()
        end,
    }),

    s("bdm", {
        t([=[{\boldmath{$]=]),
        i(1),
        t([[$}}]]),
        i(0),
    }),

    s("RR", {
        t([=[\mathbb{]=]),
        i(i, "R"),
        t([=[}]=]),
        i(0),
    }, {
        condition = function()
            return in_mathzone()
        end,
    }),

    -- System of equations
    s("==", {
        t({ [=[\left[]=], "" }),
        t({ [[\begin{aligned}]], "" }),
        i(1),
        t({ [[&=]] }),
        i(2),
        t({ [[\\]], "" }),
        i(3),
        t({ [[&=]] }),
        i(4),
        t({ "", [[\end{aligned}]], "" }),
        t({ [=[\right]]=] }),
    }),

    s("<>", {
        t([[\Longleftrightarrow]]),
    }),

    s("->", {
        t([[\implies]]),
    }),

    s("frac", {
        t([[\frac{]]),
        i(1),
        t("}"),
        t("{"),
        i(2),
        t("}"),
    }),
})
