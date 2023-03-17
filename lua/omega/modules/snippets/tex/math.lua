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

    s("CC", {
        t([=[\mathbb{C}]=]),
    }, {
        condition = function()
            return in_mathzone()
        end,
    }),

    s("II", {
        t([=[\mathbb{I}]=]),
    }, {
        condition = function()
            return in_mathzone()
        end,
    }),

    s("NN", {
        t([=[\mathbb{N}]=]),
    }, {
        condition = function()
            return in_mathzone()
        end,
    }),

    s("ZZ", {
        t([=[\mathbb{Z}]=]),
    }, {
        condition = function()
            return in_mathzone()
        end,
    }),

    s("RR", {
        t([=[\mathbb{R}]=]),
    }, {
        condition = function()
            return in_mathzone()
        end,
    }),

    s("fa", {
        t([=[\forall]=]),
    }, {
        condition = function()
            return in_mathzone()
        end,
    }),

    s("te", {
        t([=[\exists]=]),
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

    s("$$", {
        t({ [=[\[]=], "    " }),
        i(1),
        t({ "", [=[\]]=] }),
    }),

    s("ff", fmta("\\frac{<>}{<>}", { i(1), i(2) }), {
        condition = function()
            return in_mathzone()
        end,
    }),

    s("mm", fmta("$<>$", { i(1) })),

    -- expand to _0 but not inside numbers
    s(
        { trig = "([%a%)%]%}])00", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t("0"),
        }),
        {
            condition = function()
                return in_mathzone()
            end,
        }
    ),
    s({ trig = "df", snippetType = "autosnippet" }, { t("\\diff") }, {
        condition = function()
            return in_mathzone()
        end,
    }),

    s(
        "eq",
        fmta(
            [[
        \begin{equation}
            <>
        \end{equation}
        ]],
            { i(1) }
        )
    ),

    s("ee", fmta([[e^{<>}]], { i(1) }), {
        condition = function()
            return in_mathzone()
        end,
    }),

    s({ trig = ";a", snippetType = "autosnippet" }, {
        t("\\alpha"),
    }, {
        condition = function()
            return in_mathzone()
        end,
    }),

    s({ trig = ";b", snippetType = "autosnippet" }, {
        t("\\beta"),
    }, {
        condition = function()
            return in_mathzone()
        end,
    }),

    s({ trig = ";g", snippetType = "autosnippet" }, {
        t("\\gamma"),
    }, {
        condition = function()
            return in_mathzone()
        end,
    }),
})
