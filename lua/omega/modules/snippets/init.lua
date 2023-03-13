local snippets = {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    event = "InsertEnter",
    opts = function()
        return {
            update_events = { "TextChanged", "TextChangedI" },
            region_check_events = "InsertEnter",

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
    require("omega.modules.snippets.lua")
    require("omega.modules.snippets.tex")
end

return snippets
