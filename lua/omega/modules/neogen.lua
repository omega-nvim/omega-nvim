local neogen = {
    "danymat/neogen",
    requires = { "LuaSnip" },
    config = function()
        require("neogen").setup({
            snippet_engine = "luasnip",
            enabled = true,
        })
    end,
    keys = {
        {
            "<leader>a",
            function()
                require("neogen").generate({ snippet_engine = "luasnip" })
            end,
            desc = "﨧Annotations",
        },
    },
}
return neogen
