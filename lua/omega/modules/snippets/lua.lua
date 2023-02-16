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

local function reuse(idx)
    return f(function(args)
        return args[1][1]
    end, { idx })
end

local function_snippet = s("fn", {
    c(1, {
        sn(nil, {
            t("local function "),
            i(1),
            t("("),
            i(2),
            t({ ")", "    " }),
            i(3),
            t({ "", "end", "" }),
            i(0),
        }),

        sn(nil, {
            t("function("),
            i(1),
            t(")"),
            i(2),
            t(" end"),
            i(0),
        }),
        sn(nil, {
            t("function "),
            d(1, function()
                local line_count = vim.api.nvim_buf_line_count(0)
                local line = vim.api.nvim_buf_get_lines(0, line_count - 1, line_count, false)[1]
                local module = line:match("return ([%w_]+)")
                return sn(nil, {
                    i(1, module or ""),
                })
            end),
            t("."),
            i(2),
            t("("),
            i(3),
            t({ ")", "    " }),
            i(4),
            t({ "", "end", "" }),
            i(0),
        }),
    }),
})

ls.add_snippets("lua", {
    function_snippet,

    s("buf", {
        t("local buf = vim.api.nvim_create_buf(false,true)"),
    }),

    s("inc", {
        i(1, "thing"),
        t(" = "),
        reuse(1),

        t(" + "),
        i(2, "1"),
        i(0),
    }),

    s("dec", {
        i(1, "thing"),
        t(" = "),
        reuse(1),
        t(" - "),
        i(2, "1"),
        i(0),
    }),

    s("inspect", {
        t("print("),
        i(1, "variable"),
        t(")"),
        t("vim.pretty_print("),
        reuse(1),
        t(")"),
    }),
})
