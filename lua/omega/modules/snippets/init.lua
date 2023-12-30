local snippets = {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    event = "InsertEnter",
    opts = function()
        return {
            update_events = { "TextChanged", "TextChangedI" },
            region_check_events = "InsertEnter",
            enable_autosnippets = true,

            ext_opts = {
                [require("luasnip.util.types").choiceNode] = {
                    active = {
                        virt_text = { { " ", "Keyword" } },
                    },
                },
                [require("luasnip.util.types").insertNode] = {
                    active = {
                        virt_text = { { "●", "Special" } },
                    },
                },
            },
        }
    end,
}

function snippets.config(_, opts)
    require("luasnip").setup(opts)
    local snip_expand = require("luasnip").snip_expand
    require("luasnip").snip_expand = function(...)
        vim.o.ul = vim.o.ul
        snip_expand(...)
    end
    require("omega.modules.snippets.lua")
    require("omega.modules.snippets.tex")
    require("omega.modules.snippets.typst")
end

return snippets
