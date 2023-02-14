local autopairs = {
    "windwp/nvim-autopairs",
    enabled = true,
    event = "InsertEnter",
}

autopairs.config = function()
    local Rule = require("nvim-autopairs.rule")
    local npairs = require("nvim-autopairs")
    require("nvim-autopairs").setup({
        ignored_next_char = "",
        disable_filetype = { "norg" },
    })
    npairs.add_rule(Rule("$", "$", "tex"))
end

return autopairs
