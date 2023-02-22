local snippets = { "L3MON4D3/LuaSnip", build = "make install_jsregexp", event = "InsertEnter" }

function snippets.config()
    require("luasnip").setup({ update_events = "TextChanged,TextChangedI", region_check_events = "InsertEnter" })
    require("omega.modules.snippets.lua")
    require("omega.modules.snippets.tex")
end

return snippets
