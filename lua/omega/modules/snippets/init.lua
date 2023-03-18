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
    local auto_expand = require("luasnip").expand_auto
    require("luasnip").expand_auto = function(...)
        vim.o.undolevels = vim.o.undolevels
        auto_expand(...)
    end
    require("omega.modules.snippets.lua")
    require("omega.modules.snippets.tex")
end

return snippets
