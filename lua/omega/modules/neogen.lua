local neogen = {
    "danymat/neogen",
    requires = { "LuaSnip" },
    config = function()
        require("neogen").setup({
            snippet_engine = "luasnip",
            enabled = true,
        })
    end,
}
return neogen
