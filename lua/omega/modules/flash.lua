local flash = {
    "folke/flash.nvim",
    opts = {
        jump = {
            autojump = true,
        },
        highlight = {
            label = {
                before = true,
                after = false,
            },
        },
    },
}
flash.keys = {
    {
        "s",
        mode = { "n", "x", "o" },
        function()
            require("flash").jump()
        end,
    },
    {
        "S",
        mode = { "o", "x" },
        function()
            require("flash").treesitter()
        end,
    },
}

return flash
