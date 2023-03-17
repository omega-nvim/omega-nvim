local autopairs = {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { ignored_next_char = "", disable_filetype = { "norg" } },
}

autopairs.config = function(_,opts)
    local Rule = require("nvim-autopairs.rule")
    local npairs = require("nvim-autopairs")
    require("nvim-autopairs").setup(opts)
    npairs.add_rule(Rule("$", "$", "tex"))
end

return autopairs
